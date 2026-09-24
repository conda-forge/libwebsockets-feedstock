#!/bin/bash

set -euxo pipefail

# Pass openssl and libuv in as plain library names: libwebsockets bakes whatever
# it finds into the cmake config it exports, and absolute paths from the build
# environment are meaningless for consumers of the package.
#
# HTTP/3 (on by default since 5.0.0) forces the TLS backend over to GnuTLS,
# because that is the only backend lws can do QUIC with here.  Keep the
# openssl backend and leave HTTP/3 off.
cmake -GNinja -S . -B build ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DDISABLE_WERROR=ON \
      -DLWS_UNIX_SOCK=ON \
      -DLWS_WITH_HTTP3=OFF \
      -DLWS_ROLE_QUIC=OFF \
      -DLWS_WITH_STATIC=OFF \
      -DLWS_WITHOUT_TESTAPPS=ON \
      -DLWS_WITH_HTTP_PROXY=ON \
      -DLWS_WITH_ACCESS_LOG=ON \
      -DLWS_WITH_LIBUV=ON \
      -DLWS_OPENSSL_LIBRARIES:STRING="ssl;crypto" \
      -DLWS_OPENSSL_INCLUDE_DIRS="${PREFIX}/include" \
      -DLWS_LIBUV_LIBRARIES:STRING="uv" \
      -DLWS_LIBUV_INCLUDE_DIRS="${PREFIX}/include"

cmake --build build
cmake --install build
