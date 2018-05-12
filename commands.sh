#!/usr/bin/env bash
set -ex

createSecurityGroup(){
# https://docs.aws.amazon.com/cli/latest/reference/ec2/create-security-group.html#examples
	aws ec2 create-security-group --group-name MySecurityGroup --description "My security group"
}
create_ec2(){
	# https://docs.aws.amazon.com/cli/latest/userguide/cli-ec2-launch.html
	aws ec2 run-instances --image-id ami-66c8fa03 --count 1 --instance-type t2.micro --key-name MyKeyPair #--security-groups my-sg

}
configure_list(){
	aws configure list
#      Name                    Value             Type    Location
#      ----                    -----             ----    --------
#   profile                <not set>             None    None
#access_key     ******************* shared-credentials-file
#secret_key     ******************* shared-credentials-file
#    region             eu-central-1      config-file    ~/.aws/config

}
find_image(){
	# https://gist.github.com/vancluever/7676b4dafa97826ef0e9
	aws ec2 describe-images  --filters Name=name,Values=ubuntu/images/hvm-ssd/ubuntu*  --query 'Images[*].[ImageId,CreationDate]' --output text  | sort -k2 -r  | head -n1
	# ami-66c8fa03	2018-05-01T17:34:11.000Z
}

ec2_regions(){
	aws ec2 describe-regions
}

change_region(){
	aws configure set region us-east-2
}

frankfurt(){
	aws configure set region eu-central-1
}

all_ec2_instances(){
	aws ec2 describe-instances --region us-east-2
}

delete_instance(){
	aws ec2 terminate-instances  --instance-id $1
}

create_key_pair(){
	aws ec2 create-key-pair --key-name MyKeyPair | tee MyKeyPair.pem
}



$@