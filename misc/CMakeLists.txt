cmake_minimum_required(VERSION 3.10)





#set(-DCMAKE_TOOLCHAIN_FILE=/path_to_vcpkg/vcpkg/scripts/buildsystems/vcpkg.cmake)
#-DCMAKE_TOOLCHAIN_FILE:FILEPATH=/path_to_vcpkg/vcpkg/scripts/buildsystems/vcpkg.cmake)
#set the place for where the links to the external libraries will be stored
#set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/modules)

# Compiler
if(DEFINED ENV{CLUSTER})
  message("Working on cluster")
  # We need to set the compiler on a cluster ourselves,
  # from https://stackoverflow.com/a/45934279
  # (see also there for other (and more recommended) ways)
  set(CMAKE_C_COMPILER "/sw/comp/gcc/13.1.0_rackham/bin/gcc")
  set(CMAKE_CXX_COMPILER "/sw/comp/gcc/13.1.0_rackham/bin/g++")
else()
  message("Working on local computer or GitHub Actions")
endif()

# set the project name
project(Simulation_Machine)
message("Compiler id: ${CMAKE_CXX_COMPILER_ID}")
message("Compiler Version: ${CMAKE_CXX_COMPILER_VERSION}")
if (CMAKE_CXX_COMPILER_VERSION VERSION_LESS 8.5)
    message(FATAL_ERROR "GCC version must be at least 8.5, to support C++20")
endif()

# specify the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

#alternative ${CMAKE_SYSTEM_NAME} MATCHES "Darwin"


if(UNIX AND NOT APPLE)
    set(LINUX TRUE)
    message("found using linux platform, using corresponding flags")
    set(CMAKE_CXX_FLAGS "-O3 -pthread -march=broadwell -mfma -mavx2")
    #set(CMAKE_CXX_FLAGS "-march=broadwell")
endif()

IF(APPLE)
      message("found using apple platform, using corresponding flags")
      set(CMAKE_CXX_FLAGS "-O3")
      #set(CMAKE_OSX_DEPLOYMENT_TARGET "12.2")
endif()

if(WIN32)
      message("found out that we have windows, using corresponding flags")
      set(CMAKE_CXX_FLAGS "/EHsc /O2") #for maximum speed, optimization flag
      set(CMAKE_BUILD_TYPE "RELEASE") #doesn't work, but leave it here
      message("for release version, use <cmake --build . --config Release>  command in command line")
      set(CMAKE_PREFIX_PATH "C:/dev/vcpkg/vcpkg/packages/zlib_x64-windows-static")
endif()

#if your zlib library cannot be found, use below to link to directory

# set(CMAKE_PREFIX_PATH "path to directory") e.g. on windows: "C:f/dev/vcpkg/vcpkg/packages/zlib_x64-windows-static"

#attempt to print out all flags




# add the executable
#testexectuables
#add_executable(Simulation_Machine Tests/Test1_basic_functioning_testing.cpp)
#add_executable(Simulation_Machine Tests/Test2_dipoleForce.cpp)
#add_executable(Simulation_Machine Tests/Test3_correct_orient_to_rotation.cpp)
#add_executable(Simulation_Machine Tests/Test4Correct_force_to_displacement.cpp)
#add_executable(Simulation_Machine Tests/Test5_correct_force_to_orientation.cpp)
#add_executable(Simulation_Machine Tests/Test6_hantel_dynamik.cpp)
#add_executable(Simulation_Machine Tests/Test7_Speedcomparison.cpp)
#add_executable(Simulation_Machine Tests/Test8_steric_repulsion.cpp)

#analysisexecutables

add_executable(Simulation_Machine z_Analysis_main_files/Chain_Length_analysis.cpp)
# add_executable(Simulation_Machine z_Analysis_main_files/wrong_binding_test.cpp)
#add_executable(Simulation_Machine z_Analysis_main_files/Processive_movement.cpp)
#add_executable(Simulation_Machine z_Analysis_main_files/Full_motor_movement.cpp)

#Detachmentanalysis main files
#add_executable(Simulation_Machine z_Analysis_main_files/Detachment_analysis/Detachment_analysis.cpp)
#add_executable(Simulation_Machine z_Analysis_main_files/Detachment_analysis/Detachment_analysis_simpleMotor.cpp)


#print out flags
# if(APPLE)
#   target_compile_options(Simulation_Machine PUBLIC -O3)
# endif()
# if(UNIX AND NOT APPLE)
#   target_compile_options(Simulation_Machine PUBLIC -O3 -pthread -march=broadwell -mfma -mavx2)
# endif()


get_target_property(MAIN_CFLAGS Simulation_Machine COMPILE_OPTIONS)
# also see: COMPILE_DEFINITIONS INCLUDE_DIRECTORIES
message("-- Target compiler flags are: ${MAIN_CFLAGS}")


# add the libraries
add_subdirectory(src)

# add external includes
find_package(ZLIB REQUIRED)
    target_link_libraries(Simulation_Machine PUBLIC ZLIB::ZLIB)

#target_include_directories(Simulation_Machine  PUBLIC "/path_to_vcpkg/vcpkg/packages/matplotlib-cpp_x64-osx/include/")
#target_include_directories(Simulation_Machine  PUBLIC "/path_to_pyenv/.pyenv/versions/3.10-dev/lib/python3.10/site-packages/")
#target_include_directories(Simulation_Machine  PUBLIC "/path_to_vcpkg/vcpkg/packages/zlib_x64-osx/include/")
#target_include_directories(Simulation_Machine  PUBLIC "/path_to_pyenv/.pyenv/versions/3.10-dev/lib/python3.10/site-packages/numpy/core/include/")
#target_include_directories(Simulation_Machine  PUBLIC "/path_to_pyenv/.pyenv/versions/3.10-dev/include/python3.10/")

# add all internal libraries
target_link_libraries(Simulation_Machine PRIVATE Rigid_body
                                                Vector_calculus
                                                Force_collectors
                                                Simulation_functions
                                                Diffusion_parameter_factory
                                                Rigid_body_factory
                                                Displacement_appliers
                                                cnpy
                                                Time_measurer
                                                Data_storage
                                                Data_transfer
                                                Data_transform
                                                Force_applicators
                                                Force_factories
                                                Track
                                                Binding_interaction
                                                Force_applicators_binding
                                                Binding_site
                                                System_container
                                                Stop_conditions
                                                Data_saver_npz
                                                Binding_strength_state
                                                Chemical_cycle
                                                Double_binding_rate_change
                                                Data_capture
                                                Project_data_fileSystem)

## external binary injection
# file(GLOB SOURCES "src/*.cpp")
# add_executable(Simulation_Machine ${SOURCES})


# external libraries injection
#file(GLOB LIBRARIES
#        "/usr/local/lib/libintl.dylib"  #mac library
#        "/Users/user/.pyenv/versions/3.10-dev/lib/libpython3.10.a"
  #       "/Users/user/Documents/Programs/vcpkg/packages/zlib_x64-osx/lib/libz.a"
#        )
#message("LIBRARIES = ${LIBRARIES}")


# target_link_libraries(Simulation_Machine PUBLIC ${LIBRARIES})



#target_include_directories(Simulation_Machine PUBLIC
#                           "${PROJECT_BINARY_DIR}"
#                           "${PROJECT_SOURCE_DIR}/MathFunctions"
#                           )


#find_package(OpenMP)
#if(OpenMP_CXX_FOUND)
#    target_link_libraries(Simulation_Machine PUBLIC OpenMP::OpenMP_CXX)
#endif()
