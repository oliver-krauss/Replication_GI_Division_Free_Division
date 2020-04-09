# ensure we are in the correct diretory
cd "$(dirname "$0")"

# clear the previous results if they existed
rm -rf ../replication_results

# build the project
csh build.bat

# create the replication result folder AFTER SUCCESS
mkdir ../../../replication_results

# copy over result files
cp fuzz*.out ../../../replication_results/
cp test*.out ../../../replication_results/
cp t_cbrt.c ../../../replication_results/
ls ../../../replication_results


