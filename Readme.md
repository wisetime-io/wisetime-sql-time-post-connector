# WiseTime SQL Time Post Connector

## About

The WiseTime SQL Post Time Connector connects [WiseTime](https://wisetime.io) to SQL databases, and will automatically:

* Record a new time registration in the Database, based on the provided Queries whenever a user posts time to WiseTime

In order to use the WiseTime SQL Post Time Connector Connector, you will need a [WiseTime Connect](https://wisetime.io/docs/connect/) API key.

## Configuration

Configuration is done through environment variables. The following configuration options are required.

| Environment Variable               | Description                                                                |
| ---------------------------------- | -------------------------------------------------------------------------- |
| API_KEY                            | Your WiseTime Connect API Key                                              |
| JDBC_URL                           | The JDBC URL for your database                                             |
| DB_USER                            | Username to use to connect to the database                                 |
| DB_PASSWORD                        | Password to use to connect to the database                                 |
| NARRATIVE_PATH                     | Path to the narrative formatter template                                   |
| NARRATIVE_INTERNAL_PATH            | Path to the internal narrative formatter template                          |
| TIME_POST_SQL_PATH                 | Path to yaml file containing all required time posting queries             |
| TAG_UPSERT_PATH                    | The WiseTime tag upload folder, must be set to the same value as in your tag sync connector |


The following configuration options are optional.

| Environment Variable      | Description                                                                                                                                                                                                                                    |
| ------------------------- | -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| CALLER_KEY                | The caller key that WiseTime should provide with post time webhook calls. The connector does not authenticate Webhook calls if not set.                                                                                                        |
| DATA_DIR                  | If set, the connector will use the directory as the location for storing data to keep track of the already posted time. By default, WiseTime Connector will create a temporary dir under `/tmp` as its data storage. |
| RECEIVE_POSTED_TIME       | If unset, this defaults to `LONG_POLL`: use long polling to fetch posted time. Optional parameters are `WEBHOOK` to start up a server to listen for posted time. `DISABLED` no handling for posted time                                        |
| TAG_SCAN                  | If unset, this defaults to `ENABLED`: Set mode for scanning external system for tags and uploading to WiseTime. Possible values: ENABLED, DISABLED.                                                                                            |
| WEBHOOK_PORT              | The connector will listen to this port e.g. 8090, if RECEIVE_POSTED_TIME is set to `WEBHOOK`. Defaults to 8080.                                                                                                                                |                                                                                                                
| LOG_LEVEL                 | Define log level. Available values are: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` and `OFF`. Default is `INFO`.                                                                                                                                |
| TIMEZONE                  | The timezone to use when posting time, e.g. `Australia/Perth`. Defaults to `UTC`.                                                                                                                                                  |

## Running the WiseTime SQL Post Time Connector

The easiest way to run the SQL Post Time Connector is using Docker. Please see the example folder for an example docker-compose.yaml and other necessary configuration files.

If you are using `RECEIVE_POSTED_TIME=WEBHOOK`: Note that you need to define port forwarding in the docker run command (and similarly any docker-compose.yaml definition). If you set the webhook port other than default (8080) you must also add the WEBHOOK_PORT environment variable to match the docker ports definition.

## Building

To build a Docker image of the WiseTime SQL Post Time Connector, run:

```text
make docker
```
