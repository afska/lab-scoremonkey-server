#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

git clone git://git.aubio.org/git/aubio
cd aubio
./waf configure
./waf build
sudo ./waf install
echo "Aubio library has been installed!"
echo "Please add this to your .{shell}rc:"
echo "export AUBIO_PATH=$DIR/aubio/build/examples"
