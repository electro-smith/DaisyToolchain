# bash
cmake -B build
cd build
cmake --build . --config Release
cpack -C Release -G NSIS
cp DaisyToolchain*.exe ../
