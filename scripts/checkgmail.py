#!/usr/bin/env python

import urllib
import feedparser
import sys

_url = "https://mail.google.com/gmail/feed/atom"
_pwd = "2030327abc"
_username = "sergeykozak95@gmail.com"
_widgetName = "emailbox"

class GmailRSSOpener(urllib.FancyURLopener):
    def prompt_user_passwd(self, host, realm):
	return (_username, _pwd)


def auth():
    opener = GmailRSSOpener()
    f = opener.open(_url)
    feed = f.read()
    return feed

def getUnreadMsgCount(feed):
    atom = feedparser.parse(feed)
    newmails = len(atom.entries)
    return newmails

if __name__ == "__main__":
    if len(sys.argv) > 1:
        _widgetName = sys.argv[1]
    feed = auth()
    print "0 widget_tell %s %d" % (_widgetName, getUnreadMsgCount(feed))

