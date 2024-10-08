## Create own Playbook

Basing on the file `playbook.yaml` create your own playbook that will
1. install nginx
2. delete the standard html file `/var/www/html/index.nginx-debian.html`
3. copy website files into `/var/www/html`
4. before executing consider validating your playbook with `ansible-lint` (you will probably need to install the proper package)

```
ansible-lint playbook.yaml
```

to run playbook.yaml
```
ansible-playbook playbook.yaml
```

Find the propper modules from here https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html#plugins-in-ansible-builtin
