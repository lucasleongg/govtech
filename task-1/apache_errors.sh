#!/bin/bash
INPUT=$1
#awk -vDate=`date -d'10 years ago' +[%d/%b/%Y:%H:%M:%S` '$4 > Date {print Date, $0}' ${INPUT}
$TIME_AGO=`date -d '10 minutes ago' +[%d/%b/%Y:%H:%M:%S`
$TIME_NOW=`date -d 'now' +[%d/%b/%Y:%H:%M:%S`
echo $TIME_AGO
echo $TIME_NOW



#ERROR_OUTPUT=`awk '$9~/[45][0-9]{2}/{print $1,$4,$5,$7,$9}' ${INPUT}`
#echo "$ERROR_OUTPUT"
#error_count=`echo "$ERROR_OUTPUT" | wc -l` #If column 9 matches regex pattern [45]xx, print out line. Then use wc to count all lines to get error count
#echo $error_count

#Get count of each error
#awk -v awkvar="$ERROR_OUTPUT" 'BEGIN {print awkvar}' #| sort | uniq -c
