```sh
FROM python
COPY ["instantclient-basic-linux.x64-12.1.0.2.0.zip", "/opt/oracle/instantclient-basic-linux.x64-12.1.0.2.0.zip"]
COPY ["instantclient-sdk-linux.x64-12.1.0.2.0.zip",   "/opt/oracle/instantclient-sdk-linux.x64-12.1.0.2.0.zip"]

RUN set -x \
  && apt-get -y update \
  && apt-get -y install freetds-bin freetds-common freetds-dev libdbd-freetds libaio-dev unzip \
  && cd /opt/oracle \
  && unzip instantclient-basic-linux.x64-12.1.0.2.0.zip \
  && unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip \
  && cp /opt/oracle/instantclient_12_1/libclntsh.so.12.1 /opt/oracle/instantclient_12_1/libclntsh.so \
  && cp /opt/oracle/instantclient_12_1/libocci.so.12.1   /opt/oracle/instantclient_12_1/libocci.so \
  && cp /opt/oracle/instantclient_12_1/*.so              /usr/local/lib/ \
  && cp /opt/oracle/instantclient_12_1/*.so.*            /usr/local/lib/ \
  && cp /opt/oracle/instantclient_12_1/sdk/include/*     /usr/local/include/ \
  && cd / \
  && rm -rf /opt/oracle \
  && ldconfig \
  && pip install cx_Oracle \
  && pip install pymssql \
  && pip install cherrypy \
  && pip install requests \
  && pip install cassandra-driver \
  && pip install pymongo \
  && pip install redis \
  && pip install psycopg2

```
