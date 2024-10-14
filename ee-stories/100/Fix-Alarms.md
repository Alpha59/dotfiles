
# Fix Alarms
## Summary:
As a developer with an on-call shift, I want the least sensitive alarms which will still notify me of issues in the system so that I can more aptly address issues without being overwhelmed by poor alarms.

As a pedigree user of any kind, I want the system to notify developers automatically of any issues, so that I do not need to cut them a ticket after an issue has already become blocking.


## Motivation:
In order to improve our developers lives, and ensure that our system is still properly monitored, we want to reduce the number of alarms that are set off based on transient issues or user error.


## Acceptance Criteria:
This story is completed when:

Given that the pedigree system is running
When there is a bug or issue with the code
Then I want an alarm to be triggered.

When there is a transient issue
Then I do not want to be notified by alarm

When there is a small series of user errors
Then I do not want to be notified by alarm

When there is any non-issue
Then I do not want to be notified by alarm

## Details:
Alarms need to be updated, and should all be running through Alarmist/Carnival or CloudWatch at this point.

Best practices are listed in the wikis below, but this story involves:

* Ensuring that all Fault/Errors are properly attributed
* Ensuring that alarms are configured through Alarmist (and configuring them if not)
* Ensuring that alarm sensitivity is adjusted based on their re-occurrence and resolution in the On-call queue.
* Changing the alarm parameters to be based on overall traffic and not individual params
* Running `alarmist publish` after alarms have been updated in the ion file.

Implementor judgement should be used in adjusting alarms to detect only real errors, and not false positives. Additional adjustments may be required after update if there is an un-expected on-call ticket change.

## Testing
This story will need to be tested anecdotally from viewing the on-call queue and user reports. Story can be closed after monitoring for a few days.

## External Links:
Link any external tickets/files which may be helpful in this story:
https://w.amazon.com/bin/view/Boli/Metrics_and_Alarm_Best_Practice/
https://w.amazon.com/bin/view/SOD/LOGEN/ELOR_Monitoring_and_Alarming/
https://w.amazon.com/bin/view/Alarmist/
