NGROK 映射公网

查看页面 http://ip:3999

实例
```
networks:
  bridge:
    driver: "bridge"
services:
  fnos:
    container_name: "fnos"
    hostname: "fnos"
    image: "sleechengn/ngrok:latest"
    restart: always
    environment:
      TOKEN: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      URL: http://192.168.13.116:8000
      DOMAIN: "xxxx.ngrok-free.app"  #可以不用，自动生成域名，发送到下面配置的邮箱
      SMTP_HOST: "smtp.qq.com"
      SMTP_PORT: "587"
      SMTP_USER: "xxxxxx@qq.com"
      SMTP_PASSWD: "xxxxxxxx"
      SMTP_FROM: "xxxxxx@qq.com"
      SMTP_TO: "xxx@live.cn"  #发送邮件的目票
      MSUBJECT: "飞牛NAS"  #邮件主题
    networks:
      - "bridge"
```
