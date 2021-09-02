log=$(git log -1 --pretty=%B);
echo $log
for char in `echo $log | fold -s`; do
    echo $char
    bash publish-lambda.sh $char
done