#!/bin/sh

sleep_time=10

IFS='
'

function log_time () {
    date +'%Y-%m-%d %H:%M:%S'
}


echo "[$(log_time)] Starting the probe process"

if [ "$#" -ne 1 ]; then
    echo "[$(log_time)] Invalid endpoint. Usage: $0 <http-endpoint>"
    exit 1
fi


endpoint=$1
domain=$(echo $endpoint | awk -F/ '{ print $3 }')

echo "[$(log_time)] Target endpoint: $endpoint"


while [ 1 ]; do
    echo "[$(log_time)] Sending the probe"


    echo "[$(log_time)] Trying to resolve domain: $domain"

    records=$(dig +short $domain)
    records_len=$(echo $records | wc -w)

    if [ $records_len -eq 0 ]; then
        echo "[$(log_time)] Domain could not be resolved"

        echo "[$(log_time)] Waiting for ${sleep_time}s before sending the next probe"
        sleep $sleep_time

        continue
    fi

    for record in $records; do
        echo "[$(log_time)] Record found: $record"
    done


    response=$(curl --max-time 5 --silent --output /dev/null --write-out "%{http_code}" "$endpoint")

    if [ $response -eq 000 ]; then
        echo "[$(log_time)] Service not available"
    else
        echo "[$(log_time)] HTTP response code: $response"
    fi


    echo "[$(log_time)] Waiting for ${sleep_time}s before sending the next probe"
    sleep $sleep_time
done
