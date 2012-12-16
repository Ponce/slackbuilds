watchfor /Failed password for invalid user \w+ from ([\d\.]+) port/
    exec "/usr/sbin/sshblock.pl $1"
    threshold track_by=$1, type=threshold, count=3, seconds=90

watchfor /Failed password for root from ([\d\.]+) port/
    exec "/usr/sbin/sshblock.pl $1"
    threshold track_by=$1, type=threshold, count=3, seconds=30

