#!/bin/sh
export PREFIX=`pwd`/../build/nghttp2
export TOOLCHAIN=/opt/ndk/android-ndk-r19c/toolchains/llvm/prebuilt/linux-x86_64
export PATH="$TOOLCHAIN"/bin:"$PATH"
export CC="$TOOLCHAIN"/bin/armv7a-linux-androideabi19-clang 
export CXX="$TOOLCHAIN"/bin/armv7a-linux-androideabi19-clang++ 
export CPPFLAGS="-fPIE -I$PREFIX/include" 
export PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig" 
export LDFLAGS="-fPIE -pie -L$PREFIX/lib"
export TOOL=arm-linux-androideabi
export LD=$TOOLCHAIN/bin/${TOOL}-ld
export AR=$TOOLCHAIN/bin/${TOOL}-ar
export RANLIB=$TOOLCHAIN/bin/${TOOL}-ranlib
export STRIP=$TOOLCHAIN/bin/${TOOL}-strip

echo "$PREFIX"
	
./configure \
    --enable-shared \
    --host=arm-linux-androideabi \
    --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` \
    --prefix="$PREFIX" \
    --without-libxml2 \
    --disable-python-bindings \
    --disable-examples \
    --disable-threads    

if [ $? -eq 0 ]; then
	make -j2 && make install
fi