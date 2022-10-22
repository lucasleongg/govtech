# govtech
Task 1: 
  - To run the script:./count_apache_errors.sh apache_logs
  - You can modify the variable HOURS_BEFORE to specify how long ago should the logs be from
  - Modify EMAIL_ADDRESS to destination email address
  - Script will count the number of errors in the past hour from current date, and send an email if >100 4xx and 5xx errors
  - To run it periodically, configure a cronjob with schedule 0 * * * *
