cmake_minimum_required(VERSION 3.28)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(stopwatch)

# Включаем Conan Toolchain
include(${CMAKE_BINARY_DIR}/Release/generators/conan_toolchain.cmake)

# Ищем библиотеку Poco
find_package(Poco REQUIRED)

# Создаем исполняемый файл
add_executable(timer src/main.cpp)

# Линкуем библиотеку Poco
target_link_libraries(timer Poco::Foundation)