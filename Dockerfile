FROM alpine:latest as build

ENV LDFLAGS=-static

RUN set -eux; \
    apk add build-base bash perl git ucl-dev zlib-dev zlib-static; \
    git clone --recursive https://github.com/upx/upx; \
    cd upx; \
    make

FROM scratch

COPY --from=build /upx/src/upx.out /upx

ENTRYPOINT ["/upx"]

CMD ["--help"]
