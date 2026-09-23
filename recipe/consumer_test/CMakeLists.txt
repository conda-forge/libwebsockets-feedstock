cmake_minimum_required(VERSION 3.20)

project(lws_consumer C)

find_package(libwebsockets CONFIG REQUIRED)

add_executable(lws_version lws_version.c)
target_link_libraries(lws_version PRIVATE websockets_shared)
