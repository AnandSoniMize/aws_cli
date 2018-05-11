#!/usr/bin/env bash
set -ex


#https://docs.aws.amazon.com/redshift/latest/mgmt/getting-started-cli.html
create(){
# https://docs.aws.amazon.com/cli/latest/reference/redshift/create-cluster.html
#https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#how-many-nodes
	aws redshift create-cluster --node-type dc1.large --number-of-nodes 2 --master-username adminuser --master-user-password TopSecret1 --cluster-identifier mycluster
	# --cluster-security-groups MySecurityGroup # this flag not working
	# aws redshift create-cluster --node-type dc1.large --number-of-nodes 2 --master-username adminuser --master-user-password TopSecret1 --cluster-identifier mycluster --cluster-security-groups MySecurityGroup
#	An error occurred (InvalidParameterValue) when calling the CreateCluster operation: Cannot use cluster security groups with NBD account

}

describe(){
	aws redshift describe-clusters --cluster-identifier mycluster
}

allow_remote(){

	aws redshift authorize-cluster-security-group-ingress --cluster-security-group-name default --cidrip 178.159.0.0/16
#	An error occurred (InvalidParameterValue) when calling the AuthorizeClusterSecurityGroupIngress operation: VPC-by-Default customers cannot use cluster security groups

}

allow_remote_connection(){
	# node client works with created cluster in browser console with group name MySecurityGroup
	#  aws redshift create-cluster doesn't work with --cluster-security-groups flag
	aws ec2 authorize-security-group-ingress --group-name MySecurityGroup --protocol tcp --port 5439 --cidr 178.159.0.0/16
}

delete(){
	aws redshift delete-cluster --cluster-identifier mycluster  --skip-final-cluster-snapshot
}

$@