#!/bin/sh

user_gem_dir=$(gem env | grep "  - USER INSTALLATION DIRECTORY: " | cut -d":" -f 2 | cut -b 2-)
ceedling_version=$( ceedling version | grep "Ceedling::" | cut -d":" -f 3 | cut -b 2- )
unity_srcs_path="${user_gem_dir}/gems/ceedling-${ceedling_version}/vendor/unity/src"
printf "%s\n" "${unity_srcs_path}"
# TODO: Add some checks if any of this worked