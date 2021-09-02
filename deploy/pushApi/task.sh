# change set of varibale from enviroment varibale from swagger and push it on Gateway
# LambdaPrefixName, CognitoARN, Name, Region, APIGatewayARN, apiId
set -e
a=$PWD
# $Project_Name $Cognito_ARN $API_NAME $REGION $API_Gateway_ARN $API_ID development
echo "Project_Name"$1
echo "Cognito_ARN"$2
echo "API_Name"$3
echo "REGION"$4
echo "API_Gateway_ARN"$5
echo "API_ID"$6
echo "deployment"$7

# branch_name
# branch_name=$(git branch | grep \* | cut -d ' ' -f2)
# echo "git_branch_name=> "$branch_name

cd ..
cd ..
sed -e 's#${LambdaPrefixName}#'$1'#g' -e 's#${CognitoARN}#'$2'#g' -e 's#${Name}#'$3'#g' -e 's#${Region}#'$4'#g' -e 's#${branchName}#'$7'#g' -e 's#${APIGatewayARN}#'$5'#g' 'src/configuration/swagger.json' > 'src/configuration/deployswagger.json'; 
aws apigateway put-rest-api --rest-api-id $6 --mode overwrite --body 'file:///'$PWD'/src/configuration/deployswagger.json';
aws apigateway create-deployment --rest-api-id $6 --stage-name $7
