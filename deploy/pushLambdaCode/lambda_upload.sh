#!/bin/bash
set -e
# $project_name $bucket_name $branch_name $char $region
projname=$1
bucket_name=$2
branch_name=$3
char=$4
region=$5
environment=$6
role=$7

# Logging the Pipeline #
echo "Project Name => "$projname
echo "branch => "$branch_name
echo "Bucket Name => "$bucket_name
echo "region => "$region
echo "Publishing lambda => "$char
echo "Environtment => "$environment
echo "role => "$role

cd ..
mkdir -p src
cd ..

cd src/lambda

if [ -e $char ] ; 
then
	echo "Lambda function pushed to AWS S3 and lambda"

	cd $char
	pwd
	zip -r $char.zip .
	mv $char.zip ../../../deploy/src/
	cd ../../../deploy/src
	# push file to s3 with particular location
	# upload it to the aws cli --update-code with link
	# s3:///s3.amazonaws.com/bucketname

	aws s3 --region $region cp $char.zip s3://$bucket_name/$projname/deploy/src/$char.zip
	name="arn:aws:lambda:$region:188097494660:function:$projname"_"$char"
	echo $name;

	# change the configuration #
	 aws lambda update-function-configuration --function-name $name --role $role --environment $environment --runtime nodejs12.x;
	# aws lambda update-function-configuration --function-name $name --role $role --environment $environment --runtime python3.6;
	# push and publish the code # 
	version=$(aws lambda update-function-code --function-name $name --s3-bucket $bucket_name --s3-key $projname/deploy/src/$char.zip --region $region --publish --query 'Version' --output text)
	# echo "Version =>"$version

	# put revisionid to the alais thing#
	aws lambda update-alias --function-name $name --name $branch_name --function-version $version

	# Now need to publish the particular version
	# assign to the particular branch type
	# steps
	# 1. updata-function-code (environment)
	# 2. push_and_publish_latestcode (publish)
	# 3. Alias specific push (update-alias)

	
else
	echo "Ignore it as not a valid lambda function"
fi