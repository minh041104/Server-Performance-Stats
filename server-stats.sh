#!/bin/bash

echo "===== SERVER PERFORMANCE STATS ====="
echo

# OS version
echo ">>> OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"'
echo

# Uptime
echo ">>> Uptime:"
uptime -p
echo

# Load Average
echo ">>> Load Average (1m, 5m, 15m):"
uptime | awk -F'load average: ' '{ print $2 }'
echo

# Logged in users
echo ">>> Logged in users:"
who | wc -l
echo

# CPU usage
echo ">>> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'
echo

# Memory usage
echo ">>> Memory Usage:"
free -h | awk 'NR==2{printf "Used: %s / %s (%.2f%%)\n", $3,$2,$3*100/$2 }'
echo

# Disk usage
echo ">>> Disk Usage (/):"
df -h / | awk 'NR==2{printf "Used: %s / %s (%s)\n", $3,$2,$5}'
echo

# Top 5 processes by CPU usage
echo ">>> Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 processes by Memory usage
echo ">>> Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# Stretch Goal: Failed login attempts
echo ">>> Failed Login Attempts:"
journalctl _COMM=sshd | grep "Failed password" | wc -l
echo

echo "===== END OF REPORT ====="
