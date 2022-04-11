message(STATUS "Using my_sdk")
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)
set(CMAKE_C_EXTENSIONS False)

include(CheckCXXCompilerFlag)
function(enable_cxx_compiler_flag_if_supported flag)
    string(FIND "${CMAKE_CXX_FLAGS}" "${flag}" flag_already_set)
    if(flag_already_set EQUAL -1)
        check_cxx_compiler_flag("${flag}" flag_supported)
        if(flag_supported)
            message(STATUS "Adding ${flag} globally")
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${flag}" PARENT_SCOPE)
        endif()
        unset(flag_supported CACHE)
    endif()
endfunction()

enable_cxx_compiler_flag_if_supported("-Wall")
enable_cxx_compiler_flag_if_supported("-Wextra")
enable_cxx_compiler_flag_if_supported("-pedantic")

set(AIX_COMPILE_FLAGS "-mcpu=power8" "-maix64")

if (${CMAKE_SYSTEM_NAME} STREQUAL Linux)
    message(STATUS "Running on Linux")    
    file(CREATE_LINK test/internals/project_linux.yml project.yml SYMBOLIC)
elseif(${CMAKE_SYSTEM_NAME} STREQUAL AIX)
    message(STATUS "Running on AIX")
    file(CREATE_LINK test/internals/project_aix.yml project.yml SYMBOLIC)
    add_compile_options("${AIX_COMPILE_FLAGS}")
    message(STATUS "Using global compile flags '${AIX_COMPILE_FLAGS}'")
    add_link_options("${AIX_COMPILE_FLAGS}")
    message(STATUS "Using global linker flags '${AIX_COMPILE_FLAGS}'")
    set(CMAKE_C_ARCHIVE_CREATE "<CMAKE_AR> -X64 rcs <TARGET> <LINK_FLAGS> <OBJECTS>")
else()
    message(WARNING "OS not recognised, falling back to unknown defaults")
endif()

set(CMAKE_SKIP_BUILD_RPATH True)

set(UNITY_SRC_PATH "unknown")
execute_process(COMMAND ./test/internals/gem_installation_path.sh 
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    OUTPUT_VARIABLE UNITY_SRC_PATH
)
message(STATUS "Unity src path: ${UNITY_SRC_PATH}")

if (NOT "${UNITY_SRC_PATH}" STREQUAL "unknown" AND NOT "${UNITY_SRC_PATH}" STREQUAL "")
    set(project_unity_path "${CMAKE_CURRENT_SOURCE_DIR}/test/internals/unity/")
    message(STATUS "Unity path found")
    file(MAKE_DIRECTORY test/internals/unity)
    file(CREATE_LINK "${UNITY_SRC_PATH}/unity.h" "${project_unity_path}/unity.h" SYMBOLIC)
    file(CREATE_LINK "${UNITY_SRC_PATH}/unity.c" "${project_unity_path}/unity.c" SYMBOLIC)
    file(CREATE_LINK "${UNITY_SRC_PATH}/unity_internals.h" "${project_unity_path}/unity_internals.h" SYMBOLIC)

    file(WRITE "${project_unity_path}/fake_runner.c"
        "/*=======Setup (stub)=====*/\n"
        "void setUp(void) {}\n"
        "/*=======Teardown (stub)=====*/\n"
        "void tearDown(void) {}\n"
        "int main(void){}\n"
    )
endif()
