FROM python:3.7

ARG DJANGO_SECRET
ENV DJANGO_SECRET ${DJANGO_SECRET}
ENV OPEN5E_DEBUG=0

COPY ./server /server

COPY ./data /data

WORKDIR /server

RUN pip install pipenv && pipenv install && \
  pipenv run python manage.py migrate && \
  pipenv run python manage.py populatedb --flush /data/WOTC_5e_SRD_v5.1/

ENTRYPOINT ["pipenv", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]
