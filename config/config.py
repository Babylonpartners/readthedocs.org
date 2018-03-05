from readthedocs.settings.base import CommunityBaseSettings

import os
environ = os.environ


class CommunitySettings(CommunityBaseSettings):
    PRODUCTION_DOMAIN = environ['HOSTNAME']
    WEBSOCKET_HOST = environ.get('WEBSOCKET_HOST')
    SESSION_COOKIE_DOMAIN = environ.get('HOSTNAME')
    
    SITE_ROOT = environ['ROOT']
    ELASTICSEARCH_HOST = environ['READTHEDOCS_POSTGRES_SERVICE_HOST']
    ELASTICSEARCH_PORT = environ['READTHEDOCS_POSTGRES_SERVICE_PORT']
    ES_HOSTS = [ELASTICSEARCH_HOST + ':' + ELASTICSEARCH_PORT]
    DEBUG = False
    
    STATIC_ROOT = os.path.join(environ['STATIC_ROOT'], 'static')
    MEDIA_ROOT = os.path.join(environ['STATIC_ROOT'], 'media')
    STATICFILES_DIRS = [
        os.path.join(SITE_ROOT, 'readthedocs', 'static'),
    ]

    STATIC_URL = '/static/'
    print('settings values')
    print(STATIC_ROOT)
    print(STATICFILES_DIRS)
    print(MEDIA_ROOT)

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql_psycopg2',
            'NAME': environ['POSTGRES_DB'],
            'USER': environ['POSTGRES_USER'],
            'PASSWORD': environ['POSTGRES_PASSWORD'],
            'HOST': environ['READTHEDOCS_POSTGRES_SERVICE_HOST'],
            'PORT': environ['READTHEDOCS_POSTGRES_SERVICE_PORT'],
        },
    }

    REDIS_HOST = environ['READTHEDOCS_REDIS_SERVICE_HOST']
    REDIS_PORT = environ['READTHEDOCS_REDIS_SERVICE_PORT']
    BROKER_URL = 'redis://' + REDIS_HOST +':' + REDIS_PORT + '/0'
    CELERY_ALWAYS_EAGER = False
    CELERY_ACCEPT_CONTENT = ['pickle', 'json', 'msgpack', 'yaml']
    CORS_ORIGIN_REGEX_WHITELIST = ['^.+$']
    CORS_ALLOW_HEADERS = list(CommunityBaseSettings.CORS_ALLOW_HEADERS) + ['csrftoken']
    CSRF_COOKIE_SECURE = False
    CSRF_COOKIE_HTTPONLY = False
    
    #EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
    EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
    
    SLUMBER_USERNAME = 'test'
    SLUMBER_PASSWORD = 'test'

    @property
    def LOGGING(self):  # noqa
        logging = super(CommunityProdSettings, self).LOGGING
        logging['formatters']['default']['format'] = '[%(asctime)s] ' + self.LOG_FORMAT
        return logging
    
    LOG_FORMAT = '%(name)s:%(lineno)s[%(process)d]: %(levelname)s %(message)s'
    
    LOGGING = {
        'version': 1,
        'disable_existing_loggers': False,
        'formatters': {
            'default': {
                'format': LOG_FORMAT,
                'datefmt': '%d/%b/%Y %H:%M:%S',
            },
        },
        'handlers': {
            'console': {
                'level': 'DEBUG',
                'class': 'logging.StreamHandler',
                'formatter': 'default'
            },
        },
        'loggers': {
            'readthedocs': {
                'handlers': ['console'],
                'level': 'DEBUG',
                'propagate': False,
            },
            'django': {
                'handlers':['console'],
                'propagate': False,
                'level':'DEBUG',
            },
            '': {
                'handlers': ['console'],
                'level': 'DEBUG',
                'propagate': False,
            },
        },
    }
    ALLOW_ADMIN = True

CommunitySettings.load_settings(__name__)
