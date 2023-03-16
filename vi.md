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

```:s/\(.*\)/\U\1\e: "%hiera{'\1'}"/g``` (One eyed fighting kirby)
```:s/\v.*/\U\0\e: "%hiera{'\0'}"/g``` (`\v` very magic) (`\0` group)

FOO: "%hiera{'foo'}"
BAR: "%hiera{'bar'}"
BAZ: "%hiera{'baz'}"

## Insert end of multiple lines

hello
foo
world
bar

```:s/.*/\0_url```

hello_url
foo_url
world_url
bar_url

## Insert in line

hello: "http://foo.bar"
foo: "http://foo.bar"
world: "http://foo.bar"
bar: "http://foo.bar"

```:s/\v(\w+)/\0_url```

hello_url: "http://foo.bar"
foo_url: "http://foo.bar"
world_url: "http://foo.bar"
bar_url: "http://foo.bar"
