#!/bin/bash

set -euxo pipefail

cmake -GNinja -S . -B build ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DDISABLE_WERROR=ON \
      -DLWS_UNIX_SOCK=ON \
      -DLWS_WITH_STATIC=OFF \
      -DLWS_WITHOUT_TESTAPPS=ON \
      -DLWS_WITH_HTTP_PROXY=ON \
      -DLWS_WITH_ACCESS_LOG=ON \
      -DLWS_WITH_LIBUV=ON

cmake --build build
cmake --install build
