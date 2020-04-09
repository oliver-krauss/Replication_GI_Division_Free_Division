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

# build glibc
cd ../execution/glibc-2.29
mkdir -p test/build
cd test/build
../../configure --prefix=$build
make
