#!/bin/bash
# set -x

while (("$#")); do
	case "$1" in
		-u|--uri)
			export URI=$2
			shift 2
			;;
		-c|--config)
			export CONFIG=$2
			shift 2
			;;
		-o|--output)
			export OUTPUT=$2
			shift 2
			;;
		-p|--protocol)
			PROTOCOL=$2
			shift 2
			;;
		--)
			shift
			break
			;;
		-*|--*=)
			echo "Error: Unsupported flag $1" >&2
			exit 1
			;;
		*)
			PARAMS="$PARAMS $1"
			shift
			;;
	esac
done

# Define default parameters here
source config.sh

if [[ -z $PROTOCOL ]];then
	export PROTOCOL=$DEFAULT_PROTOCOL
fi

if [[ -z $OUTPUT ]];then
	NORMALIZED_FILENAME=$(echo $URI | tr "[/,:]" "-" | tr -s "-")
	FILEPATH="$DEFAULT_DIR/$NORMALIZED_FILENAME"

	if [[ -f $FILEPATH ]];then
		echo "File from the same URI exists. Replacing it with a new one"
		rm -vf $FILEPATH
	fi
	export OUTPUT=$FILEPATH
else
	if [[ -f $OUTPUT ]];then
		echo "File from the same URI exists. Replacing it with a new one"
		rm -vf $OUTPUT
	fi
fi
