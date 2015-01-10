#include "toast_asset.h"
#include <boost/filesystem.hpp>
#include <fstream>
#include <sstream>
#include <string>
#include <cerrno>


void ToastAsset::load(boost::filesystem::path asset_source_path) {
  boost::filesystem::ifstream asset_stream(asset_source_path, std::ios::in | std::ios::binary);
  if (asset_stream) {
    std::ostringstream asset_contents;
    asset_contents << asset_stream.rdbuf();
    asset_stream.close();
    this->contents = asset_contents.str();
  } else {
    throw(errno);
  }
}
  
void ToastAsset::save() {
  boost::filesystem::path asset_destination_path(this->destination_path);
  boost::filesystem::ofstream asset_stream(asset_destination_path, std::ios::out | std::ios::binary);
  if (asset_stream) {
    asset_stream << this->contents;
    asset_stream.close();
  } else {
    throw(errno);
  }
}

void ToastAsset::setDestinationPath(boost::filesystem::path asset_destination_path) {
  this->destination_path = asset_destination_path.string();
}
