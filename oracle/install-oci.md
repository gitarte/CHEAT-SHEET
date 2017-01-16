```sh
mkdir /opt/oracle
mv instantclient-basic-linux.x64-12.1.0.2.0.zip
mv instantclient-sdk-linux.x64-12.1.0.2.0.zip
cd /opt/oracle
unzip instantclient-basic-linux.x64-12.1.0.2.0.zip
unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip
cp /opt/oracle/instantclient_12_1/libclntsh.so.12.1 /opt/oracle/instantclient_12_1/libclntsh.so
cp /opt/oracle/instantclient_12_1/libocci.so.12.1   /opt/oracle/instantclient_12_1/libocci.so
cp /opt/oracle/instantclient_12_1/*.so              /usr/local/lib/
cp /opt/oracle/instantclient_12_1/*.so.*            /usr/local/lib/
cp /opt/oracle/instantclient_12_1/sdk/include/*     /usr/local/include/
ldconfig
```
