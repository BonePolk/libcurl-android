#!/bin/sh

#arm-linux-androideabi
#aarch64-linux-android
#i686-linux-android
#x86_64-linux-android

#armv7a-linux-androideabi21
#aarch64-linux-android21
#i686-linux-android21
#x86_64-linux-android21

#arm
#arm64
#x86
#x86_64

export TOOL=x86_64-linux-android
export TOOL2=x86_64-linux-android
export ARCH=x86_64

export PWD=`pwd`
export PREFIX=$PWD/../build/${ARCH}/nghttp2
export TOOLCHAIN=/opt/ndk/android-ndk-r19c/toolchains/llvm/prebuilt/linux-x86_64
export PATH="$TOOLCHAIN"/bin:"$PATH"
export CC="$TOOLCHAIN"/bin/${TOOL2}21-clang 
export CXX="$TOOLCHAIN"/bin/${TOOL2}21-clang++ 
export CPPFLAGS="-fPIE -I$PREFIX/include" 
export PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig" 
export LDFLAGS="-fPIE -pie -L$PREFIX/lib"
export LD=$TOOLCHAIN/bin/${TOOL}-ld
export AR=$TOOLCHAIN/bin/${TOOL}-ar
export RANLIB=$TOOLCHAIN/bin/${TOOL}-ranlib
export STRIP=$TOOLCHAIN/bin/${TOOL}-strip

echo "$PREFIX"
echo "$CC"
	
./configure \
    --enable-shared \
    --host=${TOOL} \
    --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` \
    --prefix="$PREFIX" \
    --without-libxml2 \
    --disable-python-bindings \
    --disable-examples \
    --disable-threads    

if [ $? -eq 0 ]; then
	make -j16 && make install
fi