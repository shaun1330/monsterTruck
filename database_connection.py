import mysql.connector

class MydatabaseConnection:
    def __init__(self, user, password, host, database):
        self.user = user
        self.host = host
        self.database = database
        self.db = mysql.connector.connect(
            user=user,
            password=password,
            host=host,
            database=database,
            autocommit=False)
        print(f'Connected to {database}')
        if self.db.is_connected():
            self.db_Info = self.db.get_server_info()
            self.cursor = self.db.cursor()
        else:
            raise Exception('Database Connection Failed')

    def query(self, query):
        self.cursor.execute(query)
        results = self.cursor.fetchall()
        return results

    def insert(self, query):
        self.cursor.execute(query)

    def test(self):
        print('test')

    def reconnect(self):
        self.db.reset_session()

    def commit(self):
        self.db.commit()

    def start_transaction(self):
        self.db.start_transaction()

    def rollback(self):
        self.db.rollback()

    def in_transaction(self):
        return self.db.in_transaction()

    def is_connect(self):
        return self.db.is_connected()


def errors():
    errors = mysql.connector.errors
    return errors


