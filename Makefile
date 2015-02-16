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
	rm -rf build/tests/*

assets/ten_megs.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/ten_megs.dat bs=1M count=10

assets/hundred_megs.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/hundred_megs.dat bs=1M count=100

assets/one_gig.dat:
	mkdir -p assets
	dd if=/dev/urandom of=assets/one_gig.dat bs=1M count=1000

build/tests/test_shared-lib%.exe: build/tests/libdummy%.so $(SLT)/test_shared-lib.cpp $(SLT)/libdummy.h
	mkdir -p build
	mkdir -p build/tests
	CC -Wall -Lbuild/tests/ $(SLT)/test_shared-lib.cpp -o build/tests/test_shared-lib$*.exe -dynamic -ldummy$*

build/tests/libdummy%.so: build/tests/libdummy.o
	mkdir -p build
	mkdir -p build/tests
	CC -shared -o $@ build/tests/libdummy.o

build/tests/libdummy.o: $(SLT)/libdummy.h $(SLT)/libdummy.cpp
	mkdir -p build
	mkdir -p build/tests
	CC -c -Wall -Werror -fpic $(SLT)/libdummy.cpp -o $@

.PRECIOUS: build/tests/libdummy%.so
