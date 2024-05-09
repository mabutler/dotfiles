#!/bin/bash

# if we're not actually running arch, bail out
if ! which pacman &>/dev/null; then
    exit 1
fi

lastUpdate=$(tac /var/log/pacman.log | grep -m1 -F "[PACMAN] starting full system upgrade" | cut -d "[" -f2 | cut -d "]" -f1)
daysSince=$((($(date +%s)-$(date --date="$lastUpdate" +%s))/3600/24))

if [ "$daysSince" -eq 0 ]; then
    exit 0
elif [ "$daysSince" -ge 7 ]; then
    tput setaf 1
else
    tput setaf 3
fi

echo "It's been over $daysSince day(s) since the last system update";

tput sgr0
