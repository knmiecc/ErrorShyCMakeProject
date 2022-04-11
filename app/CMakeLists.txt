message(STATUS "included app/")

#############################################
# release app
#############################################
add_executable(release_build
    main.c
)

#target_compile_options(release_build PUBLIC
#    "-DMYTESTFORLINUX"
#)

target_link_libraries(release_build
    mylib
)

target_include_directories(release_build PUBLIC
   ./
   ../src/
)
