# Replication Package - Genetic Improvement of Data Gives Division free Division

This is the replication package for Genetic Improvement of Data gives Division free Division  (author copy - GI_Data_Gives_Divsion_Free_Division.pdf).

The package contains the source code as described in section IV of the publication and aims to enable the reproduction of section IV b - Automatic changes to data table using CMA-ES and section IV c - Testing the evolved drcp function.

### Content of the Repository
- __Publication.pdf__ author copy of the submission
- __gi_cbrt.tar.gz__ contains the source code the paper was written on, as described in Section IV Evolving DRCP From Free GNU PowerPC SQRT
- __dependencies__ contains libraries needed for replication
  - GNU C Library (glibc) - Download from: https://www.gnu.org/software/libc/. Contained file is the exact version that the submission was conducted with.
- __scripts__ contains various scripts that are supposed to make the replication easier for the user. If there are issues with them, please consult the README.txt in gi_cbrt.tar.gz, the scripts themselves (maybe you are missing packages on linux), or open an issue in
- __results__ contains logs of the executions the publication was based on

### Preconditions

- __Linux OS__ - As this work depends on glibc.
- Installation of the following __linux packages__ (intentionally not provided as script, as it would have to be run with root privileges):
  - gunzip `sudo apt-get install gzip`
  - tar `sudo apt-get install tar`
  - csh `sudo apt-get install csh`
  - sed `sudo apt-get install sed`

### Replication

Replicate using the following steps:
- (optional) __scripts__ you may need to make scripts executable with `chmod +x *.sh`
- __unpack.sh__ will unpack to an execution folder (warning execution folder WILL be deleted by unpack), and build glibc
- __replicate.sh__ runs the compilation, CMA-ES execution, and tests of the lookup table
- You'll know if the replication succeeded when the folder "replication_results" is created and contains:
  - the generated lookup table (t_cbrt.c)
  - the outputs of the test scripts (*.out)

### Performance testing

#### Additional preconditions

- Installation of the following __linux packages__ (intentionally not provided as script, as it would have to be run with root privileges):
  - rcs `sudo apt-get install rcs`

#### Performance testing

Test (not replicate due to different hardware!) using the following steps:
-  __performance.sh__ executes the benchmark
- You'll know if the benchmakr succeeded when the folder "performance_results" is created and contains:
  - The outputs of the tests (*.out)
  - benchmarking info of your pc (system_info.txt)
