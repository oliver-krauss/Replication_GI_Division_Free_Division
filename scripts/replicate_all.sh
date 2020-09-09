# ensure we are in the correct diretory
cd "$(dirname "$0")"

./replicate.sh cbrt
cp -r ../replication_results ../replication_results_cbrt
./replicate.sh divide
cp -r ../replication_results ../replication_results_divide
./replicate.sh invsqrt
cp -r ../replication_results ../replication_results_invsqrt
./replicate.sh log2
cp -r ../replication_results ../replication_results_log2
rm -rf ../replication_results
./performance.sh


