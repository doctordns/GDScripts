# in case
net use x: /delete
net use y: /delete

# map drives
net use x: \\cookham8\M$
net use y: \\cookham8\n
net use
# now robocopy music

Robocopy y:\music  r:\music  /mir /E /Z