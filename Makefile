toast: toast.cpp toast_asset.o
	CC $(BOOST_INC) $(BOOST_LIB) toast.cpp -o toast -lboost_mpi -lboost_serialization

toast_asset.o: toast_asset.cpp toast_asset.h
	CC $(BOOST_INC) toast_asset.cpp -c 
