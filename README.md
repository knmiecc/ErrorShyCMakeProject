# my_example_proj

A small CMake based C project that exists as reference to this Stackoverflow question about why my VSCode does refuse to show me error squiggles on symbols that dare definitely not existing yet.
Feel free to see it as a reference for a Unit Testing enabled C project that should be compilable on different platforms if configured correctly.

To have this project work you need to install the following files:
- cmake 3.16 or greater
- ruby 2.7 or greater
- ceedling 0.31.1, installed per user via gem install --user-install ceedling <-- important to install it locally
- gcc version 8.3 or greater
- optionally gcov and gcovr, gcov through local package manager, gcovr through pip3 install gcovr.
- add to your environment .bashrc if necessary: ``export PATH:"$PATH":"${HOME}".gem/ruby/2.7.0/bin``

