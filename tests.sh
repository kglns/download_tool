#!/bin/bash
echo "--- Test for single URI; sets default dir and filename; download fails, removes file ---"
./download.sh -u "example.com/sample.txt"
echo "---"
echo ""

echo "--- Test for single URI with protocol; removes existing file and downloads; fails, removes file ---"
./download.sh -u "www.nasdaq.com/market-activity/stocks/aapl" -p "http"
echo "---"
echo ""

echo "--- Test for single URI with sftp protocol ---"
./download.sh -u "sftpuser@kaung.dev/text/hello.txt" -p "sftp" --hostpubsha256 $KEY
echo "---"
echo ""

echo "--- Test for parallel download; multiple URIs/protocols via config file ---"
./download.sh -c test_uris.cfg
echo "---"
echo ""

