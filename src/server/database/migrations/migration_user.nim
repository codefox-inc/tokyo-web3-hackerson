import std/asyncdispatch
import std/json
import allographer/schema_builder
from ../../config/database import rdb


proc user*() {.async.} =
  rdb.create(
    table("user", [
      Column.string("twitter_id").index(),
      Column.string("wallet_address").index(),
      Column.timestamps()
    ])
  )
