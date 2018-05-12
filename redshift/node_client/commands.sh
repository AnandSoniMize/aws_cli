#!/usr/bin/env bash
set -ex
# https://stackoverflow.com/a/47086634/1024794
run(){
	npx babel-node app.js
}

$@