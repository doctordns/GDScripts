# in case
"removing old network mappings just in case"
net use p: /delete
# map drives
net use p: \\cookham1\p$
"you should see p: point to cookham1 !!"
net use
# now robocopy jerry dead stuff

Robocopy "n:\jerry Garcia"  "p:\jerry Garcia" /mir /E /Z 