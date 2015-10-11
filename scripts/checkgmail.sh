#!/bin/sh
# awesome-gmail for awesome-2.3 by ljcohen 04 July 2008
# lines like the one below are test code - uncomment for debugging
## test commands ## any comments about test commands
#
# You need the following in your .awesomerc section "statusbar mystatusbar"
# textbox gmail {
#     text_align = "center"  mouse { button = "1" command = "spawn" arg = "exec touch /dev/shm/gmail-ack-$USER" }
#               }
# You can run multiple account checks in the same textbox. Just offset them in your
# .xinitrc or .xprofile like this (see usage below):
# /usr/bin/awesome-gmail firstaccount password 6 & # start first account 
# ( sleep 3m ; /usr/bin/awesome-gmail nextaccount password 6 & ) & # start next account
#
############ code starts here ###########
 if [ $# -ne 3 ]; then # 
    echo Usage: $(basename $0) username password interval-in-minutes
    exit 1
 fi
#
 until [ -S ~/.awesome_ctl.0 ] ; do  # wait until awesome starts (if started in .xinitrc for example)
   sleep 2s
 done
# 
############### real stuff starts here #################
 GMUSER=$1
 PASSWD=$2
 INTERVAL=$3
# NOTE - /dev/shm is temporary ram file system. files disappear at reboot 
 CFILE=/dev/shm/gmail-ack-$USER	# file exists only when alert acknowledged
 GFILE=/dev/shm/gmail-$GMUSER	# working copy of latest feed contents
 IFILE=~/.gmail-lid-$GMUSER	# contains last id for after reboot/restart
 LASTID=0			# default last id
 GURL="https://mail.google.com/mail/feed/atom"  # feed url
#    
 if [ -f $IFILE ] ; then	# check for saved count file
     LASTID=$(cat $IFILE)	# and retrive last id 
  else
     echo 0 >$IFILE		# otherwise create one with id of 0 
 fi
#
 while [ -S ~/.awesome_ctl.0 ] ; do  # exit if awesome is not running
 GOGET=1
 until [ $GOGET -eq 0 ] ; do # wait for connection
  # use line below if package ca-certificates is not installed - MAY BE SECURITY RISK!
  # MCOUNT=$(wget -qO- --no-check-certificate --http-user=$GMUSER --http-password=$PASSWD $GURL | grep fullcount)
  wget -qO $GFILE --http-user=$GMUSER --http-password=$PASSWD $GURL
  GOGET=$?
  ## echo goget=$GOGET ##
  if [ $GOGET -eq 1 ] ; then
     echo 0 widget_tell mystatusbar gmail text "" | awesome-client
     sleep 1m
    else
     GOGET=0
  fi 
  done  
  MCOUNT=$(cat $GFILE | grep fullcount)
  ## echo $MCOUNT ## looks like <fullcount>36</fullcount>
  MCOUNT=${MCOUNT#<*>} # strips <fullcount>
  MCOUNT=${MCOUNT%<*>} # strips </fullcount> and leaves just number of emails
  ## echo Count=$MCOUNT ##
  if [ $MCOUNT -ne 0 ] ; then # there is an id, so process it
     ID=$(cat $GFILE | grep "<id>")
     # each ID looks like <id>tag:gmail.google.com,2004:1274193124735397341</id>
     # the string may contain many, we just take the first one (newest always first)
     ID=`expr substr "$ID" 31 19` 
     # ID now looks like 1274193124735397341
     ## echo lastid=$LASTID ; echo now-id=$ID ##
   else # there are no unread emails at all
     ID=0 ; LASTID=0
       if [ `cat $IFILE` -ne 0 ] ; then 
          echo 0 >$IFILE  # clear the saved id
       fi
  fi  
#
  if [ $ID -gt $LASTID ] ; then # a new email is on top
     LASTID=$ID			# update pointer
     echo $LASTID >$IFILE	# and update file
     rm -f $CFILE		  # loose (false) acknowledgement file
     	while [ ! -f $CFILE ] ; do # flash the statusbar textbox
	     echo 0 widget_tell mystatusbar gmail text " [*******] " | awesome-client
	     # beep -f 1000
	     sleep 2
	     echo 0 widget_tell mystatusbar gmail text " [$GMUSER] " | awesome-client
	     sleep 2
        done
     rm -f $CFILE # get rid of alert acknowledgement file
  fi
  ##  date ## for checking sleep interval
# line below shows account checked, number of unread emails and time of last check
#  echo 0 widget_tell mystatusbar gmail text " [$GMUSER($MCOUNT)@`date +\"%H:%M\"`] " | awesome-client
  echo 0 widget_tell mystatusbar gmail text " [$GMUSER-$MCOUNT] " | awesome-client
  sleep $INTERVAL"m"  # wait for next check
 done
#
 exit 0