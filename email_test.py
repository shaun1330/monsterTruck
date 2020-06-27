import smtplib
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email import encoders


class Emailer:
    def __init__(self, subject, body, sender, receiver,  password, email_host, email_port, attachment_path=None, filename=None):
        self.password = password
        self.subject = subject
        self.body = body
        self.sender_email = sender
        self.receiver_email = receiver

        message = MIMEMultipart()

        message['From'] = self.sender_email
        message['To'] = self.receiver_email
        message['Subject'] = self.subject

        message.attach(MIMEText(self.body, 'plain'))

        if attachment_path != None:
            attachment = open(attachment_path, 'rb')
            part = MIMEBase('application', 'octet_stream')
            part.set_payload(attachment.read())
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', 'attachment; filename= '+str(filename))
            message.attach(part)

        text = message.as_string()
        try:
            server = smtplib.SMTP(host=email_host, port=email_port)
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

