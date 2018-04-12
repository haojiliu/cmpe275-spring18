#!/usr/bin/python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import  MIMEText

def send(sender, password, receivers, subject, body):

    server = smtplib.SMTP('smtp.gmail.com', 587)


    server.ehlo()
    server.starttls()
    server.login(sender, password)

    msg = MIMEMultipart()
    msg['Subject'] = subject
    msg['From'] = sender
    msg['To'] = ','.join(receivers)
    msg.attach(MIMEText(body, 'plain'))
    txt = msg.as_string()
    #message = "From:" + sender + "\n" + subject + "\n" + body
    try:
        # smtpObj = smtplib.SMTP('localhost')
        # smtpObj.sendmail(sender, receivers, message)
        server.sendmail(sender, receivers, txt)
        print("Successfully sent email")
        return True
    except:
        print("Error: unable to send email")
        return False
