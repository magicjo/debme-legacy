![debme logo](./doc/logo/debme-logo-300x300.png)

`debme` is a simple project to deploy my *debian* environment.

## Install

To install/uninstall `debme` in your computer, you need to have the `make` software (`apt-get install --yes make`) and the right access to edit the directories `/opt` and `/usr/local/bin` (`root`).

To install or update, you have just to run
```bash
make install
```

To uninstall, you have just to run
```bash
make uninstall
```

## Usage

### Setup

First you must run the `setup` task for your remotes hosts (only once for beginning).
Description of the options are available on the [cli setup page](./doc/cli/setup.md).
```bash
debme setup --envs hosts.json -vvvv
```

## Develop

You can develop `debme` on your own local computer.
For more information you can see the [contributing page](./CONTRIBUTING.md).

```bash
git clone git@github.com:magicjo/debme.git
cd debme/src
./debme.sh --help
```

## Test

**WIP**
