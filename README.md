## Usage

1. Download single URI with specified protocol. If no protocol, defaults to https.
./download.sh -u example.com/filename -p https

2. Multiple URIs. You can define in a config file and pass in the file as param.
./download.sh -c uris.cfg

3. Parallel download. Same as 2. It runs all uris provided in cfg in parallel.

4. To configure download location | number of retries, edit config.sh

## Architecture

This tool has 4 components.

1. set_up.sh
It parses cmd args, loads default params, and make them available in environment.
It also handles file name clashes.

2. config.sh
It encapsulates default params such as download location, retries, etc.

3. single_download.sh
It maps download_fn by protocol and handles errors in standardized way.
To add a new protocol, simply define a download_fn and map it in case statment.

4. download.sh
It picks up cmd args and routes to single download or parallel download. 
