@echo on

cmake -GNinja -S . -B build %CMAKE_ARGS% ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DLWS_UNIX_SOCK=ON ^
      -DLWS_WITH_STATIC=OFF ^
      -DLWS_WITHOUT_TESTAPPS=ON ^
      -DLWS_WITH_HTTP_PROXY=ON ^
      -DLWS_WITH_ACCESS_LOG=ON ^
      -DLWS_WITH_LIBUV=ON
if %ERRORLEVEL% neq 0 exit 1

cmake --build build
if %ERRORLEVEL% neq 0 exit 1

cmake --install build
if %ERRORLEVEL% neq 0 exit 1
