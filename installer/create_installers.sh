# bash
rm -rf build/
cmake -B build
cd build
cmake --build . --config Release
cpack -C Release