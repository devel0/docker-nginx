# docker-nginx

nginx docker

## prerequisites

- [linux-scripts-utils](https://github.com/devel0/linux-scripts-utils)
- [letsencrypt](https://letsencrypt.org)
- `/scripts/constanta` with `ip_nginx_srv` nginx docker server address

## configure

| file | token | replace with |
|---|---|---|
| [entrypoint.sh](entrypoint.sh) | `172.18.0.2` | ip address of dns docker |
| | `example.com` | domain name |
| [run.sh](run.sh) | `example.com` | see above |

## install

```
./build.sh
./run.sh
```
