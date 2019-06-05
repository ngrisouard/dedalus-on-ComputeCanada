module purge
module load python/3.6.5
module load intel/2018.2
module load intelmpi/2018.2
module load fftw-mpi/3.3.7
module load hdf5-mpi/1.10.2

virtualenv venv
source ./venv/bin/activate
pip install --only-binary=:all: cython matplotlib numpy scipy six

export HDF5_MPI=ON
export LDSHARED="icc -shared"
pip install --no-binary=:all: mpi4py h5py docopt

hash="da23b4184fc0"  # may change to newer version
wget "https://bitbucket.org/dedalus-project/dedalus/get/$hash.zip"
unzip "$hash.zip"
rm ${hash}.zip
cd dedalus-project-dedalus-$hash

export FFTW_PATH="$SCINET_FFTW_MPI_ROOT"
export MPI_PATH="$I_MPI_ROOT"
python setup.py install

export MPLBACKEND=pdf

cd examples/ivp/1d_kdv_burgers/
python kdv_burgers.py
