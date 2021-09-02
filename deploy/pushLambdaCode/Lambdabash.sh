#!/bin/bash

# steps to deploy to prodution-Lambda
# 1. lambda push with the enviroment varibale to given branch
# 2. push to lambda to branch-name-(alias)

# get the current branch
branch_name=$6
# branch_name=$(git branch | grep \* | cut -d ' ' -f2)
# echo "git_branch_name=> "$branch_name

# get the commit -code
log=$(git log -1 --pretty=%B);
echo "This is the commit => "$log
for char in `echo $log | fold -s`; do
    echo $char
    # bash lambda_upload.sh $project_name $bucket_name $branch_name $char $region $environment $role
    bash lambda_upload.sh $1 $2 $branch_name $char $3 $4 $5 $7
done
