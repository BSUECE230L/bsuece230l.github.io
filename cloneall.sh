#!/usr/bin/env bash

# find all the class json files
CLASSES=$(find -name class.json)

for class in $CLASSES; do
	repo=$(jq -r '.repo' $class)
	IFS='/' read -r -a path_parts <<< "$class"
	git clone $repo .classes/${path_parts[2]}
done
