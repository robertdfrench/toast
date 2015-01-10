#!/usr/bin/env bash
echo "Testing Toast on $PBS_NUM_NODES of Titan"
date

# Load Modules
source tests/environment.sh
source $MODULESHOME/init/bash
module swap PrgEnv-pgi PrgEnv-gnu
module load boost

# Build toast
make toast
cp toast $SCRATCH_PATH

# Asset for CP
make assets/hundred_megs.dat
mv assets/hundred_megs.dat $SCRATCH_PATH/hundred_megs_cp.dat

# Asset for Toast
make assets/hundred_megs.dat
mv assets/hundred_megs.dat $SCRATCH_PATH/hundred_megs_toast.dat

cd $SCRATCH_PATH

echo "Unix cp on each rank"
time aprun -n $((PBS_NUM_NODES * 16)) cp hundred_megs_cp.dat /tmp/scratch

echo "Toast on each node"
time aprun -n $PBS_NUM_NODES -N 1 ./toast hundred_megs_toast.dat /tmp/scratch/hundred_megs_toast.dat
