# govtech
Task 1:
  - A:
    - To run the script:./count_apache_errors.sh apache_logs
    - You can modify the variable HOURS_BEFORE to specify how long ago should the logs be from
    - Modify EMAIL_ADDRESS to destination email address
    - Script will count the number of errors in the past hour from current date, and send an email if >100 4xx and 5xx errors
    - To run it periodically, configure a cronjob with schedule 0 * * * *

  - B:
    - Configure such that all log files older than 3 months are compressed into tar.gz files.
    - Set a retention period of 7 years for all logs, so that logs older than 7 years are deleted
    - For the scenario where the machine is running out of space, compress all log files except 3 months worth, to free up space. Monitor the rate at which logs is increasing, and provision additional storage accordingly. 
