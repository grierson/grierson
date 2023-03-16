# Vi

## Global rename

* Populate Quickfix list
  * Telescope live grep
  * `tab` the instances you want
  * `<C-q>` to send to Quickfix list
* `:cdo s/<find>/<replace>/gc`
  * `gc` to confirm each change

## Rename services for env

Rename list of services for config env file

foo
bar
baz

```:s/\(.*\)/\U\1\e: "%hiera{'\1'}"/g```

FOO: "%hiera{'foo'}"
BAR: "%hiera{'bar'}"
BAZ: "%hiera{'baz'}"
