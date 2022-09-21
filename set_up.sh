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
			export PROTOCOL=$2
			shift 2
			;;
		--hostpubsha256)
			export PUBSHA256=$2
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

# Source and define parameters here
source config.sh

if [[ -z $PROTOCOL ]];then
	export PROTOCOL=$DEFAULT_PROTOCOL
fi

if [[ $PROTOCOL == "sftp" ]] && [[ -z $PUBSHA256 ]];then
	echo "Error: Need to provide --hostpubsha256 for sftp protocol"
fi

# Use URI as a reference to generate file name (e.g. resource1.com/file -> resourc1.com-file)
# This will prevent name clashes
NORMALIZED_FILENAME=$(echo $URI | tr "[/,:,@]" "-" | tr -s "-")
FILEPATH="$DEFAULT_DIR/$NORMALIZED_FILENAME"

# If the file name exists, then remove it to overwrite
if [[ -f $FILEPATH ]];then
	echo "File from the same URI exists. Replacing it with a new one"
	rm -vf $FILEPATH
fi
export OUTPUT=$FILEPATH
