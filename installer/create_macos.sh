# bash
cmake -B build
cd build
cmake --build . --config Release
cpack -C Release -G DragNDrop
mv DaisyToolchain*.dmg ../
