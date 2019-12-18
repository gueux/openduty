FROM python:2-slim-stretch

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
      libldap2-dev \
      libsasl2-dev \
      libmariadbclient-dev \
      gcc \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ARG DJANGO_SETTINGS_MODULE=openduty.settings_build
ENV DJANGO_SETTINGS_MODULE $DJANGO_SETTINGS_MODULE
RUN python manage.py collectstatic --noinput

CMD gunicorn openduty.wsgi \
          --bind 0.0.0.0:8080 \
          --chdir . \
          --workers 1 \
          --worker-class gevent \
          --timeout 30 \
          --access-logfile - \
          --error-logfile -
