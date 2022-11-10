import std/asyncdispatch
import ./migration_user


proc main() =
  waitFor user()

main()
