#!/bin/bash
<<COMMENT1
echo "--- Test for single URI; sets default dir and filename ---"
./download.sh -u "sample.txt"
echo "---"
echo ""

echo "--- Test for single URI with custom filename and protocol ---"
./download.sh -o "output.txt" -u "sample.txt" -p "ftp"
echo "---"
echo ""
COMMENT1
echo "--- Test for multiple URIs via config file ---"
./download.sh -c download.cfg
echo "---"
echo ""
