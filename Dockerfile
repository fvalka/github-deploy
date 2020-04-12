FROM alpine/git:v2.24.1

RUN mkdir /app
COPY git-deploy.sh /app/git-deploy.sh
RUN chmod a+rx /app/git-deploy.sh

RUN mkdir /var/data
RUN chmod a+rwx /var/data
RUN mkdir /tmp/deploy
RUN chmod a+rwx /tmp/deploy
WORKDIR /var/data

ENTRYPOINT [ "/app/git-deploy.sh" ]