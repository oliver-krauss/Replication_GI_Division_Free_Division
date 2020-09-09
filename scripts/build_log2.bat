setenv seed 140353
if($1) setenv seed $1

# recompile code in case anything was changed
csh ./compile.bat

# run GI to generate lookup table
csh ./gi_t_log2.bat $seed >& gi_t_log2.out

# transfer results into t_cbrt.c
gawk -f make_t_log2.awk gi_t_log2.out > t_log2.c

# recompile with new lookup table
csh ./compile.bat

# conduct the tests
csh ./test.bat > test.out
csh ./test2.bat > test2.out
csh ./test_1.bat > test_1.out
