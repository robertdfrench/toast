#include <iostream>
#include "mpi.h"
#include "libdummy.h"

int main(int argc, char** argv) {
  MPI_Init(&argc, &argv);
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  std::cout << bigString();
  MPI_Finalize();
  return 0;
}
