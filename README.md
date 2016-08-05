# Overview
Basic Kafka image using Dockerize for templating config files

# Usage
This Kafka server will run in the foreground.  It is currently set up to only run standalone, not as a cluster.  It expects that zookeeper is already running.

There is some very basic config that can be changed using environment variables.  If not specified, these are set to reasonable defaults.

##### server.properties
* zookeeper.connect={{ .Env.ZOOKEEPER_HOST }}:{{ .Env.ZOOKEEPER_PORT }}

# Example
```
docker run -e ZOOKEEPER_HOST=zookeeper -e ZOOKEEPER_PORT=2181 ruppdog/kafka
```

# License and Author
Author: Tyler Ruppert

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.