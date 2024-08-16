export def main [] {
  decipher_surveys | where ($it not-in snowflake_surveys)
}
