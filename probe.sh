#!/bin/sh

echo "[INFO]  Starting the probe"

if [ "$#" -ne 1 ]; then
    echo "[ERROR] Invalid endpoint. Usage: $0 <http-endpoint>"
    exit 1
fi

sleep_time=10

IFS='
'

endpoint=$1
domain=$(echo $endpoint | awk -F/ '{ print $3 }')

echo "[INFO]  Target endpoint: $endpoint"

while [ 1 ]; do
    echo "[INFO]  Trying to resolve domain: $domain"

    records=$(dig +short $domain)
    records_len=$(echo $records | wc -w)

    if [ $records_len -eq 0 ]; then
        echo "[ERROR] Domain could not be resolved"
        echo "[INFO]  Waiting for $sleep_time seconds before the next probe"

        sleep $sleep_time

        continue
    fi

    for record in $records; do
        echo "[INFO]  Record found: $record"
    done


    response=$(curl --max-time 5 --silent --output /dev/null --write-out "%{http_code}" "$endpoint")

    if [ $response -eq 000 ]; then
        echo "[ERROR] Service not available"
    else
        echo "[INFO]  HTTP response code: $response"
    fi


    echo "[INFO]  Waiting for $sleep_time seconds before the next probe"

    sleep $sleep_time
done
