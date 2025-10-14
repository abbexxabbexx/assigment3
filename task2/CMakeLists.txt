cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project(task2 C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()
include_directories(${CMAKE_SOURCE_DIR})

add_executable(task2
  main.c
)

pico_enable_stdio_uart(task2 0)
pico_enable_stdio_usb(task2 1)

pico_add_extra_outputs(task2)

target_link_libraries(task2 pico_stdlib hardware_gpio)
