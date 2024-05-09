FROM python

RUN apt-get update && apt-get install -y iputils-ping

RUN echo "1" && pwd && sleep 5

# RUN mkdir /app
# RUN mkdir /app/jancok

# it will affect command in compose and entrypoit/root path is from target path of volume in docker compose
WORKDIR /app/django
# WORKDIR /django/ecommerce-app-zz # i dont know why copied files not that path, they copied to ${target volume docker compose}/app instead. maybe it override by docker or config that idk. WORKDIR is effect when you open container exec. in this case i remove volume and create again to fix it.
# The WORKDIR instruction can be used multiple times in a Dockerfile. If a relative path is provided, it will be relative to the path of the previous WORKDIR instruction

RUN echo "2" && pwd && sleep 5
COPY requirements.txt .
# success to workdir path

# COPY requirements.txt /app/ecommerce/

RUN echo "3" && pwd && sleep 5
RUN pip install -r requirements.txt
# RUN pip install -r ./app/ecommerce/requirements.txt

RUN echo "4" && pwd && sleep 5
COPY ./ .

ENV APP_HOST 0.0.0.0
ENV APP_PORT 8001
ENV DEBUG_PORT 5678

EXPOSE ${APP_PORT}
EXPOSE ${DEBUG_PORT}

# CMD sh -c "python3 manage.py makemigrations --noinput && python3 manage.py makemigrations master notification order product store transaction user --noinput && python3 manage.py migrate --noinput &&  python3 manage.py loaddata master/seeder/master-all.json && python3 manage.py collectstatic --noinput && python3 manage.py runserver 0.0.0.0:${APP_PORT}"

# if you want build image and use it in another purpose, like k8s maybe. prefer use your all query to build image inside dockerfile instead docker-compose.yaml. this is standard way
# CMD sh -c "python3 manage.py makemigrations --noinput && python3 manage.py makemigrations master notification order product store transaction user --noinput && python3 manage.py migrate --noinput &&  python3 manage.py loaddata master/seeder/master-all.json && python3 manage.py collectstatic --noinput && python3 -m debugpy --listen 0.0.0.0:${DEBUG_PORT} manage.py runserver 0.0.0.0:${APP_PORT}"

# version django-ecommerce:latest (normal)
# CMD sh -c "python3 manage.py makemigrations --noinput && python3 manage.py makemigrations master notification order product store transaction user --noinput && python3 manage.py migrate --noinput &&  python3 manage.py loaddata master/seeder/master-all.json && python3 manage.py collectstatic --noinput && daphne ecommerce.asgi:application -b ${APP_HOST} -p ${APP_PORT}"

# version django-ecommerce:only-run.v1
# ENTRYPOINT [ "/app/ecommerce"]
CMD sh -c "pwd && daphne ecommerce.asgi:application -b ${APP_HOST} -p ${APP_PORT}"
