import json

from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent

variable_settings_file = open( BASE_DIR / 'settings.json', 'r')
variable_settings = json.load(variable_settings_file)

EMAIL = variable_settings['EMAIL']
EMAIL_PASSWORD = variable_settings['EMAIL_PASSWORD']
EMAIL_HOST = variable_settings['EMAIL_HOST']
EMAIL_PORT = variable_settings['EMAIL_PORT']
DB_PASSWORD = variable_settings['DB_PASSWORD']
DB_HOST = variable_settings['DB_HOST']
DB_NAME = variable_settings['DB_NAME']
SSH_HOSTNAME = variable_settings['SSH_HOSTNAME']
SSH_USERNAME = variable_settings['SSH_USERNAME']
SSH_PASSWORD = variable_settings['SSH_PASSWORD']
REMOTE_BIND_ADDRESS = variable_settings['REMOTE_BIND_ADDRESS']


if __name__ == '__main__':
    print(EMAIL)
    print(EMAIL_PASSWORD)
    print(EMAIL_HOST)
    print(EMAIL_PORT)
    print(DB_NAME)
    print(DB_HOST)
    print(DB_PASSWORD)
    print(SSH_HOSTNAME)
    print(SSH_USERNAME)
    print(SSH_PASSWORD)
    print(REMOTE_BIND_ADDRESS)