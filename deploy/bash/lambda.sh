#!/bin/bash
log=$(git log -1 --pretty=%B);
#log="ABC test1 HorseGeneration_neo4j"

cd ..
cd ..
for char in `echo $log | fold -s`; do
   echo "Create Lambda function for First Time ProjectName=$1 FunctionName=$char"
   #echo "-d src/lambda/$char"
   ls
   if [ -d "src/lambda/$char" ]; then
       echo "Directory exits";
   else
       echo "Directory does't exists !!"
       continue;
   fi

   data=$(aws lambda get-function --function-name $1_$char)
   if [ -e $data  ];     then
       stackName="${char//[_]/}"
       echo $stackName
       aws cloudformation create-stack  --stack-name $stackName  --template-body file://cloudformation/lambdaCreationTemplate.json --parameters ParameterKey=Description,ParameterValue=$char ParameterKey=ProjectName,ParameterValue=$1 ParameterKey=FunctionName,ParameterValue=$char ParameterKey=RoleARN,ParameterValue=$2
   else
       echo "Lambda Already Exists!!"
   fi
done