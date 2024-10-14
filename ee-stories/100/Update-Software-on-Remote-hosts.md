
# Update Software on Remote hosts
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a** developer
**I WANT** all of my remote hosts running the latest software
**SO** that I do not have security breaches or other issues.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

This story is cut from a series of Shepard risks addressing Software and operating system updates that have not 'taken'.

For Linux hosts, the script below can be used:

```
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oConnectTimeout=5 '' 'echo 1'
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -G '' -t 'exit;';
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null '' -t 'yes | sudo yum update; sudo /apollo/bin/apollo-update-rpm;';
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null '' -t 'yes | sudo yum update kernel;';
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null '' -t 'yes | sudo yum update libfastjson babel systemd cpio vim sudo libxml2 libdb nss glib2 perl krb5 freetype libtasn1 libpng;';
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null '' -t 'yes | sudo rpm -Uvh --force https://s3.amazonaws.com/amazon-vm-agent/vm-agent-publicaws-0.1-0.x86_64.rpm;';
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null '' -t 'yes | sudo yum update -y --security --releasever=latest;';
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null '' -t 'yes | sudo yum update -y --security --releasever=latest --cve CVE-2018-12126 --cve CVE-2018-20483 --cve CVE-2018-16509 --cve CVE-2017-16844 --cve CVE-2019-0232 --cve CVE-2019-12735 --cve CVE-2019-14287;';
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null '' -t 'wget -q https://s3.amazonaws.com/amazon-vm-agent/vm-agent-publicaws-0.1-0.x86_64.deb && sudo dpkg --force-all -i vm-agent-publicaws-0.1-0.x86_64.deb && rm -f vm-agent-publicaws-0.1-0.x86_64.deb; sudo apt-get -y update; sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade;';
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null '' -t -t -o ServerAliveInterval=1 -o ServerAliveCountMax=1 'export PATH=\'/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/mysql-client/bin:/Users/ailor/.toolbox/bin:/Users/ailor/bin:/Users/ailor/codechecker/build/CodeChecker/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/TeX/texbin:/opt/homebrew/opt/python3/libexec/bin:/usr/local/opt/mongodb/bin/mongoexport:/Users/ailor/scripts/:/Users/ailor/.scripts/:/Users/ailor/git-extra-commands/bin/:/usr/local/Cellar/node/11.6.0/bin/:/Users/ailor/.scarf/bin/:/opt/homebrew/Cellar/node/21.7.1/bin/:/opt/homebrew/Cellar/node/22.0.0/bin/:/opt/homebrew/Cellar/node/22.1.0/bin/:/opt/homebrew/Cellar/node/22.9.0/bin:/opt/homebrew/Cellar/node/:/Users/ailor/.odin-tools/env/OdinRetrievalScript-1.0/runtime/bin:/usr/sbin\'; echo \'shutdown\'; sudo shutdown -r now; echo \'rebooting\'; sudo reboot;';
```

This script verifies the existence of the host, connects, and runs the updates that have been observed so far.
For Windows hosts, you can either connect to the host - or force a replacement. The replacement seems to come with the latest software.

We should attempt to prevent this in the future, so take the time to think about how to automate this process in the future.

The list of Shepherd risks to address:
https://shepherd.a2z.com/issues/557ec447-166d-41a3-8ae8-a8f2a73d2083
https://shepherd.a2z.com/issues/4b02adb8-c687-49f2-81b6-95c97af06422
https://shepherd.a2z.com/issues/1a44f05f-2101-4154-9f0b-31ee2c9465d8
https://shepherd.a2z.com/issues/1d6f35c2-2c0d-4a48-adec-a1bb0a8f637d
https://shepherd.a2z.com/issues/391e03a8-5ef3-4469-8323-6d48dcd71240
https://shepherd.a2z.com/issues/4015cc0f-1c31-4d30-8314-04387be37afe
https://shepherd.a2z.com/issues/60aec89d-8750-47c8-8940-c9da22a9710d
https://shepherd.a2z.com/issues/03a4b7f2-e2e9-430e-95a0-52d01e579303
https://shepherd.a2z.com/issues/ba4f8393-464a-4146-89e6-9610025bb9b7
https://shepherd.a2z.com/issues/832c675d-db57-4f7d-85d7-144e391726fd
https://shepherd.a2z.com/issues/e78067b7-161e-4d28-9968-2f8bf0211e20
https://shepherd.a2z.com/issues/a1234909-446d-40ff-804e-7cc70980cb22

and associated tickets:
https://sim.amazon.com/issues/KRL-15675
https://sim.amazon.com/issues/KRL-15678
https://sim.amazon.com/issues/KRL-16023
https://sim.amazon.com/issues/KRL-16031
https://sim.amazon.com/issues/KRL-16084
https://sim.amazon.com/issues/KRL-16087
https://sim.amazon.com/issues/KRL-16124

Need help fixing or have questions about your specific issue? Contact the campaign owner using the 'Get Support' section on the right hand side of the issue details page.

*Warning*:

- Do NOT manually close this ticket. This ticket will automatically resolve once all issues have been fixed, and closing it prematurely may cause Shepherd to reopen it.
- Do NOT change the ticket severity. Shepherd automatically updates the severity based on the highest severity issue it contains.
- If you are not the correct owner of the issue(s) listed on this ticket, you will need to transfer the resource (typically a bindle) to the correct owner. Information about transferring the resource is available in the FAQ: https://w.amazon.com/?Shepherd/FAQ#HWhatshouldIdoifanissueorticketisincorrectlyassignedtome3F.
- Do not reassign this ticket to the Shepherd team. The team has no access/permissions to view/modify the resources in scope of this ticket.

For overall health of your applications, please visit: https://shepherd.a2z.com.

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have Updated all hosts listed in the above Shepherd risks
- Should have monitored tickets for 48 hours to ensure tickets close
- Should have created a script or ticket to help reduce this burden in the future
- Should have created an OE Spike to look into preventing these risk types post N-AWS.

