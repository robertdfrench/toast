#include <boost/serialization/access.hpp>
#include <boost/serialization/string.hpp>

class ToastAsset {
  private:
    friend class boost::serialization::access;
    template<class Archive> void serialize(Archive &ar, const unsigned int version);

    std::string filename;
    std::string destination_path;
    std::string contents;
  public:
    void load(std::string asset_source_path);
    void save();
    
};
