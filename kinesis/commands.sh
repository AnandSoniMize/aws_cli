#!/usr/bin/env bash
set -ex

list(){
	aws kinesis list-streams # https://youtu.be/YHfLNZPhvpY?t=429
#	{
#	    "StreamNames": []
#	}
}

create(){
	# https://youtu.be/YHfLNZPhvpY?t=465
	aws kinesis create-stream --stream-name myStream --shard-count 1
#	$ aws kinesis list-streams
#{
#    "StreamNames": [
#        "myStream"
#    ]
#}

}

describe(){
	# https://youtu.be/YHfLNZPhvpY?t=561
	aws kinesis describe-stream --stream-name myStream
}

put(){
	aws kinesis put-record --stream-name myStream --partition-key 123 --data "Hello. The time is 22:30:51"
}

put2(){
	aws kinesis put-record --stream-name myStream --partition-key 123 --data "Yo, man. The time is 22:30:51"
}

put3(){
	aws kinesis put-record --stream-name myStream --partition-key 123 --data "What's up. The time is 22:30:51"
#	{
#	    "ShardId": "shardId-000000000000",
#	    "SequenceNumber": "49584314458289571217211614765383606529712995655770701826"
#	}
}

iterator(){
	aws kinesis get-shard-iterator --shard-id shardId-000000000000 --shard-iterator-type TRIM_HORIZON --stream-name myStream | tee iterator.tmp
#	{
#	    "ShardIterator": "AAAAAAAAAAEKjdn32ddOYIuc8kA7t0JOIsh9R+FNn4zCR0PJW+dLbC8QOFLrzimwZPhnRSJzlSANitv7PWNUL514XmiuuUbLwVuNZHYWpHWgR6wnhg+uOKTrWK49FQoZnoJ8qlVAzExco1boKCktLOjzCL9wDDQOk9RKdi28cS+Wz3OK9Un++lH2ziDXMy/3EpDEpTexZckUMeCox45V+keHcIdUc44d"
#	}
}

get(){
	aws kinesis get-records --shard-iterator $(cat iterator.tmp | jq .ShardIterator) | tee nextIterator.tmp
#	{
#    "Records": [
#        {
#            "SequenceNumber": "49584314458289571217211614765381188678073756982852976642",
#            "ApproximateArrivalTimestamp": 1525894328.953,
#            "Data": "SGVsbG8uIFRoZSB0aW1lIGlzIDIyOjMwOjUx",
#            "PartitionKey": "123"
#        },
#        {
#            "SequenceNumber": "49584314458289571217211614765382397603893376972146868226",
#            "ApproximateArrivalTimestamp": 1525894407.124,
#            "Data": "WW8sIG1hbi4gVGhlIHRpbWUgaXMgMjI6MzA6NTE=",
#            "PartitionKey": "123"
#        },
#        {
#            "SequenceNumber": "49584314458289571217211614765383606529712995655770701826",
#            "ApproximateArrivalTimestamp": 1525894466.732,
#            "Data": "V2hhdCdzIHVwLiBUaGUgdGltZSBpcyAyMjozMDo1MQ==",
#            "PartitionKey": "123"
#        }
#    ],
#    "NextShardIterator": "AAAAAAAAAAF336/ckXNxoaRvn2cYc3KdMyKAGnXs/6fIoyB7oyxx/K7voyv4z70ZkEyleSn31aD4Qp9JduZbRo0izfQqVrIltKisLM3FwIH7c4y0gNScz3NLrzvM0bcyHnN2UCg68PfAmjcQPONeJmFvSyESQBgSEPUeUjBMYWFVo47aCavyluGYnmGGgDHD3+iDn1z8FaMVNvHfh6WYTL7YF6xbEacT",
#    "MillisBehindLatest": 0
#}
}

decode_base64(){
	echo SGVsbG8uIFRoZSB0aW1lIGlzIDIyOjMwOjUx | base64 --decode
}

get2(){
	# should give empty list
	# https://youtu.be/YHfLNZPhvpY?t=777
		aws kinesis get-records --shard-iterator $(cat nextIterator.tmp | jq .NextShardIterator) | tee nextIterator2.tmp


}

delete(){
	aws kinesis delete-stream --stream-name myStream
}

streams_in_all_regions(){
	../for_each_region.sh aws kinesis list-streams
}
$@