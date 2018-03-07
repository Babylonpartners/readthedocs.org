FROM python:2.7-slim

MAINTAINER  Anton Kirilenko "https://github.com/flid"

ENV DJANGO_SETTINGS_MODULE config
ENV ROOT /opt/readthedocs.org
ENV STATIC_ROOT $ROOT/static
ENV RUN_USER rth-user

# Update the package repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \ 
	DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl locales git python python-pip python-dev libxml2-dev libxslt-dev zlib1g-dev lib32z1-dev gettext

# Configure locale
RUN export LANGUAGE=en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	export LC_ALL=en_US.UTF-8 && \
	locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales


# Install readthedocs
RUN cd /opt && git clone https://github.com/Babylonpartners/readthedocs.org.git

WORKDIR $ROOT
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install psycopg2==2.7.3.1 uWSGI==2.0.14 anyjson==0.3.3

# Small hack - moval all media and static files inside `static` dir, 
# so uwsgi has no access to code files when serving static.
RUN mkdir -p $STATIC_ROOT 
RUN mv media $STATIC_ROOT/

# Create the user that will run the app
RUN groupadd -r $RUN_USER && useradd -r -g $RUN_USER $RUN_USER
RUN mkdir -p $ROOT && chown $RUN_USER:$RUN_USER $ROOT -R

ADD config .

USER $RUN_USER


CMD ["./rth-start.sh"]
