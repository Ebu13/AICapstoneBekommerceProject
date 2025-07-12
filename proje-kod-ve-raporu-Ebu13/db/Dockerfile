FROM postgres:17

ENV POSTGRES_DB=bekommerce
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=13042003

COPY bekommerce.sql /docker-entrypoint-initdb.d/init.sql
