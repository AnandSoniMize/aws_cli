#!/usr/bin/env bash
set -ex
cmd=$@
if [ -z "$cmd" ]; then
	>&2 echo usage:
	>&2 echo "     $0 command_to_run_in_each_region"
	exit 1
fi
currentRegion=$(aws configure list | tail -1 | awk '{print $2}')
restuls=/tmp/$(date +%s)
echo $currentRegion > $restuls
cleanup(){
		aws configure set region $currentRegion
		aws configure list
}
trap cleanup EXIT
for region in $(aws ec2 describe-regions --query 'Regions[].{Name:RegionName}' --output text); do
	echo "region" $region | tee -a $restuls
	aws configure set region $region
	$cmd | tee -a $restuls
done

cat $restuls