# Installation in zabbix

1. Put scripts in /etc/zabbix/externalscripts
2. Create host group with any comfortable name
3. Create a host (Attached file create_a_host.png)
4. Link Webchecks Template to the host (Attached file link_template.png)
5. Add following macros to the host:
 * {$URL} = https://profile-test-iep.imagination.net
 * {$USERNAME} = experience
 * {$PASSWORD} = 25st0rest

# Tepmlate overview

Template has 7 items. run_script item runs gathering info script every 3 minutes. Returns text value. Other 6 items run script every 200 seconds (to be shure they always run after run_script) and return numeric values.
Template has 4 triggers. Each of them alerts if return code of any operation differs from expected one. Alerts can be configured to email custom group of people.

# Scripts overview

1. imagination.sh

 * does all web checks (creating test profile and asossiated interaction, viewing test profile page and asossiated interaction page, deleting test profile and asossiated interaction)

 * measures download speed of profile view page and interaction view page and stores it in /tmp/userpage_speed.info and /tmp/interactionpage_speed.info e.g.

 * checks return codes of creating test profile request, creating asossiated interaction request, deleting test profile request, deleting interaction request and stores it in /tmp/profile_create_rc.info /tmp/interaction_create_rc.info /tmp/profile_delete_rc.info and /tmp/interaction_delete_rc.info e.g.

 **script takes approximately 10-15 seconds to finish**

2. imagination_profile_create_rc

 * returns answer code of a test profile creation request (200 if success)

3. imagination_interaction_create_rc

 * returns answer code of a test interaction creation request (200 if success)

4. imagination_profile_dspeed

 * returns download speed of a view test user profile page (in bps)

5. imagination_interaction_dspeed

 * returns download speed of a view test interaction page (in bps)

6. imagination_profile_delete_rc

 * returns answer code of a test profile deletion request (301 if success)

7. imagination_interaction_delete_rc

 * returns answer code of a test profile deletion request (301 if success)

**All scripts should be placed in /etc/zabbix/externalscripts/ directory**

