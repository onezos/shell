#!/bin/bash
#
 
string="Bigdata process framework is Hadoop,Hadoop is an open source project"
 
function print_tips
{
    echo "********************************************"
    echo "(1) 打印string长度"
    echo "(2) 删除字符串中所有的Hadoop"
    echo "(3) 替换第一个Hadoop为Mapreduce"
    echo "(4) 替换全部Hadoop为Mapreduce"
    echo "********************************************"
}
 
function len_of_string
{
    echo "${#string}"
}
 
function del_hadoop
{
    #  把hadoop替换为空
    echo "${string//Hadoop/}"
 
}
 
function rep_hadoop_mapreduce_first
{
    echo "${string/Hadoop/Mapreduce}"
}
 
function rep_hadoop_mapreduce_all
{
    echo "${string//Hadoop/Mapreduce}"
}
 
while true
do
    echo " 【string=$string】"
    echo
    print_tips
    read -p "Pls input your choice(1|2|3|4|q|Q):" choice
 
    case $choice in
        1)
            len_of_string
            ;;
        2)
            del_hadoop
            ;;
        3)
            rep_hadoop_mapreduce_first
            ;;
        4)
            rep_hadoop_mapreduce_all
            ;;
        q|Q)
            exit
            ;;
        *)
            echo "Error,input only in {1|2|3|4|q|Q}"
            ;;
    esac
done