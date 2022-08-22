#!/bin/bash

defaultPipeline="pipeline"
customPipelineChoice="custom"

dpkg -s "jq" &> /dev/null

if [[ $? -ne 0 ]]; then
  echo -e "'jq' not found !\n"
  echo -e "MacOS install: brew install jq\n"
  echo -e "Ubuntu install: sudo apt-get install jq\n"
  echo -e "Redhat install: sudo yum install jq\n"
	exit 1
fi

if [[ ! -e $1 ]]; then
	echo "File does not exist"
	exit 1
fi

result=$(jq --arg defaultOwner "$(git config user.name)" 'del(.metadata)
	| .pipeline.version=.pipeline.version+1
	| .pipeline.stages[0].actions[0].configuration.Branch="main"
	| .pipeline.stages[0].actions[0].configuration.Owner=$defaultOwner
	| .pipeline.stages[0].actions[0].configuration.PollForSourceChanges=false' $1)

while :; do
  case $2 in
    --branch)
			result=$(jq -r --arg branch "$3" '.pipeline.stages[0].actions[0].configuration.Branch=$branch' <<< $result)
			;;
		--owner)
			result=$(jq -r --arg owner "$3" '.pipeline.stages[0].actions[0].configuration.Owner=$owner' <<< $result)
			;;
		--configuration)
			result=$(jq -r --arg conf "$3" '.pipeline.stages[].actions[].configuration.EnvironmentVariables=$conf|tostring' <<< $result)
			;;
		--poll-for-source-changes)
			result=$(jq -r --arg poll "$3" '.pipeline.stages[0].actions[0].configuration.PollForSourceChanges=$poll"' <<< $result)
			;;
			*) break
    esac
    shift 2
done

echo $result | jq '.' > ./new-pipeline.json

exit 0
