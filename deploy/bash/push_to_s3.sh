cd ../../../
echo $PWD
aws s3 sync facilitybook-backend s3://facilitybook-backend --exclude ".git/*/*/*" 