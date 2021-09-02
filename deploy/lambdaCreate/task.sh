
lamdaFunctionList=$(jq -r '.' alias.json)
for row in $(echo "${lamdaFunctionList}" | jq -r '.[] | @base64'); do
   _jq() {
    echo ${row} | base64 --decode | jq -r ${1}
   }
  #!/bin/bash
# 'Usage' sudo bash task.sh test arn:aws:iam::188097494660:role/LambdaAccesstoAWSService
projectname=$1
function_name=$(_jq '.FunctionName')
role=$2
runtime1=$(_jq '.Runtime')
description=$(_jq '.Description')
timeout=$(_jq '.Timeout')
MemorySize=$(_jq '.MemorySize')
environment=$(_jq '.environment')
tags=$(_jq '.tags')
# echo $runtime1
# runtime=$(echo "${runtime1}")
# echo
# description="$description"
runtime=$runtime1
# runtime=$($runtime1 | sed "s/\"//g")
function_name=$projectname"_"$function_name
echo $function_name;
echo "aws lambda create-function --function-name $function_name --role $role --runtime $runtime --handler "index.handler" --timeout $timeout --memory-size $MemorySize --description $description --zip-file 'fileb://sample.zip' --tags $tags"
aws lambda create-function --function-name $function_name \
--role $role \
--runtime $runtime \
--handler "index.handler" \
--timeout $timeout \
--memory-size $MemorySize \
--description "$description" \
--zip-file 'fileb://sample.zip' \
--environment $environment \
--tags $tags
# --environment 'Variables={S3_BUCKET=Test}' \
# --tags 'Departement=asdd,Dp=2' \
## Now create ALias 3 (development,stage & production)
aws lambda create-alias --function-name $function_name --name development --function-version '$LATEST'
#aws lambda create-alias --function-name $function_name --name stage --function-version '$LATEST'
aws lambda create-alias --function-name $function_name --name production --function-version '$LATEST'
done