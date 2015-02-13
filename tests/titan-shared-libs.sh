#!/usr/bin/env bash
echo "Testing Toast on $PBS_NUM_NODES of Titan"
date

# Load Modules
source tests/environment.sh
source $MODULESHOME/init/bash
module swap PrgEnv-pgi PrgEnv-gnu
module load boost

# Build toast
cd /ccs/home/frenchrd/Projects/toast
make toast
cp toast $SCRATCH_PATH

# Build dummy app that depends on a dylib
for i in {1..10}
do
	make test_shared-lib.exe
	cp test_shared-lib.exe $SCRATCH_PATH/test_shared-lib.$i.exe
	cp libdummy.so $SCRATCH_PATH/lib
done

cd $SCRATCH_PATH

# Launch without staging 
echo "Launching shared library test without staging"
export LD_LIBRARY_PATH=$SCRATCH_PATH:$LD_LIBRARY_PATH
time aprun -n $((PBS_NUM_NODES * 16)) ./test_shared-lib.exe
