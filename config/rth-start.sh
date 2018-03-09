#!/bin/bash -x

python manage.py collectstatic --noinput

python manage.py makemigrations
python manage.py migrate

# Create admin:admin user on the first run
echo "from django.contrib.auth.models import User; user=User.objects.filter(username='admin'); user or User.objects.create_superuser('admin', '$ADMIN_EMAIL', 'admin')" | python manage.py shell
python manage.py makemessages --all
python manage.py compilemessages

curl -XPUT http://readthedocs-elasticsearch-client:9200/readthedocs
curl -XPUT http://elasticsearch:9200/readthedocs
uwsgi --ini $ROOT/uwsgi.ini --http $SERVER_ADDRESS:$SERVER_PORT --static-map /media=/opt/readthedocs.org/static/media --static-map /static=/opt/readthedocs.org/static/static
