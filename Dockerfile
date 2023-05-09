FROM ttbb/opengemini:compiler AS compiler

WORKDIR /opt

RUN git clone --depth 1 https://github.com/openGemini/openGemini.git  && \
    cd openGemini && \
    python3 build.py

FROM shoothzj/base:go

ENV OPENGEMINI_HOME=/opt/opengemini

COPY --from=compiler /opt/opengemini/build/ts-cli /opt/opengemini/ts-cli
COPY --from=compiler /opt/opengemini/build/ts-meta /opt/opengemini/ts-meta
COPY --from=compiler /opt/opengemini/build/ts-monitor /opt/opengemini/ts-monitor
COPY --from=compiler /opt/opengemini/build/ts-server /opt/opengemini/ts-server
COPY --from=compiler /opt/opengemini/build/ts-sql /opt/opengemini/ts-sql
COPY --from=compiler /opt/opengemini/build/ts-store /opt/opengemini/ts-store

WORKDIR /opt/opengemini
