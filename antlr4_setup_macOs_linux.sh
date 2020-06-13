cd ANTLR4runtime

rm -rf build 

rm -rf run 

mkdir build && mkdir run && cd build

cmake ..

DESTDIR=../run make install
