setenv seed 140353
if($1) setenv seed $1

# recompile code in case anything was changed
csh $cwd/compile.bat

# run GI to generate lookup table
csh ./gi_t_cbrt.bat $seed >& gi_t_cbrt.out

# transfer results into t_cbrt.c
gawk -f make_t_cbrt.awk gi_t_cbrt.out > t_cbrt.c

# recompile with new lookup table
csh ./compile.bat

# conduct the tests
csh ./test.bat > test.out
csh ./test2.bat > test2.out
csh ./test_exp.bat > fuzz_exp.out
csh ./fuzz1.bat > fuzz1.out
csh ./fuzz_exp.bat > fuzz_exp.out
csh ./fuzz_int.bat > fuzz_int.out
