toast: toast.cpp toast_asset.o
	CC $(BOOST_INC) $(BOOST_LIB) toast.cpp -o toast toast_asset.o -lboost_mpi -lboost_serialization -lboost_filesystem -lboost_system

toast_asset.o: toast_asset.cpp toast_asset.h
	CC $(BOOST_INC) toast_asset.cpp -c 

clean:
	rm -rf toast_asset.o
	rm -rf toast
	rm -rf *.dat

asset_ten_megs.dat:
	dd if=/dev/urandom of=asset_ten_megs.dat bs=1M count=10

asset_hundred_megs.dat:
	dd if=/dev/urandom of=asset_hundred_megs.dat bs=1M count=100

asset_on_gig.dat:
	dd if=/dev/urandom of=asset_one_gig.dat bs=1M count=1000
