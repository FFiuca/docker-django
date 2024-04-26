FROM python

RUN apt-get update && apt-get install -y iputils-ping

# it will affect command in compose and entrypoit/root path is from target path of volume in docker compose
# WORKDIR ./app/app/
# The WORKDIR instruction can be used multiple times in a Dockerfile. If a relative path is provided, it will be relative to the path of the previous WORKDIR instruction
WORKDIR ./django

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

ENV APP_HOST 0.0.0.0
ENV APP_PORT 8001
ENV DEBUG_PORT 5678

EXPOSE ${APP_PORT}
EXPOSE ${DEBUG_PORT}

# CMD sh -c "python3 manage.py makemigrations --noinput && python3 manage.py makemigrations master notification order product store transaction user --noinput && python3 manage.py migrate --noinput &&  python3 manage.py loaddata master/seeder/master-all.json && python3 manage.py collectstatic --noinput && python3 manage.py runserver 0.0.0.0:${APP_PORT}"

# if you want build image and use it in another purpose, like k8s maybe. prefer use your all query to build image inside dockerfile instead docker-compose.yaml. this is standard way
# CMD sh -c "python3 manage.py makemigrations --noinput && python3 manage.py makemigrations master notification order product store transaction user --noinput && python3 manage.py migrate --noinput &&  python3 manage.py loaddata master/seeder/master-all.json && python3 manage.py collectstatic --noinput && python3 -m debugpy --listen 0.0.0.0:${DEBUG_PORT} manage.py runserver 0.0.0.0:${APP_PORT}"
CMD sh -c "python3 manage.py makemigrations --noinput && python3 manage.py makemigrations master notification order product store transaction user --noinput && python3 manage.py migrate --noinput &&  python3 manage.py loaddata master/seeder/master-all.json && python3 manage.py collectstatic --noinput && daphne ecommerce.asgi:application -b ${APP_HOST} -p ${APP_PORT}"
