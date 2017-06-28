# Tasks cli

Command used to execute tasks on the remote environment for `debme`.
You must run `'setup'` command once before install other tasks.

## Example

```bash
dembe tasks --envs hosts.json --hosts "serverX" "serverY" -vvvv
dembe tasks --envs hosts.json --names "task1" "task2" --hosts "serverX" "serverY" -vvvv
```

## Usage

```bash
debme tasks --help
usage: debme tasks [-h] [--list] [--names TASKS_NAME [TASKS_NAME ...]]
                   [--envs HOSTS_FILE] [--verbose]
                   [--hosts HOST_NAME [HOST_NAME ...]]

optional arguments:
  -h, --help            show this help message and exit
  --list, -l            list the defined tasks
  --names TASKS_NAME [TASKS_NAME ...], -T TASKS_NAME [TASKS_NAME ...]
                        filtering defined tasks by name for execution
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
        "task1": {
            ...
        },
        ...
    }
  }
}

```

## Available tasks

### system

Task to configure the system (`ntp`, `shell`, ...) on the host.