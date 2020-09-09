#WBL 3 March 2019 based on $Revision: 1.2 $ 
#../log2/compile.bat r1.9 
#../cbrt/compile.bat r1.3
#../sqrt/compile2.bat r1.3 

#WBL 6 Mar 2019 remov glibc-2.29
#WBL 3 Mar 2019 Use glibc-2.29

#use gcc version 7.2.1 20170829 (Red Hat 7.2.1-1) (GCC)
setenv PATH /opt/rh/devtoolset-7/root/usr/bin/:$PATH

setenv BUILD2 ../../glibc-2.29/test/build
setenv BUILD  ../../glibc-2.29

#Notes
# originally for x86_64
# left-right order of include files (and their directories) vital
# -MF /tmp/glibc-2.27/test/build/math/e_sqrt.o.d not so helpful
# -I$BUILD/sysdeps/x86/bits exactly wrong approach
# -v useful debug aid

#    -fmax-errors=1	\


gcc	\
    gi_invsqrt.c	\
    -c	\
    -c	\
    -std=gnu11	\
    -fgnu89-inline	\
    -O2	\
    -Wall	\
#    -Werror	\
#    -Wundef	\
    -Wwrite-strings	\
    -fmerge-all-constants	\
    -fno-stack-protector	\
    -frounding-math	\
    -g	\
    -Wstrict-prototypes	\
    -Wold-style-definition	\
    -ffp-contract=off	\
    -D__NO_MATH_INLINES	\
    -D__LIBC_INTERNAL_MATH_INLINES	\
    -I$BUILD/include	\
    -I$BUILD/math	\
    -I.	\
    -I$BUILD/sysdeps/unix/sysv/linux/x86_64/64	\
    -I$BUILD/sysdeps/unix/sysv/linux/x86_64	\
    -I$BUILD/sysdeps/unix/sysv/linux/x86	\
    -I$BUILD/sysdeps/x86/nptl	\
    -I$BUILD/sysdeps/unix/sysv/linux/wordsize-64	\
    -I$BUILD/sysdeps/x86_64/nptl	\
    -I$BUILD/sysdeps/unix/sysv/linux/include	\
    -I$BUILD/sysdeps/unix/sysv/linux	\
    -I$BUILD/sysdeps/nptl	\
    -I$BUILD/sysdeps/pthread	\
    -I$BUILD/sysdeps/gnu	\
    -I$BUILD/sysdeps/unix/inet	\
    -I$BUILD/sysdeps/unix/sysv	\
    -I$BUILD/sysdeps/unix/x86_64	\
    -I$BUILD/sysdeps/unix	\
    -I$BUILD/sysdeps/posix	\
    -I$BUILD/sysdeps/x86_64/64	\
    -I$BUILD/sysdeps/x86_64/fpu/multiarch	\
    -I$BUILD/sysdeps/x86_64/fpu	\
    -I$BUILD/sysdeps/x86/fpu/include	\
    -I$BUILD/sysdeps/x86/fpu	\
    -I$BUILD/sysdeps/x86_64/multiarch	\
    -I$BUILD/sysdeps/x86_64	\
    -I$BUILD/sysdeps/x86	\
    -I$BUILD/sysdeps/ieee754/float128	\
    -I$BUILD/sysdeps/ieee754/ldbl-96/include	\
    -I$BUILD/sysdeps/ieee754/ldbl-96	\
    -I$BUILD/sysdeps/ieee754/dbl-64/wordsize-64	\
    -I$BUILD/sysdeps/ieee754/dbl-64	\
    -I$BUILD/sysdeps/ieee754/flt-32	\
    -I$BUILD/sysdeps/wordsize-64	\
    -I$BUILD/sysdeps/ieee754	\
    -I$BUILD/sysdeps/generic	\
    -I$BUILD	\
    -I$BUILD/libio	\
    -D_LIBC_REENTRANT	\
    -include $BUILD2/libc-modules.h	\
    -DMODULE_NAME=libm	\
    -I$BUILD2	\
    -include $BUILD/include/libc-symbols.h	\
    -DTOP_NAMESPACE=glibc	\
    -I$BUILD/soft-fp

setenv save $status
if($save) then
  echo "gcc gi_invsqrt.c failed status $save"
  rm -f gi_invsqrt.o
  exit $save
endif

gcc -g -c -O2 -ansi -pedantic	\
  -Wall -Wextra -Wstrict-prototypes -Wmissing-prototypes -Wshadow	\
  -Wno-pedantic 		    			 		\
  test.c

setenv save $status
if($save) then
  echo "gcc test.c failed status $save"
  rm -f test.o
  exit $save
endif

echo "gcc -o test test.o gi_invsqrt.o -lm"
gcc -o test test.o gi_invsqrt.o -lm

setenv save $status
if($save) then
  echo "link test failed status $save"
  rm -f test >& /dev/null
  exit $save
endif

echo "$0 done" `ls -l test`

exit #<<<<<<<<<<<<
#can reuse cmaes_cbrt.c for invsqrt

gcc -g -c -O2 -ansi -pedantic	\
  -Wall -Wextra -Wstrict-prototypes -Wmissing-prototypes -Wshadow	\
  -Wno-pedantic 		    			 		\
  cmaes_cbrt.c -I../cbrt/c-cmaes-master/src/

setenv save $status
if($save) then
  echo "gcc cmaes_cbrt.c failed status $save"
  rm -f cmaes_cbrt.o
  exit $save
endif

gcc -o cmaes_invsqrt cmaes_cbrt.o ../cbrt/cmaes.o gi_invsqrt.o -lm

setenv save $status
if($save) then
  echo "link cmaes_invsqrt failed status $save"
  rm -f cmaes_invsqrt >& /dev/null
  exit $save
endif

echo "$0 done" `ls -l cmaes_invsqrt`

exit #<<<<<<<<<<<<

will need more things compiled later but see if can get CMA-ES part
running first then raid ../log2/compile.bat again when get that far
