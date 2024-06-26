mkdir build
cd build

cmake %CMAKE_ARGS% ^
      -GNinja ^
      -DLWS_UNIX_SOCK=ON ^
      -DLWS_WITH_STATIC=OFF ^
      -DLWS_WITHOUT_TESTAPPS=ON ^
      -DLWS_WITH_HTTP_PROXY=ON ^
      -DLWS_WITH_ACCESS_LOG=ON ^
      -DLWS_WITH_LIBUV=ON ^
      -DLWS_WITH_SERVER_STATUS=ON ^
      ..

ninja install