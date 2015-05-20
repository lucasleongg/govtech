#!/bin/bash
INPUT=$1
HOURS_BEFORE="1"
EMAIL_ADDRESS="email@address.com"

#Filter logs in the past hour
FILTERED_LOGS=`awk -vDate=$(date -d 'now-'"${HOURS_BEFORE}"' hours' +[%d/%b/%Y:%H:%M:%S) '$4 > Date {print $0}' ${INPUT}`

#Count number of 4xx and 5xx response
ERROR_OUTPUT=`echo "${FILTERED_LOGS}" | awk '$9~/[45][0-9]{2}/{print $0}'`
ERROR_COUNT=`echo "${ERROR_OUTPUT}" | wc -l`

#If more than 100 errors
if [[ ${ERROR_COUNT} -gt 100 ]]
then
  #Format summary count of errors
  TOTAL_ERRORS="Total Errors: ${ERROR_COUNT}"
  ERROR_SUMMARY=`echo "$ERROR_OUTPUT" | awk '{print $9}' | sort | uniq -c | awk '{print "error "$2":"$1 }'`

  EMAIL_BODY="${TOTAL_ERRORS}"$'\n'"${ERROR_SUMMARY}"$'\n'"${ERROR_OUTPUT}"
  #Send email
  mail -s "error logs for $(date)" ${EMAIL_ADDRESS} <<< ${EMAIL_BODY}
fi
