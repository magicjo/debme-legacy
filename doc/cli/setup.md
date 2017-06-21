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
                "vars": {
                    "type": "object"
                    // Variables used by the tasks
                }
            },
            "required": ["connection"]
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
    }
  },
  "my-server": {
    "connection": {
        "ansible_connection": "ssh",
        "ansible_host": "10.10.10.10",
        "ansible_user": "root",
        "ansible_ssh_pass": "123456789"
    },
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
