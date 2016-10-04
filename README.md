I don't use Ubuntu.  I do use Spotify.  This script lets me have a simple way
of building a working copy of spotify for my system.

Call it like this: ./fetch.sh

Default behaviour is to install spotify's jazz to `~/.spotify` and a symlink to
`~/bin/spotify` which will launch spotify.  The `INSTALL_LOCATION` environment
variable can specify a different location for the `~/.spotify` location.

I'd like to make this into an RPM package which does all this crud as a
postinstall script and offer it in a yum repository.  This means monitoring the
spotify repository as well as the debian repositories for the openssl package
updates and generate new rpms.  The RPM would only contain a script that
automates the download and never the actual spotify bits
