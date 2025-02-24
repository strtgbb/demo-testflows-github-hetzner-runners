echo Collect pipeline and build metadata
echo GITLAB BRANCH: $CI_COMMIT_BRANCH > metadata.txt
echo GITLAB COMMIT SHA: $CI_COMMIT_SHA >> metadata.txt
echo JOB ID: $CI_JOB_ID >> metadata.txt
echo JOB NAME: $CI_JOB_NAME >> metadata.txt
echo JOB STAGE: $CI_JOB_STAGE >> metadata.txt
echo JOB STATUS: $CI_JOB_STATUS >> metadata.txt
echo STARTED TIME: $CI_JOB_STARTED_AT >> metadata.txt
echo JOB URL: $CI_JOB_URL >> metadata.txt
echo PIPELINE URL: $CI_PIPELINE_URL >> metadata.txt
echo CLIKCHOUSE SHA: $GH_ARTIFACTS_COMMIT >> metadata.txt
echo SCRIPTS SHA: $(git rev-parse HEAD) >> metadata.txt
echo TESTFLOWS REGRESSION SHA: $REGRESSION_SHA >> metadata.txt

sed -i -E '/S3|KEY|SECRET|JWT|PWD|TOKEN|PASSWORD|ACCESS|token/d' metadata.txt
