# ensure we are in the correct diretory
cd "$(dirname "$0")"

# ensure $1 is set to something
if [ -z ${1} ]; then set "divide"; fi

# clear the previous results if they existed
rm -rf ../replication_results

# build the project
cd ../execution/gi_cbrt/$1/
csh build_$1.bat

# create the replication result folder AFTER SUCCESS
mkdir ../../../replication_results

# copy over result files
cp fuzz*.out ../../../replication_results/
cp test*.out ../../../replication_results/

# lazy copy -> we attempt to copy all t_ no matter which folder we are in (only 1 will work!)
cp t_cbrt.c ../../../replication_results/
cp t_invsqrt.c ../../../replication_results/
cp t_log2.c ../../../replication_results/
ls ../../../replication_results


