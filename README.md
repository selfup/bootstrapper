# Linux Go

Install go on linux!

Currently installs `go1.14.3`

### Use

```bash
curl https://raw.githubusercontent.com/selfup/linux_go/master/main.sh | bash
```

Or if you cloned this repo: `./main.sh`

### Steps and Warnings

:warning: Directories will be wiped :warning:

This is how you install new versions of go. Everything is automated :tada:

`$HOME/go` AND/OR `/usr/local/go` drectories will be blown away.

`sudo` will be required only if your go install is already in: `/usr/local/go`

go will be installed in your homedir as so: `$HOME/go`

`GOROOT` will be: `$HOME/go`

`GOPATH` will be: `$HOME/golang`

This install script if intended for non root users.

This will not be good production/cronjob/scheduled job machines that typically run as root.

This script installs go in your user home dir and does not require sudo.
