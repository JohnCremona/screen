This repository contains scripts and configuration files for a
computer to drive the screen in the Mathematics Common Room.  It is
stored at xentu.lnx.warwick.ac.uk which runs gitlab: see
https://xentu.lnx.warwick.ac.uk/. Login with LDAP and standard Warwick
username and password.  The gitlabadmin account is run by John
Cremona.

Summary: (1) The script getseminarspage fetches every 10 minutes the page
of seminars from a webserver. (2) The script start-screen starts a
browser pointing to that page, in full-screen mode; it is configured
to auto-refresh.  This script also simulates a press of the Home button
in the browser window if nothing else has been pressed for 30 seconds.

All this currently runs on a Toshiba netbook with ubuntu 16.04
installed.  The netbook automatically logs in the user 'seminars' when
it starts up.  The 'seminars' user runs the following automatically on
login (configure with gnome-session-properties):

 - evrouter: configures the Griffin Powermate so that pressing the
   button simulates pressing the Home key, to return the browser page
   to the top; turning right or left simulates pressing Down and Up to
   enable scrolling of the browser.  The configuration is in the file
   /home/seminars/.evrouterrc.  This was installed from the package
   evrouter_0.4_i386.deb as it is not in standard ubuntu repositories.

 - getseminarspage: a bash script which runs in an infinite loop with
   600s delay.  On each cycle it fetches the page
   www.maths.warwick.ac.uk/maths/seminars/display.html.  This file has
   a checksum at the end; the script strips it off and runs the script
   checkdisplaypage to recompute it and compare.  If anything is amiss
   it outputs an error message to the logfile, and adds a red dot in
   the top right corner of the page; otherwise it copies the new page
   (still without the checksum) to www/display.html which is where the
   browser is pointing.

 - start-screen: a bash script which starts the browser (chromium) in
   full-screen mode with no scrollbars, pointing at www/display.html
   and configured to auto-refresh, then goes into an infinite loop
   with 30s delay, testing (using xprintidle) whether no actions have
   been performed for 30s and if so, using xdotool to simulate
   pressing the Home key.  This is so that if someone scrolls down
   using the Griffin and does not scroll back, it automatically
   returns to the top in at most 60s.

 - opens a terminal window.

For maintenance while running, it is possible to remotely log in to
the 'seminars' account (which has no special privileges except the
ability to run evrouter) or the 'admin' account which has sudo
privileges.  The current IP address is 137.205.57.24 but this might
change after a reboot.  Alternatively, from the console one can get
out of full-screen mode with F11 (or if that fails, right click the
mouse and select the appropriate menu option) and then recover the
terminal window.
