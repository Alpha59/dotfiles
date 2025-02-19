import logging
from datetime import datetime
from email.encoders import encode_base64
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from typing import List

import boto3
import icalendar
import pytz
from flask import current_app

from office_hour_scheduler_lambda.blueprints.office_hour_scheduler.model.db import (
    Meeting,
    Schedule,
    SlotAllocationAttribute,
)


def get_domain():
    if current_app.config.domain:
        return current_app.config.domain
    else:
        logging.warn(
            f"Config domain not set, using default with stage {current_app.config.stage}"
        )
        return f"{current_app.config.stage}.office-hour-scheduler.tools.aws.dev"


def create_ical_attachment(
    start_date: datetime,
    end_date: datetime,
    attendees: List[str],
    sender: str,
    title: str,
    description: str,
    location: str,
    unique_id: str,
    cancellation: bool = False,
):
    status = "CONFIRMED"
    method = "REQUEST"
    if cancellation:
        status = "CANCELLED"
        method = "CANCEL"

    cal = icalendar.Calendar()
    cal.add("prodid", f"-//OfficeHourScheduler//{get_domain()}//")
    cal.add("version", "2.0")
    cal.add("method", method)

    event = icalendar.Event()

    event.add("status", status)
    event.add("category", "Event")

    for attendee in attendees:
        event.add(
            "ATTENDEE;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=FALSE", attendee
        )

    event.add("organizer", sender)
    event.add("summary", title)
    event.add("description", description)
    event.add("location", location)

    # Convert timezone to UTC, allow user's outlook to convert to local time
    event.add("dtstart", start_date.astimezone(pytz.UTC))
    event.add("dtend", end_date.astimezone(pytz.UTC))

    event.add("dtstamp", datetime.now())
    event["uid"] = unique_id
    event.add("priority", 5)
    event.add("sequence", 1)
    event.add("created", datetime.now())

    # Reminder
    alarm = icalendar.Alarm()
    alarm.add("action", "display")
    alarm.add("description", "reminder")
    alarm.add("TRIGGER;RELATED=START", "-PT15M")

    event.add_component(alarm)
    cal.add_component(event)

    attachment = MIMEBase("text", "calendar", method=method, filename="invite.ical")
    attachment.set_payload(cal.to_ical())
    encode_base64(attachment)
    attachment.add_header("Content-Description", "invite.ical")
    attachment.add_header("Content-class", "urn:content-classes:calendarmessage")
    attachment.add_header("Filename", "invite.ical")
    attachment.add_header("Path", "invite.ical")

    return attachment


def send_email(message: MIMEMultipart, sender: str, recipients: List[str]):
    logging.info(f"Sending email to {recipients} from {sender}: {message.as_string()}")

    ses = boto3.client("ses", region_name="us-west-2")
    ses.send_raw_email(
        Source=sender, Destinations=recipients, RawMessage={"Data": message.as_string()}
    )


def send_attendee_appointment(
    meeting: Meeting,
    schedule: Schedule,
    allocation: SlotAllocationAttribute,
    cancellation: bool = False,
):
    sender = f"no-reply@{get_domain()}"
    recipients = [f"{allocation.creator}@amazon.com"]
    subject = f"{schedule.name} slot allocated"
    if cancellation:
        subject = f"{schedule.name} slot allocation cancelled"
    description = f"You have allocated a slot on {schedule.name}."

    message = MIMEMultipart("alternative")
    message["Subject"] = subject
    message["To"] = recipients[0]
    message["From"] = sender
    message["Content-class"] = "urn:content-classes:calendarmessage"

    message_html_intro = f"You have allocated a slot on {schedule.name}."

    html_body = f"""\
    <html>
        <body>
        <p>
            {message_html_intro}
        </p>
        <p>
            Allocation details: <br> <br>
            {schedule.html_format_slot_allocation_details(allocation.details)}
        </p>
        <p>Meeting location: {meeting.room}</p>
        <p>To manage your allocation, <a href="https://{get_domain()}/schedule/{schedule.id}">refer to the schedule</a>.
        </body>
    </html>
    """  # noqa

    message.attach(MIMEText(html_body, "html"))

    message.attach(
        create_ical_attachment(
            start_date=meeting.start_datetime,
            end_date=meeting.end_datetime,
            attendees=recipients,
            sender=sender,
            title=subject,
            description=description,
            location=meeting.room,
            unique_id=allocation.slot_id,
            cancellation=cancellation,
        )
    )

    send_email(message, sender, recipients)


def send_organizer_appointment(
    meeting: Meeting, schedule: Schedule, cancellation: bool = False
):
    if not schedule.organizer_email_addresses:
        logging.info("Skipping sending messages as no organizer emails are defined")
        return

    sender = f"no-reply@{get_domain()}"
    recipients = schedule.organizer_email_addresses

    meeting_subject = schedule.get_default_meeting_type().get_meeting_invite_subject(
        schedule, meeting
    )

    if cancellation:
        subject = f"{schedule.name} meeting cancelled (no slots allocated)"
    elif meeting_subject:
        subject = meeting_subject

    description = f"Organizer update for meeting on {schedule.name}."

    message = MIMEMultipart("alternative")
    message["Subject"] = subject
    message["To"] = ", ".join(recipients)
    message["From"] = sender
    message["Content-class"] = "urn:content-classes:calendarmessage"

    html_body = f"""\
    <html>
        <body>
        <p>{schedule.name} meeting has been updated.</p>
        <p>
            Slot allocation details: <br> <br>
    """

    for allocation in meeting.slot_allocations:
        html_body += f"""
            Allocated by: {allocation.creator} <br>
            {schedule.html_format_slot_allocation_details(allocation.details)} <br> <br>
        """

    html_body += f"""
        </p>
        <p>Meeting location: {meeting.room}</p>
        <p>Manage this schedule <a href="https://{get_domain()}/schedule/{schedule.id}">here</a>.
        </body>
    </html>
    """  # noqa

    message.attach(MIMEText(html_body, "html"))

    message.attach(
        create_ical_attachment(
            start_date=meeting.start_datetime,
            end_date=meeting.end_datetime,
            attendees=recipients,
            sender=sender,
            title=subject,
            description=description,
            location=meeting.room,
            unique_id=meeting.id,
            cancellation=cancellation,
        )
    )

    send_email(message, sender, recipients)
