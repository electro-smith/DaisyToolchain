version=0.1.2
name=DaisyToolchain

./build-macos-x64.sh $name $version

mkdir -p bin
cp target/pkg/$name-macos-installer-x64-$version.pkg bin
echo "Generated $name-macos-installer-x64-$version.pkg in bin folder"