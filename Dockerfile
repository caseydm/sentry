FROM sentry:9.0-onbuild
RUN set -x \
    && apt-get update && apt-get install -y golang-go \
    && go get github.com/segmentio/chamber
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["chamber", "exec", "sentry", "run", "web"]