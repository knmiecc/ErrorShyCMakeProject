cmake_minimum_required(VERSION 3.16)
# set the project name
project(my_example_proj VERSION 0.1)

# This line needs to be included AFTER the project is defined
include(my_sdk_import.cmake)

###################################
# If you need to debug compile issues, uncomment the two lines below 
# to have make print (MUCH) more verbose output.
###################################
# set(CMAKE_VERBOSE_MAKEFILE on)
# set(CMAKE_RULE_MESSAGES off)

add_subdirectory(app)
add_subdirectory(src)
add_subdirectory(test)
#add_subdirectory(release)
