@echo on

:: Pass openssl and libuv in as plain library names: libwebsockets bakes whatever
:: it finds into the cmake config it exports, and absolute paths from the build
:: environment (openssl in the build prefix, the Windows SDK import libraries that
:: FindOpenSSL resolves) are meaningless for consumers of the package.
cmake -GNinja -S . -B build %CMAKE_ARGS% ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DLWS_UNIX_SOCK=ON ^
      -DLWS_WITH_STATIC=OFF ^
      -DLWS_WITHOUT_TESTAPPS=ON ^
      -DLWS_WITH_HTTP_PROXY=ON ^
      -DLWS_WITH_ACCESS_LOG=ON ^
      -DLWS_WITH_LIBUV=ON ^
      -DLWS_OPENSSL_LIBRARIES:STRING="libssl;libcrypto" ^
      -DLWS_OPENSSL_INCLUDE_DIRS=%LIBRARY_INC% ^
      -DLWS_LIBUV_LIBRARIES:STRING="uv" ^
      -DLWS_LIBUV_INCLUDE_DIRS=%LIBRARY_INC%
if %ERRORLEVEL% neq 0 exit 1

cmake --build build
if %ERRORLEVEL% neq 0 exit 1

cmake --install build
if %ERRORLEVEL% neq 0 exit 1
