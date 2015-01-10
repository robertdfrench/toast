toast: toast.cpp toast_asset.o
	CC $(BOOST_INC) $(BOOST_LIB) toast.cpp -o toast toast_asset.o -lboost_mpi -lboost_serialization -lboost_filesystem -lboost_system

toast_asset.o: toast_asset.cpp toast_asset.h
	CC $(BOOST_INC) toast_asset.cpp -c 

clean:
	rm -rf toast_asset.o
	rm -rf toast
