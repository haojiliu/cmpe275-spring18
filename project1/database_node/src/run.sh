mongod --fork --logpath /var/log/mongod.log
python3 /srv/src/heartbeat.py
python3 /srv/src/long_running_task.py
