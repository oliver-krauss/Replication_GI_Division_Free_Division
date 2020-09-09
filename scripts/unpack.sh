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
cp ./build_invsqrt.bat ../execution/gi_cbrt/invsqrt/
cp ./build_log2.bat ../execution/gi_cbrt/log2/

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

# modify log2
cd ../log2/
# edit the location of glibc in the compile.bat
sed -i 's/\/tmp\/glibc-2.27/..\/..\/glibc-2.29/' compile.bat
# fix missing includes
sed -i 's/powerpc specific/\n#include <float.h>\n#include <fenv.h>/' gi_log2.c 
# edit main to include ./ as bat otherwise can't find them
sed -i 's/main/.\/main/' fuzz*.bat
sed -i 's/main/.\/main/' test*.bat

# modify invsqrt
cd ../invsqrt/
# edit the location of glibc in the compile.bat files
sed -i 's/\/tmp\/glibc-2.29/..\/..\/glibc-2.29/' compile.bat
sed -i 's/\/tmp\/glibc-2.29/..\/..\/glibc-2.29/' compile_test.bat
sed -i 's/\/tmp\/glibc-2.29/..\/..\/glibc-2.29/' quake_compile.bat
# edit main to include ./ as bat otherwise can't find them
sed -i 's/main/.\/main/' fuzz*.bat
sed -i 's/main/.\/main/' test*.bat

# fix the missing divide file
cp ../divide_timing/gi_inv.c ./gi_inv.c

# fix the missing sqrt scripts
mkdir ../sqrt
cp ../cbrt/t_sqrt.c ../sqrt/t_sqrt.c

# fix the broken invsqrt compile_test script by overriding it
cp ./invsqrt_compile_test.bat ../execution/gi_cbrt/invsqrt/compile_test.bat

# fix the missing quake test scripts
cp ../cbrt/test_1.bat ./quake_test_1.bat
cp ../cbrt/test2.bat ./quake_test_2.bat
cp ../cbrt/fuzz1.bat ./quake_fuzz_1.bat
cp ../cbrt/fuzz_exp.bat ./quake_fuzz_exp.bat
cp ../cbrt/fuzz_int.bat ./quake_fuzz_int.bat
sed -i 's/main2/main2_quake/' quake_test*.bat
sed -i 's/main2/main2_quake/' quake_fuzz*.bat

# build glibc
cd ../../glibc-2.29
mkdir -p test/build
cd test/build
../../configure --prefix=$build
make

# cbrt must be compiled at least once AFTER building glibc
cd ../../../gi_cbrt/cbrt
csh compile.bat


