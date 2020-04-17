# ensure we are in the correct diretory
cd "$(dirname "$0")"

# clear the previous results if they existed
rm -rf ../performance_results

# build the project
cd ../execution/gi_cbrt/divide_timing/
#csh do_test_time.bat

# create the replication result folder AFTER SUCCESS
mkdir ../../../performance_results

# copy over result files
cp *_time_*.out ../../../performance_results/

# collect pc information
cd ../../../performance_results/
echo System: >> system_info.txt
uname >> system_info.txt
echo >> system_info.txt

echo CPU Info: >> system_info.txt
lscpu >> system_info.txt
echo >> system_info.txt

echo Memory Info: >> system_info.txt
cat /proc/meminfo >> system_info.txt
echo >> system_info.txt

# show results
ls 


