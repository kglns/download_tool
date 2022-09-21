#!/bin/bash
PS4='${LINENO}: '

source set_up.sh $@

parallel_download_fn()
{
	COMMAND=""
	while read args;do
		COMMAND+="./single_download.sh ${args} & "
	done < ${CONFIG}

	FINAL_COMMAND=$(sed 's/.\{2\}$//' <<< "$COMMAND")
	echo "final command: $FINAL_COMMAND"
	
	eval $FINAL_COMMAND
}

if [[ -z $OUTPUT ]];
then
	echo "OUTPUT not found ${OUTPUT}"
	export OUTPUT="/tmp/${URI}"
fi

if [[ ! -z $URI ]];
then
	curl --silent --retry $RETRY --output $OUTPUT $URI
else
	echo "Running parallel downloads"
	parallel_download_fn $CONFIG || exit $?
fi
echo "Finished"
exit 0

