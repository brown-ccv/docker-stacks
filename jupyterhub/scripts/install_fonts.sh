#!/bin/bash

DIR=`pwd`

cd /usr/local/share/fonts

# TeX Gyre Pagella
wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bold.otf
wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bolditalic.otf
wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-italic.otf
wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-regular.otf

fc-cache -fv

cd $DIR
