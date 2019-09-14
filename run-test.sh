#!/bin/bash
set -x

target=""
default="test-desktop-chrome-single-custom"
# run mocha test
if [ "$1" == "mo" ]; then
    target="test-mocha-default"
    # run macaca single test case
    elif [ "$1" == "ma" ]; then
    target=${default}
    # run all macaca test cases in specified folder
    elif [ "$1" == "all" ]; then
    target="test-desktop-chrome-all-custom"
else
    target=${default}
fi
echo "run target: ${target}"
# make ${target}


# Mocha cli:
# https://mochajs.org/
mocha_bin="./node_modules/.bin/mocha"
# ${mocha_bin} -h
# ${mocha_bin} -V

# -R, --reporter: specify the reporter to use.
# -u, --ui: specify user-interface (bdd|tdd|qunit|exports).
# ${mocha_bin} --opts mocha.opts -R list -u tdd -g "part 2"
# ${mocha_bin} --opts mocha.opts --grep "part 3"


# Macaca cli:
# https://macacajs.github.io/quick-start
# macaca run -h
# test="./macaca-test-web/desktop-browser-sample.test.js"
# CHROMEDRIVER_VERSION=2.35 BROWSER_CLOSE=true browser=chrome macaca run -d ${test}

# run macaca chrome tests by mocha cmd
# pre-condition: start server => "$ CHROMEDRIVER_VERSION=2.35 macaca server --verbose"
# chrome_test="./macaca-test-web/chrome_demo_01.test.js"
# CHROMEDRIVER_VERSION=2.35 BROWSER_CLOSE=true browser=chrome ${mocha_bin} ${chrome_test} -g "#01-01" -R list

# run macaca andorid tests by mocha cmd
# env setup: $ cnpm i macaca-android -g
# for dependency apks:
# /usr/local/lib/node_modules/macaca-android/node_modules/uiautomatorwd/scripts/build.js
android_test="./macaca-test-mobile/mobile-app-sample.test.js"
platform=android ${mocha_bin} ${android_test} --reporter macaca-reporter --colors -g "#01"


# SHELL SCRIPT SAMPELS
set -e

# 1: variable
VarFormat() {
    str="hello wrold"
    echo "the source string is "${str}
    echo "the string length is "${#str}
    echo "the 6th to last string is "${str:5}
    echo "the 6th to 8th string is "${str:5:2}
}
# VarFormat


# 2: conditions, file test
FileTest() {
    echo "Please input a filename: "
    read filename
    
    echo "by test\n"
    test -f $filename && echo "the file is ordinary file" || echo "the file is not ordinary file"
    test -d $filename && echo "the file is document folder" || echo "the file is not document folder"
    test -r $filename && echo "the file can read" || echo "the file can not read"
    test -w $filename && echo "the file can write" || echo "the file can not write"
    test -x $filename && echo "the file can executable" || echo "the file can not executable"
    
    echo "by []\n"
    [ -f $filename ] && echo "the file is ordinary file" || echo "the file is not ordinary file"
    [ -d $filename ] && echo "the file is document folder" || echo "the file is not document folder"
    [ -r $filename ] && echo "the file can read" || echo "the file can not read"
    [ -w $filename ] && echo "the file can write" || echo "the file can not write"
    [ -x $filename ] && echo "the file can executable" || echo "the file can not executable"
}
# FileTest


# 3: conditions, number test
NumberTest() {
    echo "Please input two numbers:"
    read num1
    read num2
    
    echo "num1=${num1}"
    echo "num2=${num2}"
    echo "by test\n"
    test $num1 -eq $num2 && echo "num1 == num2" || echo "num1 != num2"
    test $num1 -ne $num2 && echo "num1 != num2" || echo "num1 == num2"
    test $num1 -gt $num2 && echo "num1 > num2" || echo "num1 <= num2"
    test $num1 -lt $num2 && echo "num1 < num2" || echo "num1 >= num2"
    test $num1 -ge $num2 && echo "num1 >= num2" || echo "num1 < num2"
    test $num1 -le $num2 && echo "num1 <= num2" || echo "num1 > num2"
}
# NumberTest


# 4: conditions, if
IfTest() {
    echo "Please input a filename"
    read filename
    if [ -f $filename ];then
        echo "this file is a ordinary file."
    else
        echo "this file is not a ordinary file."
    fi
}
# IfTest


# 5: conditions, if
IfElseTest() {
    echo "Please input your math grades"
    read grades
    
    if [ $grades -gt 100 ] || [ $grades -lt 0 ];then
        echo "Please input the number range in 0 - 100"
    fi
    
    if [ $grades -ge 90 ] && [ $grades -le 100 ];then
        echo "Your grade is excellent."
        elif [ $grades -ge 80 ] && [ $grades -le 89 ];then
        echo "Your grade is good."
        elif [ $grades -ge 70 ] && [ $grades -le 79 ];then
        echo "Your grade is middle."
        elif [ $grades -ge 60 ] && [ $grades -le 69 ];then
        echo "Your grade is passing."
    else
        echo "Your grade is badly."
    fi
}
# IfElseTest


# 6: loop, while
echo "run file: $0"
WhileTest01() {
    i=$1
    i=${i:=3}  # set default value
    while test $i -gt 0; do
        echo $i
        ((i--))
    done
}
# WhileTest01

# 6-01: loop, while
WhileTest02() {
    i=$1
    while ((i>0)); do
        echo $i
        ((i--))
    done
}
# WhileTest02


# 7: loop, for in
ForLoopTest() {
    for i in $(seq 2 8); do
        echo $i
    done
    echo 'node version: '`node -v`
}
# ForLoopTest


# 8: expr
ExprTest01() {
    a=1
    b="str"
    echo $((a>1?8:9))
    ((b!="a")) && echo "str not equal"
}
# ExprTest01


# 9: expr
ExprTest02() {
    num=10
    total=0
    for ((i=0;i<=num;i++))
    do
        ((total+=i))
    done
    echo 'total: '${total}
}
# ExprTest02


# 10: string
StringTest() {
    name='zheng jin'
    echo 'hello ${name}' # print raw string
    echo "hello ${name}"
}
# StringTest


# 11: reg expr
RegExprTest() {
    strlist='testcheck dabletest checktest'
    for str in $strlist
    do
        # if [[ $str =~ test$ ]]
        if [[ ! $str =~ "check$" ]]; then
            echo $str
        fi
    done
}
# RegExprTest


# 12: function, arguments
function MySum() {
    echo "arguments: $1,$2"
    return $(($1+$2))
}
# MySum 5 7
# echo "results: $?"


function cpBackup() {
    if [ ! -f $1 ]; then
        echo "file not found: $1"
        return 99
    fi
    cp $1 ${HOME}/Documents/zj_files_backups/
    echo "copied success"
}
set +e
cpBackup ${HOME}/Documents/vim_test.log
echo "results: $?"

set +x
