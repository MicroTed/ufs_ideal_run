#!/bin/bash
#SBATCH -e fcst.err
#SBATCH -o fcst.out
#SBATCH --account=[account]
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=20
#SBATCH --job-name="run_ideal_supercell_intel"
### #SBATCH --exclusive

# This job is set up to use 16 cores with no OpenMP
# The settings in ufs.configure must match
# ATM_petlist_bounds: 0 15
# ATM_omp_num_threads: 1

set -eux
date_s_start=$(date +%s)
echo -n "${date_s_start}," > job_timestamp.txt

# NEED TO SET UP APPROPRIAT MODULES HERE
# module purge
# module use [path to ufs_weather_model]/modulefiles
# module load ufs_hera.intel # or whatever platform

date_start=$(date)
echo "Model started: ${date_start}"

export MPI_TYPE_DEPTH=20
export OMP_STACKSIZE=512M
# shellcheck disable=SC2125
export OMP_NUM_THREADS=1
export ESMF_RUNTIME_COMPLIANCECHECK=OFF:depth=4
export ESMF_RUNTIME_PROFILE=ON
export ESMF_RUNTIME_PROFILE_OUTPUT="SUMMARY"
export PSM_RANKS_PER_CONTEXT=4
export PSM_SHAREDCONTEXTS=1

# Avoid job errors because of filesystem synchronization delays
sync && sleep 1

# This "if" block is part of the rt.sh self-tests in error-test.conf. It emulates the model failing to run.
if [ "${JOB_SHOULD_FAIL:-NO}" = WHEN_RUNNING ] ; then
    echo "The job should abort now, with exit status 1." 1>&2
    echo "If error checking is working, the metascheduler should mark the job as failed." 1>&2
    false
fi

# shellcheck disable=SC2102
srun --label -n 16 ./ufs_model
# srun --label -n 25 ../ideal_supercell_intel/fv3.lr.exe

date_end=$(date)
echo "Model ended: ${date_end}"
date_s_end=$(date +%s)
echo -n "${date_s_end}," >> job_timestamp.txt
