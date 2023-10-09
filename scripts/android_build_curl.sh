#!/bin/bash

#arm-linux-androideabi
#aarch64-linux-android
#i686-linux-android
#x86_64-linux-android

#armv7a-linux-androideabi
#aarch64-linux-android
#i686-linux-android
#x86_64-linux-android

#arm
#arm64
#x86
#x86_64

case $1 in
	arm)	  
	  echo "Building for arm"
	  export TOOL=arm-linux-androideabi
	  export TOOL2=armv7a-linux-androideabi
	  export ARCH=arm
	  ;;
	arm64)	  
      echo "Building for arm64"
	  export TOOL=aarch64-linux-android
	  export TOOL2=aarch64-linux-android
	  export ARCH=arm64
      ;;	  
    x86)	  
      echo "Building for x86"
	  export TOOL=i686-linux-android
	  export TOOL2=i686-linux-android
	  export ARCH=x86
      ;;	
    x86_64)	  
      echo "Building for x86_64"
	  export TOOL=x86_64-linux-android
	  export TOOL2=x86_64-linux-android
	  export ARCH=x86_64
      ;;	
	*)
	  echo "not supported arch"
	  ;;
esac

export TOOLCHAIN=/opt/ndk/android-ndk-r19c/toolchains/llvm/prebuilt/linux-x86_64
export CC="$TOOLCHAIN"/bin/${TOOL2}21-clang 
export CXX="$TOOLCHAIN"/bin/${TOOL2}21-clang++ 

export LD=$TOOLCHAIN/bin/${TOOL}-ld
export AR=$TOOLCHAIN/bin/${TOOL}-ar
export RANLIB=$TOOLCHAIN/bin/${TOOL}-ranlib
export STRIP=$TOOLCHAIN/bin/${TOOL}-strip
export PATH="$TOOLCHAIN"/bin:"$PATH"
export ARCH_FLAGS="-mthumb"
export CFLAGS="${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector-all -fno-strict-aliasing -finline-limit=64"
export CXXFLAGS="${CFLAGS} -frtti -fexceptions"

./configure --prefix=`pwd`/../build/${ARCH}/libcurl/ \
       --with-sysroot=$TOOLCHAIN/sysroot \
       --host=arm-linux-androideabi \
       --with-ssl=`pwd`/../build/${ARCH}/openssl/ \
       --with-nghttp2=`pwd`/../build/${ARCH}/nghttp2/ \
       --enable-ipv6 \
       --enable-static \
       --enable-threaded-resolver \
       --disable-dict \
       --disable-gopher \
       --disable-ldap --disable-ldaps \
       --disable-manual \
       --disable-pop3 --disable-smtp --disable-imap \
       --disable-rtsp \
       --disable-shared \
       --disable-smb \
       --disable-telnet \
       --disable-verbose
	   
if [ $? -eq 0 ]; then
	make -j16 && make install
fi