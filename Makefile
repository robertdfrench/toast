SLT=tests/shared-lib-test
toast: toast.cpp toast_asset.o toast_asset.h
	CC $(BOOST_INC) $(BOOST_LIB) toast.cpp -o toast toast_asset.o -lboost_mpi -lboost_serialization -lboost_filesystem -lboost_system

toast_asset.o: toast_asset.cpp toast_asset.h
	CC $(BOOST_INC) toast_asset.cpp -c 

clean:
	rm -rf *.o
	rm -rf toast
	rm -rf *.dat
	rm -rf *.exe
	rm -rf *.so

assets/ten_megs.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/ten_megs.dat bs=1M count=10

assets/hundred_megs.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/hundred_megs.dat bs=1M count=100

assets/one_gig.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/one_gig.dat bs=1M count=1000

test_shared-lib.exe: libdummy.so $(SLT)/test_shared-lib.cpp $(SLT)/libdummy.h
	CC -Wall -L. $(SLT)/test_shared-lib.cpp -o test_shared-lib.exe -ldummy

libdummy.so: libdummy.o
	CC -shared -o libdummy.so libdummy.o

libdummy.o: $(SLT)/libdummy.h $(SLT)/libdummy.cpp
	CC -c -Wall -Werror -fpic $(SLT)/libdummy.cpp
