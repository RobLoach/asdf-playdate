<div align="center">

# asdf-playdate [![Build](https://github.com/RobLoach/asdf-playdate/actions/workflows/build.yml/badge.svg)](https://github.com/RobLoach/asdf-playdate/actions/workflows/build.yml) [![Lint](https://github.com/RobLoach/asdf-playdate/actions/workflows/lint.yml/badge.svg)](https://github.com/RobLoach/asdf-playdate/actions/workflows/lint.yml)

[Playdate SDK](https://sdk.play.date/inside-playdate) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `curl`
- `tar`

# Install

Plugin:

```shell
asdf plugin add playdate https://github.com/RobLoach/asdf-playdate.git
```

playdate:

```shell
# Show all installable versions
asdf list-all playdate

# Install specific version
asdf install playdate latest

# Set a version globally (on your ~/.tool-versions file)
asdf global playdate latest

# Now playdate commands are available
pdc --version
PlaydateSimulator --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/RobLoach/asdf-playdate/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Rob Loach](https://github.com/RobLoach/)
