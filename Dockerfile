FROM sentry:9.0-onbuild
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin
RUN apt-get update \
    && apt-get install -y golang
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["chamber", "exec", "sentry", "run", "web"]