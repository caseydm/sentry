FROM sentry:9.0-onbuild
RUN set -x \
    && apt-get update && apt-get install -y golang-go
ENV PATH=$PATH:/usr/local/go/bin
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["chamber", "exec", "sentry", "run", "web"]