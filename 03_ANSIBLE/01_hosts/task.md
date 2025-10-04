### Genereate SSH keys

```sh
ssh-keygen
```

### Copy SSH keys to a remote machine

```sh
ssh-copy-id USER@IP
```

### Create a sample hosts dictionary basing on the hosts.example 
Remember about the path of the hosts file `/etc/ansible/hosts`

### Run ping command

```
ansible all -m ping
```

### Let's do some magic...

```
ansible [pattern] -m [module] -a "[module options]"
```

https://docs.ansible.com/ansible/latest/collections/index.html#list-of-collections
