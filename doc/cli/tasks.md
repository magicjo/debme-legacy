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
    },
    "support_ui": "yes",
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

### System

Task to configure the system (`ntp`, `shell`, ...) on the host.

#### Configure System.tools

- `system`
    - `tools_ntp_servers` (*url[]*): The ntp servers to used. By default (*fr* ntp servers)

```json
{
  ...
  "vars": {
    "system": {
      "tools_ntp_servers": [
        "0.fr.pool.ntp.org",
        "1.fr.pool.ntp.org",
        "2.fr.pool.ntp.org",
        "3.fr.pool.ntp.org"
      ]
    }
  }
}
```

#### Configure System.shell

- `system`
    - `shell_aliases` (*alias[]*): The custom aliases to set. By default (`[]`)
    - `shell_locale` (*locale*): The locale to use. By default (`"en_US.UTF-8"`)

```json
{
  ...
  "vars": {
    "system": {
      "shell_aliases": [
        {
          "comment": "My super alias",
          "alias": "super",
          "command": "sudo -i"
        }
      ],
      "shell_locale": "en_US.UTF-8"
    }
  }
}
```

### Dev

Task to install development software (`python`, `nodejs`, ...) on the host.

#### Configure Dev.nodejs

- `dev`
    - `nodejs_version` (*version*): The global `nodejs` version. By default (`"6.x"`)
    - `nodejs_global_custom_modules` (*str[]*): The global modules to add. By default (`[]`)

```json
{
  ...
  "vars": {
    "dev": {
      "nodejs_version": "6.x",
      "nodejs_global_custom_modules": [
        "http-server",
        "liver-server"
      ]
    }
  }
}
```

### Gnome

Task to configure the `gnome` environment on the host.

#### Configure Gnome.extensions (UI)

- `gnome`
    - `extensions_enable` (*str*): The extensions to enable. By default
        - `launch-new-instance@gnome-shell-extensions.gcampax.github.com`
        - `window-list@gnome-shell-extensions.gcampax.github.com`
        - `places-menu@gnome-shell-extensions.gcampax.github.com`
        - `apps-menu@gnome-shell-extensions.gcampax.github.com`
        - `alternate-tab@gnome-shell-extensions.gcampax.github.com`
    - `extensions_configure` (*conf[]*): The extensions configuration (`gsettings set schema key value`). By default
        - *schema*: `"org.gnome.shell.extensions.window-list"`,
          *key*: `"grouping-mode"`,
          *value*: `"auto"`
        - *schema*: `"org.gnome.shell.extensions.window-list"`,
          *key*: `"show-on-all-monitors"`,
          *value*: `"false"`

```json
{
  ...
  "vars": {
    "gnome": {
      "extensions_enable":[
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com",
        "window-list@gnome-shell-extensions.gcampax.github.com",
        "places-menu@gnome-shell-extensions.gcampax.github.com",
        "apps-menu@gnome-shell-extensions.gcampax.github.com",
        "alternate-tab@gnome-shell-extensions.gcampax.github.com"
      ],
      "extensions_configure": [
        {
            "schema": "org.gnome.shell.extensions.window-list",
            "key": "grouping-mode",
            "value": "auto"
        },
        {
            "schema": "org.gnome.shell.extensions.window-list",
            "key": "show-on-all-monitors",
            "value": "false"
        }
      ]
    }
  }
}
```

#### Configure Gnome.shortcuts (UI)

