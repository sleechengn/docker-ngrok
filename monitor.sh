#!/usr/bin/bash
export LANG="C.UTF-8"
if [ -n "$SMTP_HOST" ]; then
  while true
  do
  if [ -e "/tmp/pub_url" ]; then
        PUB_URL=$(head -n +1 /tmp/pub_url)
	echo "存在记录文件，读取值"
        echo $PUB_URL
	if [ -n "$PUB_URL" ] && [ "$PUB_URL" != "null" ];then
		echo "有变量值"
		NEW_URL=$(curl http://127.0.0.1:4040/api/tunnels|jq --raw-output '.tunnels[0].public_url')
		if [ -n "$NEW_URL" ] && [ "$NEW_URL" != "null" ]; then
			if [[ "$NEW_URL" != "$PUB_URL" ]];then
				echo $NEW_URL
	                        echo $NEW_URL > /tmp/pub_url
				#发送邮件开始
	                        java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $NEW_URL
	                        sleep 1
	                        java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $NEW_URL
	                        sleep 1
	                        java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $NEW_URL
	                        #发送邮件结束
			fi
		else
			rm -rf /tmp/pub_url
		fi
	else
		echo "无变量值"
		PUB_URL=$(curl http://127.0.0.1:4040/api/tunnels|jq --raw-output '.tunnels[0].public_url')
        	if [ -n "$PUB_URL" ] && [ "$PUB_URL" != "null" ];then
                	echo $PUB_URL
	                echo $PUB_URL > /tmp/pub_url
			#发送邮件开始
	                java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $PUB_URL
        	        sleep 1
	                java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $PUB_URL
                	sleep 1
        	        java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $PUB_URL
	                #发送邮件结束
	        else
        	        echo "程序可能还未初始化"
	        fi
	fi
  else
        echo "不存在记录文件，初始化"
        PUB_URL=$(curl http://127.0.0.1:4040/api/tunnels|jq --raw-output '.tunnels[0].public_url')
	if [ -n "$PUB_URL" ] && [ "$PUB_URL" != "null"  ] ;then
		echo "初始化成功"
        	echo $PUB_URL
	        echo $PUB_URL > /tmp/pub_url

		#发送邮件开始
		java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $PUB_URL
		sleep 1
		java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $PUB_URL
		sleep 1
		java -jar /opt/bin/mail-cli.jar $SMTP_HOST $SMTP_PORT $SMTP_FROM $SMTP_USER $SMTP_PASSWD $SMTP_TO "$MSUBJECT" $PUB_URL
		#发送邮件结束
	else
		echo "初始化失败"
	fi
  fi
  sleep 2
  done
fi
