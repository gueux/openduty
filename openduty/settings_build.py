import os

from environs import Env

from settings import *

env = Env()

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'openduty.db'),
    }
}

SECRET_KEY = '123'

DEBUG = True
TEMPLATE_DEBUG = True

BASE_URL = "http://localhost:8080"