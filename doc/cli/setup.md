# Setup cli

Command used to setup the remote environment for `debme`.
You must run this command once before install other tasks

## Example

```bash
dembe setup --envs hosts.json --hosts "serverX" "serverY" -vvvv
```

## Usage

```bash
debme setup --help
usage: debme setup [-h] --envs HOSTS_FILE [--verbose]
                   [--hosts HOST_NAME [HOST_NAME ...]]

optional arguments:
  -h, --help            show this help message and exit
  --envs HOSTS_FILE, -e HOSTS_FILE
                        environments hosts described by a json file
  --verbose, -v         verbosely list files processed
  --hosts HOST_NAME [HOST_NAME ...], -H HOST_NAME [HOST_NAME ...]
                        filtering defined hosts in environments by name for
                        execution
```

## --envs hosts.json

Environments hosts described by a json file.

### Model of hosts.json

```json
{
    "type": "object",
    "patternProperties": {
        "*": {
            // A host
            "type": "object",
            "properties": {
                "type": {
                    "type": "array",
                    "items": {
                        "enum": []
                    }
                    // The specifics role of the host
                },
                "connection": {
                    "type": "object"
                    // The connection parameters of the remote
                },
                "support_ui": {
                    "enum": ["yes", "no"]
                    // If the host support gui
                },
                "vars": {
                    "type": "object"
                    // Variables used by the tasks
                }
            },
            "required": ["connection", "support_ui"]
        }
    }
}
```

- Available connection parameters: [Ansible inventory parameters](http://docs.ansible.com/ansible/intro_inventory.html#list-of-behavioral-inventory-parameters)

### Example of hosts.json

```json
{
  "localhost": {
    "connection": {
        "ansible_connection": "ssh",
        "ansible_host": "localhost",
        "ansible_user": "me"
    },
    "support_ui": "no"
  },
  "my-server": {
    "connection": {
        "ansible_connection": "ssh",
        "ansible_host": "10.10.10.10",
        "ansible_user": "root",
        "ansible_ssh_pass": "123456789"
    },,
    "support_ui": "yes",
    "vars": {
        "setup": {
            ...
        },
        ...
    }
  }
}

```

### Vars of hosts.json

#### Setup.registry

- `setup`
    - `registry_apt` (*url*): The apt registry to use. By default (`"http://ftp.fr.debian.org/debian/"`)
    - `registry_apt_security` (*url*): The apt registry (for security) to use. By default (`"http://security.debian.org/"`)
    - `registry_apt_src` (*yes|no*): If you want the apt sources. By default (`"yes"`)
    - `registry_apt_backports` (*yes|no*): If you want the apt backports. By default (`"yes"`)

```json
{
  ...
  "vars": {
    "setup": {
      "registry_apt": "http://ftp.fr.debian.org/debian/",
      "registry_apt_security": "http://security.debian.org/",
      "registry_apt_src": "yes",
      "registry_apt_backports": "yes"
    }
  }
}
```

#### Setup.info

- `setup`
    - `info_system` (*yes|no*): If you want to show info about system. By default (`"yes"`)
    - `info_hardware` (*yes|no*): If you want to show info about hardware. By default (`"yes"`)
    - `info_disk` (*yes|no*): If you want to show info about disk. By default (`"yes"`)

```json
{
  ...
  "vars": {
    "setup": {
      "info_system": "yes",
      "info_hardware": "yes",
      "info_disk": "yes"
    }
  }
}
```

#### Setup.user

- `setup`
    - `user_login` (*str*): The user login to ensure. By default (`"user"`)
    - `user_identity` (*str*): The use name to ensure. By default (`"My User"`)
    - `user_password` (*hash*): The user password to ensure (use `mkpasswd --method=sha-512`). By default (`"password"`)
    - `user_shell` (*path*): The user default shell. By default (`"/usr/bin/fish"`)

```json
{
  ...
  "vars": {
    "setup": {
      "user_login": "user",
      "user_identity": "My User",
      "user_password": "$6$ZInTPAVe2FbY5UEV$X6bTmG4ZUgBAZ4j4BxhGBkGgtNSNwpCOa7lI/zJyTUHfN6GLgRe4JF/.L228ozUlutAbJlmcwS4F0QER4cznu1",
      "user_shell": "/usr/bin/fish"
    }
  }
}
```

#### Setup.firmware

- `setup`
    - `firmware` (*firmware[]*): The list of firmwares package to install (`[]`)

```json
{
  ...
  "vars": {
    "setup": {
      "firmware": ["firmware-realtek", "firmware-iwlwifi"]
    }
  }
}
```

#### Setup.desktop (UI)

- `setup`
    - `desktop_laptop` (*yes|no*): If the host is a `laptop`. By default (`"no"`)

```json
{
  ...
  "vars": {
    "setup": {
      "desktop_laptop": "no"
    }
  }
}
```
