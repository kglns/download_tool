#!/bin/bash
PS4='${LINENO}: '

# Pick up args and set up ENV vars
source set_up.sh $@

# To add a new protocol
# 1. Add a new case
# 2. Define a function
# 3. Export it as DOWNLOAD_FN (generic_download_fn will pick it up and handle the error in standardized way)
case $PROTOCOL in
	http|https|ftp)
		export CURL_URI="$PROTOCOL://$URI"
		export DOWNLOAD_FN=curl_fn
		;;
	sftp)
		export CURL_URI="$PROTOCOL://$URI"
		export DOWNLOAD_FN=secure_curl_fn
		;;
	*)
		echo "$PROTOCOL is not supported"
		exit 0
		;;

esac

# curl-specific implementation
# This can be highly customized in conjunction with config.sh
curl_fn() {
	curl --fail-with-body --retry $RETRY --output $OUTPUT $CURL_URI 
}

secure_curl_fn() {
	curl --fail-with-body --hostpubsha256 $PUBSHA256--retry $RETRY --output $OUTPUT $CURL_URI 
}

# try a protocol-specific download fn and catch / handle errors
generic_download_fn() {
	{ 
		$DOWNLOAD_FN
	} || {
		echo "Download failed with error code $?: attempting to remove file $OUTPUT"
		if [[ ! -z $OUTPUT ]];then
			rm -vf $OUTPUT
		fi
		exit $?
	}
}

generic_download_fn $DOWNLOAD_FN && {
	echo "Download successful for file: $OUTPUT"
}
