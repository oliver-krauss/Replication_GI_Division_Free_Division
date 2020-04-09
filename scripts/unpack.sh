# ensure we are in the correct diretory
cd "$(dirname "$0")"

# create the execution directory
rm -rf ../execution
mkdir ../execution

# unzip gi_cbrt to the execution directory
gunzip -c ../gi_cbrt.tar.gz | tar xvf -
mv ./gi_cbrt ../execution

# unzip glibc to execution dir
gunzip -c ../dependencies/glibc-2.29.tar.gz | tar xvf -
mv ./glibc-2.29 ../execution

# move build bat to correct directory as csh does not understand working directories
cp ./build.bat ../execution/gi_cbrt/cbrt/
cd ../execution/gi_cbrt/cbrt/

# edit the location of glibc in the compile.bat
sed -i 's/\/tmp\/glibc-2.27/..\/..\/glibc-2.29/' compile.bat

# edit main to include ./ as bat otherwise can't find them
sed -i 's/main/.\/main/' fuzz*.bat
sed -i 's/main/.\/main/' test*.bat

# build glibc
cd ../../glibc-2.29
mkdir -p test/build
cd test/build
../../configure --prefix=$build
make


