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
cp ./build_cbrt.bat ../execution/gi_cbrt/cbrt/
cp ./build_divide.bat ../execution/gi_cbrt/divide/

# modify cbrt
cd ../execution/gi_cbrt/cbrt/
# edit the location of glibc in the compile.bat
sed -i 's/\/tmp\/glibc-2.27/..\/..\/glibc-2.29/' compile.bat
# edit main to include ./ as bat otherwise can't find them
sed -i 's/main/.\/main/' fuzz*.bat
sed -i 's/main/.\/main/' test*.bat

# modify divide
cd ../divide/
# edit the location of glibc in the compile.bat
sed -i 's/\/tmp\/glibc-2.29/..\/..\/glibc-2.29/' compile.bat
# edit main to include ./ as bat otherwise can't find them
sed -i 's/main/.\/main/' fuzz*.bat
sed -i 's/main/.\/main/' test*.bat

# fix the missing divide file
cp ../divide_timing/gi_inv.c ./gi_inv.c

# fix the missing sqrt scripts
mkdir ../sqrt
cp ../cbrt/t_sqrt.c ../sqrt/t_sqrt.c

# cbrt must be compiled at least once
cd ../cbrt
csh compile.bat

# build glibc
cd ../../glibc-2.29
mkdir -p test/build
cd test/build
../../configure --prefix=$build
make


