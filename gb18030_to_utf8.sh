#!/bin/zsh
find . -iname "*.h" -o -iname "*.hpp" -o -iname "*.hxx" -o -iname "*.c" -o -iname "*.cpp" -o -iname "*.cxx" -o -iname "*.cc"|\
    sort|uniq|\
    while read filename ;do 
        iconv -f gb18030 -t utf-8 $filename > iconvtmp
        rm -rf $filename
        cp iconvtmp $filename
        rm -rf iconctmp
    done
