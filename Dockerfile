FROM sentry:9.0-onbuild
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/Projects
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && wget "https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz" \
    && tar -xvf go1.10.3.linux-amd64.tar.gz \
    && mv go /usr/local \
    && go get "github.com/segmentio/chamber" \
    && apt-get purge -y --auto-remove wget
CMD ["chamber", "exec", "sentry", "--", "run", "web"]