toast: toast.cpp toast_asset.o toast_asset.h
	CC $(BOOST_INC) $(BOOST_LIB) toast.cpp -o toast toast_asset.o -lboost_mpi -lboost_serialization -lboost_filesystem -lboost_system

toast_asset.o: toast_asset.cpp toast_asset.h
	CC $(BOOST_INC) toast_asset.cpp -c 

clean:
	rm -rf toast_asset.o
	rm -rf toast
	rm -rf *.dat

assets/ten_megs.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/ten_megs.dat bs=1M count=10

assets/hundred_megs.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/hundred_megs.dat bs=1M count=100

assets/one_gig.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/one_gig.dat bs=1M count=1000

SLT=tests/shared-lib-test
$(SLT)/test_shared-lib.exe: toast $(SLT)/libdummy.h $(SLT)/libdummy.so $(SLT)/test_shared-lib.cpp
	CC -fPIC -dynamic $(SLT)/test_shared-lib.cpp -o $(SLT)/test_shared-lib.exe $(SLT)/libdummy.so

$(SLT)/libdummy.so: $(SLT)/libdummy.o
	CC -fPIC -shared -o $(SLT)/libdummy.so $(SLT)/libdummy.o

$(SLT)/libdummy.o: $(SLT)/libdummy.h $(SLT)/libdummy.cpp
	CC -fPIC -shared $(SLT)/libdummy.cpp -o $(SLT)/libdummy.o
