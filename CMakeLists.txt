cmake_minimum_required(VERSION 3.10)

project(gha_cmake_intel_cpp17)

# C++17
set(CMAKE_CXX_STANDARD 17)

# Cluster things
if(DEFINED ENV{CLUSTER})
  message("Working on cluster")
  # We need to set the compiler on a cluster ourselves,
  # from https://stackoverflow.com/a/45934279
  # (see also there for other (and more recommended) ways)
  set(CMAKE_C_COMPILER "/sw/comp/intel/oneapi/compiler/2023.1.0/linux/bin/icx")
  set(CMAKE_CXX_COMPILER "/sw/comp/intel/oneapi/compiler/2023.1.0/linux/bin/icpx")
else()
  message("Not working on a cluster." )
  set(CMAKE_C_COMPILER "/opt/intel/oneapi/compiler/2023.1.0/linux/bin/icx")
  set(CMAKE_CXX_COMPILER "/opt/intel/oneapi/compiler/2023.1.0/linux/bin/icpx")
endif()

# Show compiler info
message("Compiler ID: ${CMAKE_CXX_COMPILER_ID}")
message("Compiler version: ${CMAKE_CXX_COMPILER_VERSION}")

add_executable(gha_cmake_intel_cpp17 main.cpp)
