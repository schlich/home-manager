use std assert
use ingest_freshness.nu

let snowflake_surveys = ['a' 'b']
let decipher_surveys = ['b' 'a']

assert (snowflake_surveys | ingest_freshness)
