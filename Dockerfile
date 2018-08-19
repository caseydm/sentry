FROM sentry:9.0-onbuild
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin
RUN set -x \
    && add-apt-repository ppa:gophers/archive \
    && apt-get update \
    && apt-get install golang \
    && go get github.com/segmentio/chamber
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["chamber", "exec", "sentry", "run", "web"]