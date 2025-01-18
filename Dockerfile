### stage 1

FROM python:3.13-bullseye AS builder

WORKDIR /app

COPY requirements.txt requirements.txt
COPY app.py app.py

RUN apt update && \
	apt install -y python3-pip && \
	pip install -r requirements.txt

### stage 2

FROM python:3.13-slim-bullseye

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
RUN mkdir -p /usr/lib/x86_64-linux-gnu/ 
COPY --from=builder /usr/lib/x86_64-linux-gnu/libmariadb3/plugin/caching_sha2_password.so /usr/lib/x86_64-linux-gnu/libmariadb3/plugin/caching_sha2_password.so
COPY --from=builder /usr/lib/x86_64-linux-gnu/libmariadb* /usr/lib/x86_64-linux-gnu/
COPY --from=builder /usr/lib/x86_64-linux-gnu/pkgconfig /usr/lib/x86_64-linux-gnu/pkgconfig
COPY requirements.txt requirements.txt
COPY app.py app.py
COPY templates templates

EXPOSE 5000

CMD ["python3","app.py"]
