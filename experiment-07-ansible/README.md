# Experiment 07: Configuration Management with Ansible

## Aim
Understand Ansible basics — inventory, playbooks, modules. Automate server configurations.

## Theory
Ansible is an agentless configuration management tool using SSH. Playbooks are written in YAML and are idempotent.

## Files
- `hosts.ini` — Inventory file
- `setup_webserver.yml` — Web server playbook
- `playbooks/01-install-java.yml` — Java installation
- `playbooks/02-install-maven.yml` — Maven installation
- `playbooks/03-install-gradle.yml` — Gradle installation
- `playbooks/main.yml` — Combined playbook
- `templates/app.service.j2` — Systemd service template

## Usage

### Test Connectivity
```bash
ansible all -i hosts.ini -m ping
```

### Syntax Check
```bash
ansible-playbook -i hosts.ini setup_webserver.yml --syntax-check
```

### Dry Run
```bash
ansible-playbook -i hosts.ini setup_webserver.yml --check
```

### Run Playbook
```bash
ansible-playbook -i hosts.ini setup_webserver.yml -v
```

### Install DevOps Tools
```bash
ansible-playbook -i hosts.ini playbooks/main.yml
```

## Ansible Concepts
- **Inventory**: List of hosts to manage
- **Playbook**: YAML file with tasks
- **Module**: Pre-built automation scripts
- **Task**: Single operation
- **Handler**: Task that runs on notify
