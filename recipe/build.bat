@echo on

:: Pass openssl and libuv in as plain library names: libwebsockets bakes whatever
:: it finds into the cmake config it exports, and absolute paths from the build
:: environment (openssl in the build prefix, the Windows SDK import libraries that
:: FindOpenSSL resolves) are meaningless for consumers of the package.
::
:: HTTP/3 (on by default since 5.0.0) forces the TLS backend over to GnuTLS, and
:: with HTTP/3 off lws would default to SChannel on Windows.  Keep the openssl
:: backend the package has always been built against.
cmake -GNinja -S . -B build %CMAKE_ARGS% ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DDISABLE_WERROR=ON ^
      -DLWS_UNIX_SOCK=ON ^
      -DLWS_WITH_HTTP3=OFF ^
      -DLWS_ROLE_QUIC=OFF ^
      -DLWS_WITH_SCHANNEL=OFF ^
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
