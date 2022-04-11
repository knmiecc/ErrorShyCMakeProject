message(STATUS "included test/")

add_library(unity_lib STATIC 
    internals/unity/unity.c
    internals/unity/fake_runner.c
)
target_include_directories(unity_lib PUBLIC 
    internals/unity
)

target_compile_definitions(unity_lib PUBLIC 
    TEST
    GNU_COMPILER
    UNITY_NO_WEAK
)
set_property(TARGET unity_lib PROPERTY C_STANDARD 11)

################
# Test defs
################

add_executable(dummy_test_myexample 
    test_myexample.c
)

target_include_directories(dummy_test_myexample PUBLIC 
    ./
    ../src/
    ../build/test/mocks
)

target_link_directories(dummy_test_myexample PRIVATE 
    ./
    ../src/
    ../build/test/mocks
    internals/unity/
)

target_link_libraries(dummy_test_myexample
    unity_lib
)
