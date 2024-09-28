#!/bin/sh

sleep_time=10

IFS='
'

function print_log () {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}


print_log "Starting the probe process"

if [ "$#" -ne 1 ]; then
    print_log "Invalid endpoint. Usage: $0 <http-endpoint>"
    exit 1
fi


endpoint=$1
domain=$(echo $endpoint | awk -F/ '{ print $3 }')

print_log "Target endpoint: $endpoint"


while [ 1 ]; do
    print_log "Sending the probe"


    print_log "Trying to resolve domain: $domain"

    records=$(dig +short $domain)
    records_len=$(echo $records | wc -w)

    if [ $records_len -eq 0 ]; then
        print_log "Domain could not be resolved"

        print_log "Waiting for ${sleep_time}s before sending the next probe"
        sleep $sleep_time

        continue
    fi

    for record in $records; do
        print_log "Record found: $record"
    done


    response=$(curl --max-time 5 --silent --output /dev/null --write-out "%{http_code}" "$endpoint")

    if [ $response -eq 000 ]; then
        print_log "Service not available"
    else
        print_log "HTTP response code: $response"
    fi


    print_log "Waiting for ${sleep_time}s before sending the next probe"
    sleep $sleep_time
done
