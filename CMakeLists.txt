cmake_minimum_required(VERSION 3.10)

project(gha_cmake_intel_cpp17)

# Intel things, all from https://devmesh.intel.com/posts/991253/adding-intel-oneapi-toolkits-to-github-actions
enable_language(CXX)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
list(APPEND CMAKE_MODULE_PATH "${IntelSYCL_DIR}")
find_package(IntelSYCL REQUIRED)
find_package(MKL REQUIRED)
set(MKL_ROOT /opt/intel/oneapi/mkl/latest)

# C++17
set(CMAKE_CXX_STANDARD 17)

# Show compiler info
message("Compiler ID: ${CMAKE_CXX_COMPILER_ID}")
message("Compiler version: ${CMAKE_CXX_COMPILER_VERSION}")

add_executable(gha_cmake_intel_cpp17 main.cpp)






