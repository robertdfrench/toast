#include <boost/mpi.hpp>
#include <boost/filesystem.hpp>
#include <iostream>
#include <string>

#include "toast_asset.h"

namespace mpi = boost::mpi;

void print_help() {
  std::cout << "USAGE: toast <source_file> <destination_path>" << std::endl;
}

int main(int argc, char** argv) {
  // Set up MPI
  mpi::environment env(argc, argv);
  mpi::communicator world;

  // Exit and print help unless sufficiently many args given
  if(argc < 2) {
    if (world.rank() == 0) print_help();
    exit(0);
  }

  // Set up local communicator
  mpi::communicator local = world.split(world.rank() / 10);

  // Load Asset (Local Rank Zeroes only)
  ToastAsset ta;
  if (local.rank() == 0) {
    boost::filesystem::path source_file(argv[1]);
    boost::filesystem::path destination_path(argv[2]);
    ta.setDestinationPath(destination_path);
    ta.load(source_file);
  }

  // Broadcast Asset
  broadcast(local, ta, 0);

  // Deploy asset
  ta.save();
  
  return 0; 	
}
