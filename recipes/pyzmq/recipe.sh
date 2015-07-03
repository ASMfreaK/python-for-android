#!/bin/bash

# version of your package
VERSION_pyzmq=${VERSION_pyzmq:-14.7.0}

# dependencies of this recipe
DEPS_pyzmq=(python setuptools)

# url of the package
URL_pyzmq=https://pypi.python.org/packages/source/p/pyzmq/pyzmq-$VERSION_pyzmq.tar.gz

# md5 of the package
MD5_pyzmq=87e3abb33af5794db5ae85c667bbf324

# default build path
BUILD_pyzmq=$BUILD_PATH/pyzmq/$(get_directory $URL_pyzmq)

# default recipe path
RECIPE_pyzmq=$RECIPES_PATH/pyzmq

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_pyzmq() {
	true
}

# function called to build the source code
function build_pyzmq() {
	cd $BUILD_bidi
	push_arm
	export LDSHARED="$LIBLINK"

	try find . -iname '*.pyx' -exec $CYTHON {} \;
	try $HOSTPYTHON setup.py build_ext -v

	export PYTHONPATH=$BUILD_hostpython/Lib/site-packages
	try $BUILD_hostpython/hostpython setup.py install -O2 --root=$BUILD_PATH/python-install --install-lib=lib/python2.7/site-packages

	unset LDSHARED
	pop_arm
}

# function called after all the compile have been done
function postbuild_pyzmq() {
	true
}
