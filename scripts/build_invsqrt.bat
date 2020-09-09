# fix the missing quake test scripts
cp ../cbrt/test_1.bat ./quake_test_1.bat
cp ../cbrt/test2.bat ./quake_test_2.bat
cp ../cbrt/fuzz1.bat ./quake_fuzz_1.bat
cp ../cbrt/fuzz_exp.bat ./quake_fuzz_exp.bat
cp ../cbrt/fuzz_int.bat ./quake_fuzz_int.bat
sed -i 's/main2/main2_quake/' quake_test*.bat
sed -i 's/main2/main2_quake/' quake_fuzz*.bat

setenv seed 140353
if($1) setenv seed $1

# recompile code in case anything was changed
csh ./compile.bat
csh ./compile_test.bat

# run GI to generate lookup table
csh ./gi_t_invsqrt.bat $seed >& gi_t_invsqrt.out

# transfer results into t_cbrt.c
gawk -f gi_t_invsqrt.awk gi_t_invsqrt.out > t_invsqrt.c

# recompile with new lookup table
csh ./compile.bat
csh ./compile_test.bat

# conduct the tests
csh ./test.bat > test.out
csh ../cbrt/test_1.bat > test_1.out
csh ../cbrt/test2.bat > test2.out
csh ../cbrt/fuzz1.bat > fuzz1.out
csh ../cbrt/fuzz_exp.bat > fuzz_exp.out
csh ../cbrt/fuzz_int.bat > fuzz_int.out

# compile quake
csh ./quake_compile.bat

# conduct quake tests
csh ./quake_test_1.bat > test_1_quake.out
csh ./quake_test_2.bat > test2_quake.out
csh ./quake_fuzz_1.bat > fuzz1_quake.out
csh ./quake_fuzz_exp.bat > fuzz_exp_quake.out
csh ./quake_fuzz_int.bat > fuzz_int_quake.out

