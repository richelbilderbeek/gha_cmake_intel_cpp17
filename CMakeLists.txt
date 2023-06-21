cmake_minimum_required(VERSION 3.10)

project(gha_cmake_intel_cpp17)

# Intel things, all from https://devmesh.intel.com/posts/991253/adding-intel-oneapi-toolkits-to-github-actions
enable_language(CXX)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
list(APPEND CMAKE_MODULE_PATH "${IntelSYCL_DIR}")
find_package(IntelSYCL REQUIRED)
find_package(MKL REQUIRED)

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
  set(MKL_ROOT "/sw/comp/intel/oneapi/mkl/latest")

  #  -DTBB_ROOT="/sw/comp/intel/oneapi/tbb/latest"

else()
  message("Not working on a cluster." )
  set(MKL_ROOT "/opt/intel/oneapi/mkl/latest")


endif()

# Show compiler info
message("Compiler ID: ${CMAKE_CXX_COMPILER_ID}")
message("Compiler version: ${CMAKE_CXX_COMPILER_VERSION}")

add_executable(gha_cmake_intel_cpp17 main.cpp)






