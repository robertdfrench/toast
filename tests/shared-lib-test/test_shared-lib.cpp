#include <iostream>
#include "mpi.h"
#include "libdummy.h"

int main(int argc, char** argv) {
  MPI_Init(&argc, &argv);
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  MPI_Barrier(MPI_COMM_WORLD);
  double start = MPI_Wtime();
  std::string mystring = bigString();
  double invocation_time = MPI_Wtime() - start;
  int length = mystring.length();
  MPI_Barrier(MPI_COMM_WORLD);

  std::cout << "{\"rank\": " << rank << ", \"invocation_time\": " << invocation_time << ", \"str_length\": " << length << "}" << std::endl;
  MPI_Finalize();
  return 0;
}
