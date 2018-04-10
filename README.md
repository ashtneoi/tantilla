## how to use tantilla

### dependencies

These dependencies must be installed manually:
- Linux (or possibly another \*nix with bash and such)
- Python 3
- [pip](https://pip.pypa.io/en/stable/)
- [virtualenv](https://virtualenv.pypa.io/en/stable/), ideally through pip
  since your distro probably has an old version
- [mint](https://github.com/ashtneoi/mint)
- [shtoml](https://github.com/ashtneoi/shtoml)
- various other "standard" Linux utilities (you'll know if something's missing)

The rest of the dependencies are included in this repo or installed automatically.

### initial installation

1. Clone the repo or grab an archive and extract it.
2. Run `./install.sh` to create a Python virtualenv and install PyPI
   dependencies.
3. Copy `nginx.local.conf.dist` to `nginx.local.conf` and fill in the user who
   you want nginx to run as.
4. Add some apps.
5. Put your TLS keys and certs in `tls/`. If you need a self-signed cert for
   whatever reason, feel free to use `gen_self_cert.sh`.
   (`./gen_self_cert.sh tls/foo` will create `tls/foo.key` and `tls/foo.cert`.)

### installing an app

1. Put the app in a subdirectory, named how you want to refer to the app.
2. Create `nginx.servers.conf` if it doesn't exist, and add an nginx server
   declaration.  At the end of the server decl, put
   `include APPNAME/nginx.app.conf;`. Here's an example for an app named `hello`
   served from `example.com`:

```none
server {
  listen 443 ssl;
  listen [::]:443 ssl;
  ssl_certificate tls/example.com.cert;
  ssl_certificate_key tls/example.com.key;
  include hello/nginx.app.conf;
}
```

3. Create `APPNAME/config.toml` and set `server_name` and `mount_point`
   appropriately. `mount_point` must end with a slash.:

```toml
server_name = "example.com"
mount_point = "/"
```

### running an app

1. Run `./start.sh APPNAME` to regenerate APPNAME's nginx config and start the
   app itself.
2. Run `./nginx.sh` to start nginx, if you haven't already. 

Each time you modify an app, kill `start.sh` and run it again. If you modified
any nginx configs or `APPNAME/config.toml`, you also need to run `./nginx.sh -s
reload`.

## the name

*Tantilla* is a genus of small snakes. This project is small and uses Python.

Haha.
