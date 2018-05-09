#!/usr/bin/env bash
set -ex

# ARN is created by
create_arn(){
	aws iam create-role --role-name basic_lambda_role --assume-role-policy-document file://basic_lambda_role.json
}

ARN=arn:aws:iam::484485791251:role/basic_lambda_role

REGION=us-west-2

deploy(){
	zip main.zip main.py
	aws lambda create-function \
	--region $REGION \
	--function-name add \
	--zip-file fileb://main.zip \
	--role $ARN\
	--handler main.add \
	--runtime python2.7 \
	--profile lambda_user
}

run(){
	aws lambda invoke \
	--invocation-type RequestResponse \
	--function-name add \
	--region $REGION \
	--log-type Tail \
	--payload '{"a":1, "b":2 }' \
	--profile lambda_user \
	outputfile.txt

	cat outputfile.txt
	echo
}

$@