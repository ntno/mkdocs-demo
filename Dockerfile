FROM ntno/ubuntu-build-base:1.0.0

COPY . /usr/src/

RUN cd /usr/src/

RUN pip install -r /usr/src/requirements.txt

EXPOSE 5000
