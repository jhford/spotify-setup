#!/bin/bash
# Download and install Spotify for Linux on something other than Ubuntu or
# Debian.  This script will one day be called by an RPM Specfile

installLocation="${INSTALL_LOCATION:-$HOME/.spotify}"

spotifyPkg="spotify-client_1.0.38.171.g5e1cd7b2-22_amd64.deb"
spotifyPkgUrl="http://repository-origin.spotify.com/pool/non-free/s/spotify-client/$spotifyPkg"

libsslPkg="libssl1.0.0_1.0.1t-1+deb8u5_amd64.deb"
libsslPkgUrl="http://security.debian.org/debian-security/pool/updates/main/o/openssl/$libsslPkg"

if [ ! -f $spotifyPkg ] ; then
  curl -L -o $spotifyPkg $spotifyPkgUrl
fi

if [ ! -f $libsslPkg ] ; then
  curl -L -o $libsslPkg $libsslPkgUrl
fi

rm -rf spotify-client-raw && mkdir spotify-client-raw
( cd spotify-client-raw && ar x ../$spotifyPkg && tar axf data.tar.* )

rm -rf libssl-raw && mkdir libssl-raw
( cd libssl-raw && ar x ../$libsslPkg && tar axf data.tar.* )

rm -rf $installLocation && mkdir $installLocation
cp -r spotify-client-raw/usr/share/spotify/* $installLocation
cp libssl-raw/usr/lib/x86_64-linux-gnu/libssl.so.1.0.0 $installLocation
cp libssl-raw/usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 $installLocation
if [ ! -d ~/bin ] ; then 
  mkdir ~/bin
fi
ln -s $installLocation/spotify ~/bin/
