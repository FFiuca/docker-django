FROM python

RUN apt-get update && apt-get install -y iputils-ping

WORKDIR ./app/

COPY requirements.txt ./app/
RUN pip install -r ./app/requirements.txt

COPY . ./app/
