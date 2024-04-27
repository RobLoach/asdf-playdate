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

The following covers how to install Playdate with asdf.

## Plugin

First, install the plugin with:

```shell
asdf plugin add playdate https://github.com/RobLoach/asdf-playdate.git
```

## Playdate

Once the plugin is installed, you can install a version of the Playdate SDK:

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

## PLAYDATE_SDK_PATH

Now that Playdate is set up, you can [add the `PLAYDATE_SDK_PATH` environment variable](https://sdk.play.date/2.4.2/Inside%20Playdate%20with%20C.html#_set_playdate_sdk_path_environment_variable) by appending the following to your shell's initialization script, like `~/.bashrc`...

### Bash

```
. ~/.asdf/plugins/playdate/setup.bash
```

### zsh
```
. ~/.asdf/plugins/playdate/setup.zsh
```

### Fish
```
. ~/.asdf/plugins/playdate/setup.fish
```

### Nushell
```
. ~/.asdf/plugins/playdate/setup.nu
```

### Xonsh
```
. ~/.asdf/plugins/playdate/setup.xsh
```

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/RobLoach/asdf-playdate/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Rob Loach](https://github.com/RobLoach/)
