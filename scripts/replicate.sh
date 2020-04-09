# ensure we are in the correct diretory
cd "$(dirname "$0")"

# clear the previous results if they existed
rm -rf ../replication_results

# move build bat to correct directory as csh does not understand working directories
cp ./build.bat ../execution/gi_cbrt/cbrt/
cd ../execution/gi_cbrt/cbrt/

# edit the location of glibc in the compile.bat
sed -i 's/\/tmp\/glibc-2.27/..\/..\/glibc-2.29/' compile.bat
sed -i 's/main/.\/main/' fuzz*.bat
sed -i 's/main/.\/main/' test*.bat

# build the project
#csh build.bat

# create the replication result folder AFTER SUCCESS
mkdir ../../../replication_results

# copy over result files
cp fuzz*.out ../../../replication_results/
cp test*.out ../../../replication_results/
cp t_cbrt.c ../../../replication_results/
ls ../../../replication_results