- `gnome`
    - `shortcuts_wm` (*keybinding[]*): Configure `org.gnome.desktop.wm.keybindings`. By default (`[]`). You can see defined *key bindings* with
      `gsettings list-recursively org.gnome.desktop.wm.keybindings`.
        - *name*: The action name to bind, see `gsettings list-keys org.gnome.desktop.wm.keybindings`,
        - *key*: The key to bind, example `<Alt>F4`.
    - `shortcuts_mutter` (*keybinding[]*): Configure `org.gnome.mutter.keybindings`. By default (`[]`). You can see defined *key bindings* with
      `gsettings list-recursively org.gnome.mutter.keybindings`.
        - *name*: The action name to bind, see `gsettings list-keys org.gnome.mutter.keybindings`,
        - *key*: The key to bind, example `<Super>Right`.
    - `shortcuts_shell` (*keybinding[]*): Configure `org.gnome.shell.keybindings`. By default (`[]`). You can see defined *key bindings* with
      `gsettings list-recursively org.gnome.shell.keybindings`.
        - *name*: The action name to bind, see `gsettings list-keys org.gnome.shell.keybindings`,
        - *key*: The key to bind, example `<Super>s`.
    - `shortcuts_media_keys` (*keybinding[]*): Configure `org.gnome.settings-daemon.plugins.media-keys`. By default (`[]`). You can see defined *key bindings* with
      `gsettings list-recursively org.gnome.settings-daemon.plugins.media-keys`.
        - *name*: The action name to bind, see `gsettings list-keys org.gnome.settings-daemon.plugins.media-keys`,
        - *key*: The key to bind, example `<Control><Alt>Delete`.
    - `shortcuts_custom` (*keybinding[]*): Add custom *key bindings*. By default (`[]`). 
        - *name*: The key binding name, example `terminal`.
        - *key*: The key to bind, example `<Super>1`.
        - *command*: The command to execute, example `gnome-terminal`.

```json
{
  ...
  "vars": {
    "gnome": {
      "shortcuts_wm":[
        {"name": "close", "key": "<Alt>F4"}
      ],
      "shortcuts_mutter":[
        {"name": "toggle-tiled-right", "key": "<Super>Right"}
      ],
      "shortcuts_shell":[
        {"name": "toggle-overview", "key": "<Super>s"}
      ],
      "shortcuts_media_keys":[
        {"name": "logout", "key": "<Control><Alt>Delete"}
      ],
      "shortcuts_custom":[
        {"name": "terminal", "key": "<Super>1", "command": "gnome-terminal"},
        {"name": "monitor", "key": "<Super>2", "command": "gnome-system-monitor"}
      ]
    }
  }
}
```

#### Configure Gnome.style (UI)

- `gnome`
    - `style_configure` (*gnome-conf[]*): Configure `gnome schemas`.
        - The list of `schemas` to set:
            - *schema*: The schema to set, example `org.gnome.desktop.calendar`,
            - *key*: The key to set, example `show-weekdate`.
            - *value*: The new value, example `"true"`.
        - By default
            - schema: `org.gnome.desktop.calendar`, key: `show-weekdate`, value: `"true"`
            - schema: `org.gnome.desktop.peripherals.touchpad`, key: `tap-to-click`, value: `"true"`
            - schema: `org.gnome.desktop.background`, key: `show-desktop-icons`, value: `"true"`
    - `style_wallpapers` (*path*): Configure the output user wallpapers (on the host). By default `Images/Wallpapers`.
    - `style_avatar` (*path*): Configure the user avatar image. Set the path of your own local image. *Warning, must be an absolute path*.
    - `style_background` (*path*): Configure the user background image. Set the path of your own local *image. Warning, must be an absolute path*.
    - `style_screensaver` (*path*): Configure the user screen-saver image. Set the path of your own local image. *Warning, must be an absolute path*.

```json
{
  ...
  "vars": {
    "gnome": {
      "style_configure":[
        {"schema": "org.gnome.desktop.calendar", "key": "show-weekdate", "value": "'true'"},
        {"schema": "org.gnome.desktop.peripherals.touchpad", "key": "tap-to-click", "value": "'true'"},
        {"schema": "org.gnome.desktop.background", "key": "show-desktop-icons", "value": "'true'"}
      ],
      "style_wallpapers": "Images/Wallpapers",
      "style_avatar": "~/my_local.avatar.png",
      "style_background": "~/my_local.background.png",
      "style_screensaver": "~/my_local.screensaver.png"
    }
  }
}
```
