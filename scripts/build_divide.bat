setenv seed 140353
if($1) setenv seed $1

# recompile code in case anything was changed
csh ./compile.bat

# run GI to generate lookup table
csh ./gi_t_inv.bat $seed >& gi_t_inv.out

# transfer results into t_invsqrt.c
gawk -f ../log2/make_t_log2.awk gi_t_inv.out > t_invsqrt.c

# recompile with new lookup table
csh ./compile.bat

# conduct the tests
csh ../cbrt/test.bat > test.out
csh ../cbrt/test2.bat > test2.out
csh ../cbrt/fuzz1.bat > fuzz1.out
csh ../cbrt/fuzz_exp.bat > fuzz_exp.out
csh ../cbrt/fuzz_int.bat > fuzz_int.out
