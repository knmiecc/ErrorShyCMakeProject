message(STATUS "included src/")

####################
# Lib definition
####################

##The static lib itself
add_library(mylib STATIC
    mylib.c
)

## What "static" libs to target against
# target_link_libraries(mylib
# ## something
# )

## The include folders to find other headers important for this one
target_include_directories(mylib PRIVATE 
    ./
)
