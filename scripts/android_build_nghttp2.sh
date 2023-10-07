#!/bin/sh
export TOOL=arm-linux-androideabi
export TOOL2=armv7a-linux-androideabi
export ARCH=arm

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