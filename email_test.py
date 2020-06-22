import smtplib
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email import encoders


class Emailer:
    def __init__(self, subject, body, sender, reciever,  password, attachment_name=None, folder=None):
        self.password = password
        self.subject = subject
        self.body = body
        self.sender_email = sender
        self.receiver_email = reciever

        message = MIMEMultipart()

        message['From'] = self.sender_email
        message['To'] = self.receiver_email
        message['Subject'] = self.subject

        message.attach(MIMEText(self.body, 'plain'))

        if attachment_name != None:
            filename = f'.\\{folder}\\'+ attachment_name
            attachment = open(filename, 'rb')
            part = MIMEBase('application', 'octet_stream')
            part.set_payload(attachment.read())
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', 'attachment; filename= '+attachment_name)
            message.attach(part)

        text = message.as_string()
        try:
            server = smtplib.SMTP(host='smtp.iprimus.com.au', port=587)  # host='smtp.iprimus.com.au'
            server.starttls()
            server.login(self.sender_email, self.password)
            server.sendmail(self.sender_email, self.receiver_email, text)
        except Exception as e:
            print(e)
            self.status = '0'
        else:
            self.status = '1'
            server.quit()

    def get_status(self):
        return self.status

# Emailer('Email through Python',
#         'Test',
#         'shaunyb101@gmail.com',
#         'shaunsimons93gmail.com'
#         )
