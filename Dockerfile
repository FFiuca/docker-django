FROM python

WORKDIR ./app/

COPY requirements.txt ./app/
RUN pip install -r ./app/requirements.txt

COPY . ./app/
