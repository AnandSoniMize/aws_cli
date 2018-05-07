#!/usr/bin/env bash
set -ex

createSecurityGroup(){
# https://docs.aws.amazon.com/cli/latest/reference/ec2/create-security-group.html#examples
	aws ec2 create-security-group --group-name MySecurityGroup --description "My security group"
}
create_ec2(){
	# https://docs.aws.amazon.com/cli/latest/userguide/cli-ec2-launch.html
	aws ec2 run-instances --image-id ami-916f59f4 --count 1 --instance-type t2.micro #--key-name MyKeyPair --security-groups my-sg

}

$@