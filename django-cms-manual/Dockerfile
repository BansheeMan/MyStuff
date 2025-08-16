FROM python:3.11

WORKDIR /app

COPY myproject/requirements.in ./requirements.in

RUN cat /etc/resolv.conf && ping -c 1 pypi.org || true
RUN pip install --upgrade pip pip-tools && \
    pip-compile requirements.in && \
    pip install -r requirements.txt

COPY ./myproject .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
