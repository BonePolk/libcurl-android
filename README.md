# CUrl & OpenSSL & NgHttp2 for android
You can download prebuilded libs from [releases](https://github.com/BonePolk/libcurl-android/releases/tag/pre_cho)

# How to build
1.open GoogleColab.ipynb in https://colab.research.google.com

2.that start building

3.you will get directory "build" with directories with compiled libraries

4.after you can start zipping

5.you will get directory zip with prebuilded-libcurl.zip and other files of compiled libs

# How add to your android project
1.download zip archive with libs

2.copy files to the cpp files folder

3.rename 

```
  arm -> armeabi-v7a
  arm64 -> arm64-v8a
```

## Android.mk

I don't tested this

```
include $(CLEAR_VARS)

LOCAL_MODULE := curl
LOCAL_SRC_FILES := Your cURL Library Path/$(TARGET_ARCH_ABI)/libcurl.a
include $(PREBUILT_STATIC_LIBRARY)

LOCAL_MODULE := crypto
LOCAL_SRC_FILES := Your OpenSSL Library Path/$(TARGET_ARCH_ABI)/libcrypto.a
include $(PREBUILT_STATIC_LIBRARY)

LOCAL_MODULE := crypto
LOCAL_SRC_FILES := Your OpenSSL Library Path/$(TARGET_ARCH_ABI)/libssl.a
include $(PREBUILT_STATIC_LIBRARY)

LOCAL_MODULE := nghttp2
LOCAL_SRC_FILES := Your ngHttp2 Library Path/$(TARGET_ARCH_ABI)/libnghttp2.a
include $(PREBUILT_STATIC_LIBRARY)


LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/Your Openssl Include Path/openssl \
	$(LOCAL_PATH)/Your cURL Include Path/curl

LOCAL_STATIC_LIBRARIES := libcurl libcrypto libssl libnghttp2

LOCAL_LDLIBS := -lz
```

## CMake
Define ssl, crypto, curl as STATIC IMPORTED libraries.

```
add_library(local_crypto STATIC IMPORTED)
add_library(local_openssl STATIC IMPORTED)
add_library(local_nghttp2 STATIC IMPORTED)
add_library(local_curl STATIC IMPORTED)

set_target_properties(local_crypto PROPERTIES IMPORTED_LOCATION  ${CMAKE_SOURCE_DIR}/libs/${ANDROID_ABI}/libcrypto.a)
set_target_properties(local_openssl PROPERTIES IMPORTED_LOCATION  ${CMAKE_SOURCE_DIR}/libs/${ANDROID_ABI}/libssl.a)
set_target_properties(local_nghttp2 PROPERTIES IMPORTED_LOCATION  ${CMAKE_SOURCE_DIR}/libs/${ANDROID_ABI}/libnghttp2.a)
set_target_properties(local_curl PROPERTIES IMPORTED_LOCATION  ${CMAKE_SOURCE_DIR}/libs/${ANDROID_ABI}/libcurl.a)


```

Then link these libraries with your target, e.g.

```
target_link_libraries( # Specifies the target library.
                       native-lib

                       log
                       z
                       local_curl
                       local_nghttp2
                       local_openssl
                       local_crypto
)
