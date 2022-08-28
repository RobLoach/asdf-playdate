# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test playdate https://github.com/RobLoach/asdf-playdate.git "pdc --help"
```

Tests are automatically run in GitHub Actions on push and PR.
