[![Build Status](https://travis-ci.org/hapi-server/server-nodejs.png?branch=master)](https://travis-ci.org/hapi-server/server-nodejs)

# HAPI Server Front-End

A generic HAPI front-end server.

## Contents

1. [About](#About)
2. [Installation](#Installation)
3. [Examples](#Examples)
4. [Server Configuration](#Server_Configuration)
5. [Metadata](#Metadata)
6. [Development](#Development)
7. [Contact](#Contact)

<a name="About"></a>
## 1. About
The intended use for this server-side software is a data provider wants to serve data through a [HAPI API](https://github.com/hapi-server/data-specification). With this software, the data provider only needs

1. [HAPI](https://github.com/hapi-server/data-specification) metadata, in one of a [variety of forms](#Metadata), for a collection of datasets and
2. a command-line program that returns at least [headerless HAPI CSV](https://github.com/hapi-server/data-specification/blob/master/hapi-dev/HAPI-data-access-spec-dev.md#data-stream-content) for all parameters in the dataset over the full time range of available data. Optionally, the command line program can take inputs of a start and stop time, a list of one or more parameters to output, and an output format

to be able to serve data from a HAPI API from their server. This software handles

1. HAPI metadata validation,
2. request validation and error responses,
3. self-signed HTTPS certificate generation,
3. logging and alerts,
4. time and parameter subsetting (as needed), and
5. generation of [HAPI JSON](https://github.com/hapi-server/data-specification/blob/master/hapi-dev/HAPI-data-access-spec-dev.md#data-stream-content) or [HAPI binary](https://github.com/hapi-server/data-specification/blob/master/hapi-dev/HAPI-data-access-spec-dev.md#data-stream-content) (as needed).

A list of catalogs that are served using this software is given at [http://hapi-server.org/servers]([http://hapi-server.org/servers]).

<a name="Installation"></a>
## 2. Installation

[Binary packages](https://github.com/hapi-server/server-nodejs/releases) are available for OS-X x64, Linux x64, and Linux ARMv7l (e.g., Rasberry Pi).

A [Docker image](https://cloud.docker.com/repository/docker/rweigel/hapi-server) is also available.

Installation and startup commands are given below the binary packages and docker image. See the [Development](#Development) section for instructions on installing from source.

OS-X x64:

```bash
 curl -L https://github.com/hapi-server/server-nodejs/releases/download/v0.9.5/hapi-server-v0.9.5-darwin-x64.tgz | tar zxf -
 cd hapi-server-v0.9.5
 ./hapi-server --open
```

Linux x64:

```bash
 curl -L https://github.com/hapi-server/server-nodejs/releases/download/v0.9.5/hapi-server-v0.9.5-linux-x64.tgz | tar zxf -
 cd hapi-server-v0.9.5
 ./hapi-server --open
```

Linux ARMv7l:

```bash
 curl -L https://github.com/hapi-server/server-nodejs/releases/download/v0.9.5/hapi-server-v0.9.5-linux-armv7l.tgz | tar zxf -
 cd hapi-server-v0.9.5
 ./hapi-server --open
```

Docker:

```
docker pull rweigel/hapi-server:v0.9.5
docker run -dit --name hapi-server-v0.9.5 --expose 8999 -p 8999:8999 rweigel/hapi-server:v0.9.5
docker exec -it hapi-server-v0.9.5 ./hapi-server
# Open http://localhost:8999/TestData/hapi in a web browser
```

<a name="Examples"></a>
## 2. Examples

### List of Included Examples

The following examples are included in the [metadata](https://github.com/hapi-server/server-nodejs/blob/master/metadata/) directory. The examples can be run using

```
./hapi-server -f metadata/FILENAME.json
```

where `FILENAME.json` is one of the file names listed below (e.g., `Example0.json`).

* [Example0.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example0.json) - A Python program dumps a full dataset in the headerless HAPI CSV format; the server handles time and parameter subsetting and creation of HAPI Binary and JSON. See section 2.1.
* [Example1.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example1.json) - Same as Example0 except the Python program handles time subsetting.
* [Example2.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example2.json) - Same as Example0 except the Python program handles time and parameter subsetting and creation of HAPI CSV and Binary. See section 2.2.
* [Example3.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example3.json) - Same as Example2 except for HAPI info metadata for each dataset is stored in an external file.
* [Example4.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example4.json) - Same as Example2 except for HAPI info metadata for each dataset is generated by a command-line command.
* [Example5.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example5.json) - Same as Example2 except catalog metadata is stored in an external file.
* [Example6.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example6.json) - Same as Example2 except catalog metadata is generated by a command-line command.
* [Example7.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example7.json) - Same as Example2 except that catalog metadata is returned from a URL.
* [Example8.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example8.json) - A dataset in headerless HAPI CSV format is stored in a single file; the server handles parameter and time subsetting and creation of HAPI JSON and Binary.
* [Example9.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example9.json) - A dataset in headerless HAPI CSV format is returned by a URL; the server handles parameter and time subsetting and creation of HAPI JSON and Binary.
* [AutoplotExample1.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/AutoplotExample1.json) - A dataset is stored in multiple files and AutoplotDataServer is used to subset in time. See section 2.6.
* [AutoplotExample2.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/AutoplotExample2.json) - A dataset is stored in a CDF file and AutoplotDataserver is used to generate HAPI CSV. See section 2.6.
* [TestData.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/TestData.json) - A test dataset used to test HAPI clients.
* [SSCWeb.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/SSCWeb.json) - Data from a non-HAPI web service is made available from a HAPI server. See section 2.3.
* [INTERMAGNET.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/INTERMAGNET.json) - Data in ASCII files on an FTP site is made available from a HAPI server. See section 2.4.
* [QinDenton.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/QinDenton) - Data in a single ASCII file is converted to headerless HAPI CSV by a Python program. See section 2.5.

### 2.1 Serve data from a minimal Python program

In this example, we assume that the command line program that returns a dataset has the minimal capabilities required - when executed, it generates a headerless HAPI CSV file with all parameters in the dataset over the full time range of available data. The server handles time and parameter subsetting and the generation of HAPI Binary and JSON.

The Python script [Example.py](https://github.com/hapi-server/server-nodejs/blob/master/bin/Example.py) returns HAPI-formatted CSV data (with no header) with two parameters. To serve this data, only a configuration file, [Example0.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example0.json), is needed. The configuration file has information that is used to call the command line program and it also has HAPI metadata that describes the output of [Example.py](https://raw.githubusercontent.com/hapi-server/server-nodejs/master/bin/Example.py). Details about the configuration file format are described in the [Metadata](#Metadata) section.

The Python calling syntax of [Example.py](https://github.com/hapi-server/server-nodejs/blob/master/bin/Example.py) is

```
python Example.py
```

To run this example locally after [installation](#Install), execute

```bash
./hapi-server --file metdata/Example0.json
```

and then open [http://localhost:8999/Example1/hapi](http://localhost:8999/Example0/hapi). You should see the same landing page as that at [http://hapi-server.org/servers/Example0/hapi](http://hapi-server.org/servers/Example1/hapi). Note that the `--open` command-line switch can be used to automatically open the landing page, e.g.,

```bash
./hapi-server --file metdata/Example0.json --open
```

### 2.2 Serve data from an enhanced Python program

The Python script [Example.py](https://github.com/hapi-server/server-nodejs/blob/master/bin/Example.py) actually can subset parameters and time and provide binary output. To force the server to use these capabilities, we need to modify the server configuration metadata in [Example1.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example2.json). The changes are replacing

```
"command": "python bin/Example.py"
```

with

```
"command": "python bin/Example.py --params ${parameters} --start ${start} --stop ${stop} --fmt ${format}"
```

and adding

```
"formats": ["csv","binary"]
```

The modified file is [Example2.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example2.json). To run this example locally after [installation](#Install), execute

```bash
./hapi-server --file metadata/Example2.json
```

and then open [http://localhost:8999/Example2/hapi](http://localhost:8999/Example2/hapi).  The command-line program now produces binary output and performs parameter subsetting as needed and the response time for data should decrease.

The server responses will be identical to that in the previous example. You should see the same landing page as that at [http://hapi-server.org/servers/Example2/hapi](http://hapi-server.org/servers/Example2/hapi).

### 2.3 Serve data from a non-HAPI web service

A non-HAPI server can be quickly made HAPI compliant by using this server as a pass-through. Data from [SSCWeb](https://sscweb.sci.gsfc.nasa.gov/), which is available from a [REST API](https://sscweb.sci.gsfc.nasa.gov/WebServices/REST/), has been made available through a HAPI API at [http://hapi-server.org/servers/SSCWeb/hapi](http://hapi-server.org/servers/SSCWeb/hapi). The configuration file is [SSCWeb.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/SSCWeb.json) and the command line program is [SSCWeb.js](https://github.com/hapi-server/server-nodejs/blob/master/bin/SSCWeb.js). Note that the metadata file [SSCWeb.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/SSCWeb.json) was created using code in [metadata/SSCWeb](https://github.com/hapi-server/server-nodejs/blob/master/metadata/SSCWeb).

To run this example locally after [installation](#Install), execute

```bash
./hapi-server --file metadata/SSCWeb.json --open
```

You should see the same landing page as that at [http://hapi-server.org/servers/SSCWeb/hapi](http://hapi-server.org/servers/SSCWeb/hapi).

### 2.4 Serve data stored in a single file

The [Qin-Denton](http://virbo.org/QinDenton) dataset contains multiple parameters stored in a single large file.

The command-line program that produces HAPI CSV from this file is [QinDenton.py](https://github.com/hapi-server/server-nodejs/blob/master/bin/QinDenton.py) and the metadata is in [QinDenton.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/QinDenton.json).

To run this example, use

```
./hapi-server --file metadata/QinDenton.json
```

### 2.5 Serve data stored in multiple files

[INTERMAGNET](http://intermagnet.org) has ground magnetometer data stored in daily files from over 150 magnetometer stations at 1-minute and 1-second cadence made available from a [FTP site](ftp://ftp.seismo.nrcan.gc.ca).

The command-line program that produces HAPI CSV is [INTERMAGNET.py](https://github.com/hapi-server/server-nodejs/blob/master/bin/INTERMAGNET.py) and the metadata is in [INTERMAGNET.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/INTERMAGNET.json). The code that produces the metadata is in [metadata/INTERMAGNET](https://github.com/hapi-server/server-nodejs/blob/master/metadata/INTERMAGNET/). To run this example, execute

```
./hapi-server --file metadata/INTERMAGNET.json --open
```

### 2.6 Serve data read by Autoplot

Nearly any data file that can be read by [Autoplot](http://autoplot.org/) can be served using this server.

Serving data requires at most two steps:

1. Generating an Autoplot URI for each parameter; and (in some cases)
2. Writing (by hand) metadata for each parameter.

**Example 1**

The first example serves data stored in a single CDF file. The configuration file is [AutoplotExample1.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/AutoplotExample1.json).

In this example, step 2. above (writing metadata by hand) is not required because the data file has metadata that is in a format that Autoplot can translate to HAPI metadata.

To run this example locally, execute

```bash
./hapi-server --file metadata/AutoplotExample1.json
```

**Example 2**

The second example serves data stored in multiple ASCII files. The configuration file is [AutoplotExample2.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/AutoplotExample2.json).

To run this example locally, execute

```bash
./hapi-server --file metadata/AutoplotExample2.json
```

<a name="Usage"></a>
## 3. Usage

List command-line options:

```bash
./hapi-server -h

  --help, -h    Show help
  --file, -f    Catalog configuration file
  --port, -p    Server port [default:8999]             
  --conf, -c    Server configuration file
  --ignore, -i  Start server even if metadata errors
  --open, -o    Open web page on start
  --test, -t    Run URL tests and exit
  --verify, -v  Run verification tests and exit
```

Basic usage:

```
./hapi-server --file metdata/TestData.json
```

Starts HAPI server at [http://localhost:8999/TestData/hapi](http://localhost:8999/hapi) and serves datasets specified in the catalog [./metadata/TestData.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/TestData.json).

Multiple catalogs can be served by providing multiple catalog files on the command line:

```bash
./hapi-server --file CATALOG1.json --file CATALOG2.json
```

For example

```bash
./hapi-server --file metadata/TestData.json --file metadata/Example1.json
```
will serve the two datasets at

```
http://localhost:8999/TestData/hapi
http://localhost:8999/Example1/hapi
```

And the page at `http://localhost:8999/` will point to these two URLs.

<a name="Server_Configuration"></a>
## 4. Server Configuration

### 4.1 `conf/config.json`

The variables `HAPISERVERPATH`, `HAPISERVERHOME`, `NODEEXE`, and `PYTHONEXE` can be set in `conf/config.json` or as environment variables. These variables can be used in commands, files, and URLs in the server metadata (the file passed using the command-line `--file` switch).

The default configuration file is `conf/config.json` and this location can be set using a command-line argument, e.g.,

```
./hapiserver -c /tmp/config.json
```

To set variables using environment variables, use, e.g.,

```
PYTHONEXE=/opt/python/bin/python ./hapi-server
```

Variables set as environment variables take precedence over those set in `conf/config.json`.

**`HAPISERVERPATH`** and **`HAPISERVERHOME`**

These two variables can be used in metadata to reference a directory. For example,

```
"catalog": "$HAPISERVERHOME/mymetadata/Data.json"
```

By default, `$HAPISERVERPATH` is the installation directory (the directory containing the shell launch script `hapi-server`) and should not be changed as it is referenced in the demonstration metadata files. Modify `HAPISERVERHOME` in `conf/config.json` to use a custom path.

All relative paths in commands in metadata files are relative to the directory where `hapi-server` was executed.

For example, if

```
/tmp/hapi-server
```

is executed from `/home/username`, the file

```
/home/username/metadata/TestData.json`
```

is read and relative paths in `TestData.json` have `/home/username/` prepended.

**`PYTHONEXE`**

This is the command used to call Python. By default, it is `python`. If `python` is not in the path, this can be set using a relative or absolute path. Python is used by several of the demonstration catalogs.

Example:

```
"command": "$PYTHONEXE $HAPISERVERHOME/mybin/Data.py"
```

**`NODEEXE`**

This is the command used to call NodeJS. By default, it is the command used to start the server. The start-up script looks for a NodeJS executable in `$HAPISERVERPATH/bin` and then tries `node` and then `nodejs`.


### 4.2 Apache

To expose a URL through Apache, (1) enable `mod_proxy` and `mod_proxy_http`, (2) add the following in a `<VirtualHost>` node in a [Apache Virtual Hosts](https://httpd.apache.org/docs/2.4/vhosts/examples.html) file

```
<VirtualHost *:80>
	ProxyPass /TestData http://localhost:8999/TestData retry=1
	ProxyPassReverse /TestData http://localhost:8999/TestData
</VirtualHost>
```

and (3) `Include` this file in the Apache start-up configuration file.

If serving multiple catalogs, use

```
<VirtualHost *:80>
	ProxyPass /servers http://localhost:8999/servers retry=1
	ProxyPassReverse /servers http://localhost:8999/servers
</VirtualHost>
```

### 4.3 Nginx

For Nginx, add the following to `nginx.conf`

```
location /TestData {
    proxy_pass http://localhost:8999/TestData;
}
```

If serving multiple catalogs, use

```
location /servers {
    proxy_pass http://localhost:8999/servers;
}
```

<a name="Metadata"></a>
## 5. Metadata

The metadata required for this server is similar to the `/catalog` and `/info` response of a HAPI server.

* Example HAPI [`/catalog`](http://hapi-server.org/servers/TestData/hapi/catalog) response
* Example HAPI [`/info`](http://http://hapi-server.org/servers/TestData/hapi/info?id=dataset1) response

The server requires that the `/catalog` response is combined with the `/info` response for all datasets in the catalog in a single JSON catalog configuration file. Additional information about how to generate data must also be included in this JSON file.
 
The top-level structure of the configuration file is

```
{
	"server": { // See section 5.1
		"id": "",
		"prefix": "",
		"landing": "",
		"contact": "", 
		"landingFile": "",
		"landingPath": "",
		"catalog-update": null
	},
	"catalog": array or string // See section 5.2
	"data": { // See section 5.3
	    "command": "Command line template",
	     or
	    "file": "HAPI CSV file"
	    "fileformat": "one of 'csv', 'binary', 'json'"
	     or
	    "url": "URL that returns HAPI data"
	    "urlformat": "one of 'csv', 'binary', 'json'"
	    "contact": "Email address if error in command line program",
	    "testcommands": [
	    		{
		    		"command": string,  
		    		"Nlines": integer,
		    		"Nbytes": integer,
		    		"Ncommas", integer
	    		},
	    		...
	    	]
	    "testurls": [
	    		{
		    		"url": string,  
		    		"Nlines": integer,
		    		"Nbytes": integer,  
		    		"Ncommas": integer
	    		},
	    		...
	    	]
	},

}
```

A variety of examples are given in [`./metadata`](https://github.com/hapi-server/server-nodejs/blob/master/metadata/) and described below along with options for the catalog property.

The string `command` in the data node is a command that produces a headerless HAPI data response and can have placeholders for time range of data to return (using start (`${start}`) and stop (`${stop}`)), a dataset id (`${id}`), a comma-separated list of parameters (`${parameters}`) and an output format (`${format}`). For example,

```bash
python ./bin/Example.py --dataset ${id} --parameters \
	${parameters} --start ${start} --stop ${stop} --format ${format}"`
```

### 5.1 `server`

The server node has the form

```
"server": {
	"id": "", 		// Default is file name without extension.
	"prefix": "", 	// Default is id.
	"contact": "", 	// Required. Server will not start without this set.
	"landingFile": "",
	"landingPath": "",
	"catalog-update": null // How often in seconds to re-read content
						   // in the catalog node (5.2).
}
```

#### 5.1.1 `id` and `prefix`

The `id` is by default the name of the server configuration file, e.g.,

```
./hapi-server --file metadata/TestData.json
```

then `id=TestData` and `prefix=TestData`.

By default, this catalog would be served from

```
http://localhost:8999/TestData/hapi
```

`TestData` in the URL can be changed to `TestData2` by using `prefix=TestData2`.

#### 5.1.2 `contact`

This element must not be empty or the server will not start. It should be at minimum the email address of a system administrator.

#### 5.1.3 `landingFile` and `landingPath`

`landingFile` is the file to serve in response to requests for

```
http://localhost:8999/TestData/hapi
```

By default, the landing page served is [single.htm](https://github.com/hapi-server/server-ui/blob/master/single.htm) from the HAPI server UI codebase. The double underscore variables in this file are replaced using the information in the metadata file (e.g., `__CONTACT__` is replaced with the `server.contact` value. A different landing page can be served by setting the `landingFile` configuration variable, e.g. `"landingFile": "$HAPISERVERPATH/public/index.htm"`, where `$HAPISERVERPATH` is described in [Server Configuration](#Server_Configuration). 

If `landingFile` has local CSS and JS dependencies, set `landingPath` to be the local directory of the referenced files. Several possible settings are

```javascript
	"landingFile": "$HAPISERVERPATH/index.htm", 
	// $HAPISERVERPATH will be replaced with location of hapi-server binary
	"landingPath": "/var/www/public/" // Location of CSS and JS files
	// If index.htm has <script src="index.js">, index.js should be in /var/www/public/
```

To serve a directory listing, use

```javascript
	"landingFile": "",
	"landingPath": "/var/www/public/"
	// Server will look for index.htm and index.html in /var/www/public/. If not
	// found, directory listing of /var/www/public/ will be served.
```

#### 5.1.4 `catalog-update`

This is an integer number of seconds corresponding to how often the `catalog` node should be updated. Use this if the `catalog` node is not static.

### 5.2 `catalog`

The `catalog` node can be either a string or an array.

In the case that it is an array, it should contain either the combined HAPI `/catalog` and `/info` response (5.2.1) or a `/catalog` response with references to the `\info` response (5.2.1).

In the case that it is a string (5.2.3), the string is either a file containing a catalog array or a command-line template that returns a catalog array. 

#### 5.2.1 Combined HAPI `/catalog` and `/info` object

If `catalog` is an array, it should have the same format as a HAPI `/catalog` response (each object in the array has an `id` property and optional `title` property) **with the addition** of an `info` property that is the HAPI response for that `id`, e.g., `/info?id=dataset1`. 

```json
"catalog":
 [
	{
		"id": "dataset1",
		"title": "a dataset",
		"info": {
				"startDate": "2000-01-01Z",
				"stopDate": "2000-01-02Z",
				"parameters": [...]
		}
	},
	{
		"id": "dataset2",
		"title": "another dataset",
		"info": {
			"startDate": "2000-01-01Z",
			"stopDate": "2000-01-02Z",
			"parameters": [...]
		}
	}
 ]
```

In the following subsections, this type of JSON structure is referred to as a **fully resolved catalog**.

Examples of this type of catalog include

* [Example1.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example1.json)
* [TestData.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/TestData.json)

#### 5.2.2 `/catalog` response with file or command template for `info` object


The `info` value can be a path to an `info` JSON file

```json
"catalog":
 [
	{
		"id": "dataset1",
		"title": "a dataset",
		"info": "relativepath/to/dataset2/info_file.json"
	},
	{
		"id": "dataset2",
		"title": "another dataset",
		"info": "/absolutepath/to/dataset2/info_file.json"
	}
 ]
```
See also [Example3.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example3.json).

Alternatively, the metadata for each dataset may be produced by the execution of a command-line program for each dataset. For example, in the following, `program1` should result in a HAPI JSON response from `/info?id=dataset1` to `stdout`. Before execution, the string `${id}`, if found, is replaced with the requested dataset ID. Execution of `program2` should produce the HAPI JSON corresponding to the query `/info?id=dataset2`. 

```json
"catalog":
 [
	{
		"id": "dataset1",
		"title": "a dataset",
		"info": "bin/program --id ${id}"
	},
	{
		"id": "dataset2",
		"title": "another dataset",
		"info": "program2"
	}
 ]
```
See also [Example4.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example4.json).

#### 5.2.3 References to a command-line template or file

The `catalog` value can be a command-line program that generates a fully resolved catalog, e.g.,

```json
"catalog": "program --arg1 val1 ..."
```

The command-line command should return the response of an `/info` query (with no `id` argument). 

The path to a fully resolved catalog can also be given. See also [Example5.json](https://github.com/hapi-server/server-nodejs/blob/master/metadata/Example4.json).

### 5.3 `data`

<a name="HTTPS Support"></a>
## 6. HTTPS Support

```bash
# Start the HTTPS server. This shall generate the SSL certificates and starts the HTTPS server
node server.js --https

#Providing the path of certificates explicitly
node server.js --https --cert certPath --key keyPath

# Generate certificates, start HTTPS server and run the test-suite
npm run-script test-https


```


<a name="Development"></a>
## 7. Development

### 7.1 Installation
Install [nodejs](https://nodejs.org/en/download/) (tested with v8) using either the [standard installer](https://nodejs.org/en/download/) or [NVM](https://github.com/creationix/nvm#install--update-script).

<details>
  <summary>Show NVM installation notes</summary>

See also https://github.com/nvm-sh/nvm#install--update-script

```bash
# Install Node Version Manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Open a new shell (see displayed instructions from above command)

# Install and use node.js version 8
nvm install 8
```
</details>

```bash
# Clone the server repository
git clone https://github.com/hapi-server/server-nodejs

# Install dependencies
cd server-nodejs; npm install

# Start server
node server.js

# Run tests; Python 2.7+ required for certain tests.
npm test
```

<a name="Contact"></a>
## 8. Contact

Please submit questions, bug reports, and feature requests to the [issue tracker](https://github.com/hapi-server/server-nodejs/issues).
