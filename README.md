# Proxmox Orchestrator

An Ansible-driven toolkit to manage and automate homelab Proxmox environment.

## Setup

### Install Python Environment

```sh
$ python3 -m venv .env
$ .env/bin/activate
$ pip install -r requirements.txt
```

### Install Ansible modules

```sh
$ ansible-galaxy collection install -r requirements.yml --force
```

## Run playbooks

```sh
$ ansible-playbook playbooks/site.yml
```

## Utils

### Encrypt/Decrypt files

```sh
$ ansible-vault encrypt --encrypt-vault-id dummy inventory/hosts.vault.yml
$ ansible-vault decrypt inventory/hosts.yml
```

During development, you can use these commands

```sh
find inventory -type f -name "*.vault.yml" -exec ansible-vault encrypt --encrypt-vault-id dummy {} \;
find inventory -type f -name "*.vault.yml" -exec ansible-vault decrypt {} \;
```

## License

Licensed under [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0), (see
[`LICENSE`](./LICENSE)).
