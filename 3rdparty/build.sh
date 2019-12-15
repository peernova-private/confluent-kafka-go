#!/bin/bash

# Ubuntu specific dependencies
if [ -f /etc/os-release ]; then
  eval "$(grep '^ID=' /etc/os-release)"
  if [ "${ID}" == "ubuntu" ]; then
    sudo apt-get install zlib1g-dev libncurses5-dev libreadline-dev
  fi
fi

dir=$(dirname $0)
cd ${dir}

osname=$(echo ${OSTYPE:0:6} | cut -d '-' -f 1)
rm -rf lib/${osname}_amd64
mkdir -p lib/${osname}_amd64

rm -rf build/*
mkdir -p build
cd build

files=(
  'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2o.tar.gz' \
  'ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz' \
  'https://github.com/lz4/lz4/archive/v1.8.2.tar.gz' \
  'https://github.com/edenhill/librdkafka/archive/v0.11.4.tar.gz' \
)

targets=(
  'openssl' \
  'sasl' \
  'lz4' \
  'librdkafka' \
)

if [ "${osname}" == "linux" ]; then
  platform="linux-x86_64"
else
  platform="darwin64-x86_64-cc"
fi

compilation=(
  "./Configure ${platform} no-shared no-dso no-krb5 no-asm --prefix=`pwd`/install --openssldir=ssl && perl -pi -e \"s/^CFLAG=/CFLAG= -fPIC/\" Makefile && make install && cp ../install/lib/libcrypto.a ../install/lib/libssl.a ../../lib/${osname}_amd64 && cp -r ../install/include/openssl/* ../../include/openssl" \
  "CFLAGS=-fPIC ./configure --enable-static --enable-gssapi=no --with-openssl=`pwd`/install --with-dblib=none ; make ; cp lib/.libs/libsasl2.a plugins/.libs/*.a ../../lib/${osname}_amd64 && cp include/{hmac-md5.h,prop.h,saslplug.h,saslutil.h,sasl.h,md5.h,md5global.h} ../../include/sasl" \
  "CFLAGS=-fPIC make && cp lib/liblz4.a ../../lib/${osname}_amd64 && cp lib/*.h ../../include/lz4" \
  "CFLAGS=-fPIC ./configure --enable-devel --enable-static && make && cp src/librdkafka.a src-cpp/librdkafka++.a ../../lib/${osname}_amd64 && cp src/rdkafka.h src-cpp/rdkafkacpp.h ../../include/librdkafka" \
)

count=0
for file in ${files[*]}; do
  wget ${file} -q -O source.tgz
  if [ $? -ne 0 ]; then
    echo "An error occurred while downloading the file ${file}"
    exit 1
  fi
  target=${targets[${count}]}
  mkdir -p ${target}
  tar -xzf source.tgz -C ${target} --strip-components=1
  if [ $? -ne 0 ]; then
    echo "An error occurred while unpacking the file ${file}"
    exit 1
  fi
  mkdir -p ../include/${target}
  cd ${target}
  command=${compilation[${count}]}
  eval "bash -c '${command}'"
  if [ $? -ne 0 ]; then
    echo "An error occurred while compiling ${target}"
    exit 1
  fi
  cd -
  count=$((count+1))
done

rm source.tgz
cd ..
rm -rf build

exit 0

