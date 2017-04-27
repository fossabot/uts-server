#!/bin/sh

timeout 120 ./uts-server -c tests/cfg/uts-server.cnf -D -p ./uts-server.pid &

sleep 1
./goodies/timestamp-file.sh -i README.rst -u http://localhost:2020 -r -O "-cert" || exit 1
./goodies/timestamp-file.sh -i README.rst -u http://localhost:2020 -r -O "-cert" || exit 1
./goodies/timestamp-file.sh -i README.rst -u http://localhost:2020 -r -O "-cert" || exit 1

kill `cat ./uts-server.pid`

if which timeout >/dev/null 2>&1
then
    TO="timeout 120"
else
    TO=""
fi

$TO ./uts-server -c tests/cfg/uts-server-ssl.cnf -D -p ./uts-server.pid &

sleep 1
./goodies/timestamp-file.sh -i README.rst -u https://localhost:2020 -r -O "-cert" -C '-k' || exit 1
./goodies/timestamp-file.sh -i README.rst -u https://localhost:2020 -r -O "-cert" -C '-k' || exit 1
./goodies/timestamp-file.sh -i README.rst -u https://localhost:2020 -r -O "-cert" -C '-k' || exit 1

kill `cat ./uts-server.pid`

