FROM ttbb/opengemini:compiler AS compiler

WORKDIR /opt

RUN git clone --depth 1 https://github.com/openGemini/openGemini.git  && \
    cd openGemini && \
    python3 build.py

FROM shoothzj/base:go

ENV OPENGEMINI_HOME=/opt/opengemini

COPY --from=compiler /opt/openGemini/build/ts-cli /opt/opengemini/ts-cli
COPY --from=compiler /opt/openGemini/build/ts-meta /opt/opengemini/ts-meta
COPY --from=compiler /opt/openGemini/build/ts-monitor /opt/opengemini/ts-monitor
COPY --from=compiler /opt/openGemini/build/ts-server /opt/opengemini/ts-server
COPY --from=compiler /opt/openGemini/build/ts-sql /opt/opengemini/ts-sql
COPY --from=compiler /opt/openGemini/build/ts-store /opt/opengemini/ts-store

RUN ln -s /opt/opengemini/ts-cli /usr/bin/ts-cli && \
    ln -s /opt/opengemini/ts-meta /usr/bin/ts-meta && \
    ln -s /opt/opengemini/ts-monitor /usr/bin/ts-monitor && \
    ln -s /opt/opengemini/ts-server /usr/bin/ts-server && \
    ln -s /opt/opengemini/ts-sql /usr/bin/ts-sql && \
    ln -s /opt/opengemini/ts-store /usr/bin/ts-store

WORKDIR /opt/opengemini
