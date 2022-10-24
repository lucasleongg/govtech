# govtech
OS: Ubuntu 22.04 on AWS EC2
- Task 1:
  - A:
    - Overview:
      - The script will first filter logs from the past X hours. 
      - From these, it will count the number of 4xx and 5xx responses using regex. 
      - If the error count is more than 100, it will generate a summary of the total number of errors, and count for each error. 
      Total Errors: 103
      error 400: 50
      error 404: 53
      - It will then send an email containing the error summary and list of errors to the email specified.
    - Run script:
      - To run the script:./count_apache_errors.sh apache_logs
      - You can modify the variable HOURS_BEFORE to specify how long ago should the logs be from
      - Modify EMAIL_ADDRESS to destination email address (Ensure that mailutils is installed)
      - To run it periodically, configure a cronjob with schedule (E.g. 0 * * * * for every hour) 

  - B:
    - Configure such that all log files older than 3 months are compressed into tar.gz files.
    - Set a retention period of 7 years for all logs, so that logs older than 7 years are deleted
    - For the scenario where the machine is running out of space, compress all log files except 3 months worth, to free up space. Monitor the rate at which logs is increasing, and provision additional storage accordingly. 

- Task 2:
  - Resources:
    - Jenkins pipeline URL: http://54.179.154.58:8080/job/govtech/
    - Jenkins Credentials: admin:admin
    - Staging URL: http://54.179.154.58:3000/
    - Release URL: http://54.179.154.58:3001/
  - Overview:
    - Jenkins is used as the CI/CD tool for this task. 
    - Multibranch pipeline is created for one2onetool, consisting of staging and release branches
    - Multibranch webhook is set up such that commits to GitHub will trigger the respective pipeline
    - If it is the staging branch, environment variables will be configured to use Questions-test.json and port 3000. Else, it will use Questions.json and port 3001
    - On trigger, pipeline will run 5 stages:
      - Build:
        - Build using npm install
      - Test: 
        - Test using npm test (If failed, email notification will be sent. More details below)
      - Build Image:
        - It will then build docker image using the dockerfile found in the task-2 folder.
          - Docker images are tagged using $Branch_name-$BUILD_NUMBER (E.g. lucasleongg/govtech:release-7)
          - .dockerignore file specifies the files to ignore (node_modules, npm-debug.log) so that the image is smaller
      - Push Image:
        - The image will then be pushed to DockerHub registry (lucasleongg/govtech)
      - Deploy Image:
        - Image is ran using docker run, and named according to their branch name.
        - Port is configured using environmental variables in the beginning (3000 for staging, 3001 for release)
      - Email:
        - A POST step is configured such that failure in any stage will send an email to the address specified in the environment variable
        - Example body: 
          Failure: Job govtech/staging build 53
 More info at: http://54.179.154.58:8080/job/govtech/job/staging/53/
    
