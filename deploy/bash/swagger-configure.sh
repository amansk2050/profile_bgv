# change set of varibale from enviroment varibale from swagger and push it on Gateway
# LambdaPrefixName, CognitoARN, Name, Region, APIGatewayARN, apiId
set -e
a=$PWD
cd ..
cd ..
sed -e 's#${LambdaPrefixName}#'$1'#g' -e 's#${CognitoARN}#'$2'#g' -e 's#${Name}#'$3'#g' -e 's#${Region}#'$4'#g' -e 's#${APIGatewayARN}#'$5'#g' './deploy/configuration/swagger.json' > './deploy/configuration/deployswagger.json'; aws apigateway put-rest-api --rest-api-id $6 --mode overwrite --body 'file:///'$PWD'/deploy/configuration/deployswagger.json'
