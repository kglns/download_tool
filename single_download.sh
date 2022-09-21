#!/bin/bash -e
PS4='${LINENO}: '

source set_up.sh $@

case $PROTOCOL in
	http|https|ftp|sftp)
		export CURL_URI="$PROTOCOL://$URI"
		export DOWNLOAD_FN=curl_fn
		;;
	*)
		echo "$PROTOCOL is not supported"
		exit 0
		;;

esac

curl_fn() {
	curl --silent --retry $RETRY --output $OUTPUT $CURL_URI 
}

generic_download_fn() {
	{ 
		$DOWNLOAD_FN
	} || {
		echo "Download failed with error code $?: removing file $OUTPUT"
		if [[ ! -z $OUTPUT ]];then
			rm -vf $OUTPUT
		fi
		exit $?
	}
}

generic_download_fn $DOWNLOAD_FN



