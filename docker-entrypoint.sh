#!/usr/bin/bash
if [ ! -e "/root/.config/ngrok/ngrok.yml" ];then
	/opt/ngrok-stable/ngrok config add-authtoken $TOKEN
fi

/usr/sbin/nginx -c /etc/nginx/nginx.conf

if [ -e "/config.sh" ]; then
	/config.sh
	rm -rf config.sh
fi

export LANG="C.UTF-8"

nohup /monitor.sh &

if [ -n "$DOMAIN"  ]; then
	/opt/ngrok-stable/ngrok http $URL --domain $DOMAIN
else
	/opt/ngrok-stable/ngrok http $URL
fi
