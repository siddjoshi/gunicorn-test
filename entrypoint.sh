#!/usr/bin/env sh
set -e

if [ -f /app/app/main.py ]; then
    DEFAULT_MODULE_NAME=app.main
elif [ -f /app/main.py ]; then
    DEFAULT_MODULE_NAME=main
fi
MODULE_NAME=${MODULE_NAME:-$DEFAULT_MODULE_NAME}
VARIABLE_NAME=${VARIABLE_NAME:-app}
export APP_MODULE=${APP_MODULE:-"$MODULE_NAME:$VARIABLE_NAME"}

if [ -f /app/gunicorn_conf.py ]; then
    DEFAULT_GUNICORN_CONF=/app/gunicorn_conf.py
elif [ -f /app/app/gunicorn_conf.py ]; then
    DEFAULT_GUNICORN_CONF=/app/app/gunicorn_conf.py
else
    DEFAULT_GUNICORN_CONF=/gunicorn_conf.py
fi
export GUNICORN_CONF=${GUNICORN_CONF:-$DEFAULT_GUNICORN_CONF}

#exec "$@"
##exec newrelic-admin run-program gunicorn -k egg:meinheld#gunicorn_worker -c "$GUNICORN_CONF" "$APP_MODULE"
##exec newrelic-admin run-program gunicorn -k egg:meinheld#gunicorn_worker -c "$GUNICORN_CONF" "$APP_MODULE"
##exec newrelic-admin run-program gunicorn -c "$GUNICORN_CONF" "$APP_MODULE"

exec "$@"


if [ "$DEPLOYMENT" = "PROD" ];
then
    exec newrelic-admin run-program gunicorn -c "$GUNICORN_CONF" "$APP_MODULE"
else
    exec gunicorn -c "$GUNICORN_CONF" "$APP_MODULE"
    
    ##exec newrelic-admin run-program gunicorn -c "$GUNICORN_CONF" "$APP_MODULE" # to be removed after perf testing
fi

