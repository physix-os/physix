#!/bin/bash                                                                    
# SPDX-License-Identifier: MIT
# Copyright (C) 2019 Travis Davies

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source $SCRIPTPATH/../include.sh
source ~/.bashrc

cd $BUILDROOT/sources      
PKG=$1                   
stripit $PKG             
SRCD=$STRIPPED           
                         
unpack $PKG NCHRT
cd $BUILDROOT/sources/$SRCD

./configure --prefix=/tools
check $? "File configure"                                                     
                                                                                
make                                                                            
check $? "File make"                                                          

make check                                                                                
check $? "File make check" noexit
                                                                                
make install                                                                    
check $? "File make install"

rm -rf $BUILDROOT/sources/$SRCD
check $? "File: rm -rf $BUILDROOT/sources/$SRCD"

