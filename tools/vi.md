# Vi

## Substitution

Using regex for search and replace

Problem: Rename environment variables

```diff
-foo
-bar
-baz
+FOO_URL
+BAR_URL
+BAZ_URL
```

Can be achieve like this

`:s/\(\w\+\)/\U\1_URL/`

```text
-- try for yourself
-- highlight the lines below lines below
foo
bar
baz
```

- `:s/` - Substitution
- `\(\w\+\)` - Select all characters
- `/` - Escape search
- `\U` - Uppercase following characters
- `\1` - Use capture group (\(\w\+\))
- `_URL` - Manually add after capture group
- `/` - Escape replace

You can instead use `very magic (\v)` mode to remove some of the
escape characters to make it a little easier to read.

`:s/\v(\w+)/\U\1_URL/`

```text
-- try for yourself
-- highlight the lines below lines below
foo
bar
baz
```

### Example: Rename environment variables

Rename list of variables within an environment file

```text
foo
bar
baz
```

- `:s/\v(.*)/\U\1\e: "%hiera{'\1'}"/g`
- (`\v` very magic) (`.*` select everything) (`\e` Escape uppercase)

```text
FOO: "%hiera{'foo'}"
BAR: "%hiera{'bar'}"
BAZ: "%hiera{'baz'}"
```
