#include <boost/serialization/access.hpp>
#include <boost/serialization/string.hpp>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>

class ToastAsset {
  private:
    friend class boost::serialization::access;
    template<class Archive> void serialize(Archive & ar, const unsigned int version) {
      ar & destination_path;
      ar & contents;
    }

    std::string destination_path;
    std::string contents;
  public:
    void load(boost::filesystem::path asset_source_path);
    void setDestinationPath(boost::filesystem::path asset_destination_path);
    void save();
    
};
