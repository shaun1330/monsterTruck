
import mysql.connector
import pymysql.cursors


from config.settings import *


class MydatabaseConnection:
    def __init__(self, port):
        self.user = SSH_USERNAME
        self.host = DB_HOST
        self.database = DB_NAME
        # self.errors = mysql.connector.errors


        self.db = pymysql.connect(
            user=SSH_USERNAME,
            password=DB_PASSWORD,
            host=DB_HOST,
            database=DB_NAME,
            port=port
            )
        print(f'Connected to {DB_NAME}')

        self.cursor = self.db.cursor()


    def query(self, query):
        self.cursor.execute(query)
        results = self.cursor.fetchall()
        return results

    def insert(self, query):
        self.cursor.execute(query)

    def test(self):
        print('test')

    # def reconnect(self):
    #     self.db.reset_session()

    def commit(self):
        self.db.commit()

    # def start_transaction(self):
    #     self.db.start_transaction()

    def rollback(self):
        self.db.rollback()

    # def in_transaction(self):
    #     return self.db.in_transaction()
    #
    def is_connect(self):
        return self.db.open

    def sanitise(self, string):
        return string


# def errors():
#     errors = mysql.connector.errors
#     return errors


if __name__ == '__main__':
    db = MydatabaseConnection()


