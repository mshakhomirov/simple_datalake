#!/usr/bin/env bash
# chmod +x ./deploy.sh
# Run ./deploy.sh
PROFILE=mds
STACK_NAME=SimpleStackWithLambda

date

TIME=`date +"%Y%m%d%H%M%S"`

base=${PWD##*/}
zp=$base".zip"
echo $zp

rm -f $zp

zip -r $zp * -x deploy.sh

aws --profile $PROFILE s3 cp ./${base}.zip s3://datalake-lambdas.aws/pipeline_manager/${base}${TIME}.zip

aws --profile $PROFILE \
cloudformation deploy \
--template-file stack.yaml \
--stack-name $STACK_NAME \
--capabilities CAPABILITY_IAM \
--parameter-overrides "StackPackageS3Key"="pipeline_manager/${base}${TIME}.zip"
