# docker-nginx

nginx docker

> **Note** : this is a not yet generalized version and requires token replacement ( ie. example.com, my.local, ip addresses ) so inspect carefully all files before execution

## prerequisites

- [linux-scripts-utils](https://github.com/devel0/linux-scripts-utils)
- [letsencrypt](https://letsencrypt.org)
- `/scripts/constanta` with `ip_nginx_srv` nginx docker server address

## install

```
./build.sh
./run.sh
```
