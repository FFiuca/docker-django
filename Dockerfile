FROM python

RUN apt-get update && apt-get install -y iputils-ping

# it will affect command in compose and entrypoit/root path is from target path from volume in docker compose
# WORKDIR ./app/app/
# The WORKDIR instruction can be used multiple times in a Dockerfile. If a relative path is provided, it will be relative to the path of the previous WORKDIR instruction
WORKDIR ./django

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
