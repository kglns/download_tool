#!/bin/bash

source set_up.sh $@

parallel_download_fn()
{
	COMMAND_STRING=""
	while read args;do
		COMMAND_STRING+="./single_download.sh ${args} & "
	done < ${CONFIG}

	FINAL_COMMAND=$(sed 's/.\{2\}$//' <<< "$COMMAND_STRING")
	eval $FINAL_COMMAND
}

# If URI is given in command line, assume that this is a single download
if [[ ! -z $URI ]];
then
	./single_download.sh --output $OUTPUT --uri $URI
else
	echo "Running parallel downloads"
	parallel_download_fn $CONFIG || exit $?
fi
exit 0

