crontab -l > mycron
echo "1 * * * * python3 /srv/src/monitor_node_health.py > /var/log/cron.log" >> mycron
crontab mycron
rm mycron
