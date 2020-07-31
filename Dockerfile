FROM tiangolo/meinheld-gunicorn:python3.6
 
COPY requirements.txt /app/requirements.txt

RUN pip install uwsgi

RUN pip install -r requirements.txt
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY . /app

WORKDIR /app

##RUN pip install bjoern
RUN pip install gevent

ENV MODULE_NAME="app" \
    WEB_CONCURRENCY="1" \
    LOG_LEVEL="debug" \
    DEPLOYMENT="QA"

EXPOSE 80 5000