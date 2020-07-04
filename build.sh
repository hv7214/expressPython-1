#!/bin/bash

# INSTALL QT5

if [[ $OSTYPE == "linux-gnu"* ]] 
then

    sudo apt-get install build-essential

    sudo apt-get install qt5-default

else 

    brew install qt5

    brew reinstall python@3.8

    export PATH="/usr/local/opt/qt/bin:$PATH"

    export LDFLAGS="-L/usr/local/opt/qt/lib"
    
    export CPPFLAGS="-I/usr/local/opt/qt/include"
    
fi

# SETUP ENVIRONMENT VARIABLES

if [[ $OSTYPE == "linux-gnu"* ]]
then 

    export PYTHON3_LIB_LOCATION=python3.8

    export PYTHON3_INC_LOCATION=/usr/include/python3.8/

else
    # export PYTHON3_LIB_LOCATION=/System/Library/Frameworks/Python.framework

    # export PYTHON3_INC_LOCATION=/System/Library/Frameworks/Python.framework/Versions/Current/Headers/
    ls /usr/local/Cellar/python@3.8/3.8.4/
    echo "====="
    ls /usr/local/Cellar/python@3.8/3.8.4/Frameworks
    echo "====="
    ls /usr/local/Cellar/python@3.8/3.8.4/lib/pkgconfig
    echo "====="
    ls /usr/local/Cellar/python@3.8/3.8.4/libexec
    echo "====="
    ls /usr/local/Cellar/python@3.8/3.8.4/bin
    echo "====="
    ls /usr/local/Cellar/python@3.8/3.8.4/Frameworks/Python.framework/Versions/Current
    echo "====="
    ls /usr/local/Cellar/python@3.8/3.8.4/Frameworks/Python.framework/Headers
    echo "====="
    ls /usr/local/Cellar/python@3.8/3.8.4/Frameworks/Python.framework/Python
    echo "====="
    ls /usr/local/Cellar/python@3.8/3.8.4/Frameworks/Python.framework/Resources
    echo "====="
    ls /System/Library/Frameworks/Python.framework/Versions/Current/include
    echo "====="
    ls /System/Library/Frameworks/Python.framework/Versions/Current/Headers/
    echo "====="
    ls /System/Library/Frameworks/Python.framework/Versions/Current/lib/
    echo "====="
    ls /System//Library/Frameworks/Python.framework/Versions/
    export PYTHON3_LIB_LOCATION=/usr/local/Cellar/python/3.8.0/Frameworks/Python.framework/Versions/3.7/lib

    export PYTHON3_INC_LOCATION=/usr/local/Cellar/python/3.8.0/Frameworks/Python.framework/Versions/3.8/include/python3.8m

fi


export ANTLR_LIB_LOCATION=ANTLR4runtime/run/usr/local/lib/libantlr4-runtime.so.4.8

export ANTLR_INC_LOCATION=ANTLR4runtime/run/usr/local/include/antlr4-runtime/

export QTERMWIDGET_LIB_LOCATION=qtermwidget/run/usr/local/lib/libqtermwidget5.so

export QTERMWIDGET_INC_LOCATION=qtermwidget/run/usr/local/include/qtermwidget5/

# FETCH SUBMODULES 

git submodule update --init --recursive

# SETUP ANTLR

if [[ $OSTYPE == "linux-gnu"* ]] 
then

    sudo apt update

    sudo apt install uuid-dev

else 

    brew install pkg-config

fi

cd ANTLR4runtime

rm -rf build && rm -rf run

mkdir build && mkdir run && cd build

cmake ..

DESTDIR=../run make install

# SETUP LXQT-BUILD-TOOLS

if [[ $OSTYPE == "linux-gnu"* ]]
then

    sudo apt-get install libglib2.0-dev

else 

    brew install glib
    
fi

cd ../../lxqt-build-tools

rm -rf build && rm -rf run

mkdir build && mkdir run && cd build

cmake ..

DESTDIR=../run make install

# SETUP QTERMWIDGET

if [[ $OSTYPE == "linux-gnu"* ]]
then

    sudo apt-get install qttools5-dev

fi

cd ../../qtermwidget 

sudo rm -rf build && sudo rm -rf run

mkdir build && mkdir run && cd build

cmake .. -DCMAKE_PREFIX_PATH=$PWD/../../lxqt-build-tools/run/usr/local/share/cmake/lxqt-build-tools

sudo DESTDIR=../run make install

# SETUP EXPRESSPYTHON 

cd ../../

rm -rf build && rm -rf run

mkdir build && mkdir run && cd build 

cmake ..

cmake --build .

cpack 


# if [[ $OSTYPE != "linux-gnu"* ]]
# then
# cat /Users/runner/work/expressPython/expressPython/build/_CPack_Packages/Darwin/DragNDrop/PreinstallOutput.log
# fi
