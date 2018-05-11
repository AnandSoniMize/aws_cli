#!/usr/bin/env bash
set -ex

create(){
# https://docs.aws.amazon.com/cli/latest/reference/redshift/create-cluster.html
#https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#how-many-nodes
	aws redshift create-cluster --node-type dc1.large --number-of-nodes 2 --master-username adminuser --master-user-password TopSecret1 --cluster-identifier mycluster
}

describe(){
	aws redshift describe-clusters --cluster-identifier mycluster
}

delete(){
	aws redshift delete-cluster --cluster-identifier mycluster  --skip-final-cluster-snapshot
}

$@