#!/usr/bin/env python

# IMPORT
import os
import json
import tempfile
import subprocess
import shutil


# CREATE HOSTS
def create_hosts(output_dir, hosts_path, available_host_names):
    with open(hosts_path) as data_file:
        hosts = json.load(data_file)
    hosts_names = filter(lambda name: name not in available_host_names, hosts.keys())
    if len(hosts_names) == 0:
        raise Exception('no host available after filtering')
    hosts_file = os.path.join(output_dir, 'hosts')
    file = open(hosts_file, 'w')
    groups = {}
    # Generate hosts
    for host_name, host in hosts.items():
        if host_name in hosts_names:
            # Header host
            file.write('[' + host_name + ']\n')
            # Connection host
            connection = host_name
            for connection_param_key, connection_param_value in host['connection'].items():
                connection += ' ' + connection_param_key + '=' + connection_param_value
            file.write(connection + '\n')
            # Separator
            file.write('\n')
            if 'vars' in host:
                # Header host vars
                file.write('[' + host_name + ':vars]\n')
                # Vars host
                for vars_key, vars_value in host['vars'].items():
                    file.write(vars_key + '=' + json.dumps(vars_value) + '\n')
            # Reference groups
            if 'types' in host:
                for type_name in host['types']:
                    if type_name not in groups:
                        groups[type_name] = [host_name]
                    else:
                        groups[type_name].append(host_name)
            # Separator
            file.write('\n')
    # Generate hosts group by types
    for type_name, hosts in groups.items():
        file.write('[' + type_name + ']\n')
        for host_name in hosts:
            file.write(host_name + '\n')
        # Separator
        file.write('\n')
    file.close()
    return hosts_file


# CREATE PLAYBOOK
def create_playbook(output_dir, playbooks, playbooks_path):
    playbook_file = os.path.join(output_dir, 'playbook.yml')
    file = open(playbook_file, 'w')
    for playbook in playbooks:
        file.write('- include: ' + os.path.join(playbooks_path, 'playbook-' + playbook + '.yml') + '\n')
    file.close()
    return playbook_file


# RUN PLAYBOOK
def run_playbook(hosts, playbook, verbose_count):
    verbose = ''
    for _ in range(verbose_count):
        verbose += ' --verbose'
    cmd = 'ansible-playbook ' + playbook + '  --inventory ' + hosts + verbose
    subprocess.call(cmd, shell=True)


# EXPORT
def ansible_run(playbooks, config):
    output_dir = tempfile.mkdtemp()
    try:
        hosts = create_hosts(output_dir, config['hosts_file'][0], config['host_name'])
        playbook = create_playbook(output_dir, playbooks, config['playbooks_path'])
        run_playbook(hosts, playbook, config['verbose'])
        shutil.rmtree(output_dir)
    except Exception as err:
        shutil.rmtree(output_dir)
        raise err
