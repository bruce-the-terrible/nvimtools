#!/bin/zsh
#mac平台。linux平台需要改为/bin/bash
#本脚本用于生成compile_command.json，用于neovim+lsp+clangd阅读代码
#应该尽量使用编译工具链生成compile_command.json.
#只有在其他途径都难以获得时，才使用本脚本
#本脚本仅用于阅读代码，不能用于编译
#用法 ./gen_compile_commands.sh projectname
filename="xmake.lua"
projectname="fake_xmake"
rm -rf $filename
rm -rf compile_command.json
touch $filename
touch .git
#echo "set_project(\"$1\")" >> $filename
echo "set_project(\"$projectname\")" >> $filename
echo "set_xmakever(\"2.7.9\")" >> $filename
echo "set_version(\"1.0.0\")" >> $filename
#echo "  target(\"$1\")" >> $filename
echo "  target(\"$projectname\")" >> $filename
echo "      set_kind(\"binary\")" >> $filename
echo "      set_targetdir(\"./build\")" >> $filename
echo "      add_files(\"./**.c\")" >> $filename
echo "      add_files(\"./**.s\")" >> $filename
#echo "      add_files(\"./**.cpp\")" >> $filename
#echo "      add_files(\"./**.cxx\")" >> $filename
find . -iname "*.h" -o -iname "*.hpp" -o -iname "*.hxx" |\
    xargs -o dirname |sort|uniq|\
    while read dir_name ;do 
        echo "      add_includedirs(\"$dir_name\")";
    done >> $filename
xmake project -k compile_commands
