# Linux shell变量的用法

### 第一部分 变量替换

| 语法                         | 说明                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| ${变量名#匹配规则}           | 从变量<font color='red'>开头</font>开始规则匹配，将符合最<font color='red'>短</font>的数据删除 |
| ${变量名##匹配规则}          | 从变量<font color='red'>开头</font>开始规则匹配，将符合最<font color='red'>长</font>的数据删除 |
| ${变量名%匹配规则}           | 从变量<font color='red'>尾部</font>开始规则匹配，将符合最<font color='red'>短</font>的数据删除 |
| ${变量名%%匹配规则}          | 从变量<font color='red'>尾部</font>开始规则匹配，将符合最<font color='red'>长</font>的数据删除 |
| ${变量名/旧字符串/新字符串}  | 变量内容符合旧字符串，则<font color='red'>第一个</font>旧字符串会被新字符串取代 |
| ${变量名//旧字符串/新字符串} | 变量内容符合旧字符串，则<font color='red'>全部的</font>旧字符串会被新字符串取代 |

示例：

新建`vartest`变量并赋值

```shell
# vartest="I love you, Do you love me"
# echo $vartest 
I love you, Do you love me
```

从变量<font color='red'>开头</font>开始规则匹配，将符合最<font color='red'>短</font>的数据删除

```shell
# var1=${vartest#*ov}
# echo $var1
e you, Do you love me
```

从变量<font color='red'>开头</font>开始规则匹配，将符合最<font color='red'>长</font>的数据删除

```shell
# var2=${vartest##*ov}
# echo $var2
e me
```

从变量<font color='red'>尾部</font>开始规则匹配，将符合最<font color='red'>短</font>的数据删除

```shell
# var3=${vartest%ov*}
# echo $var3
I love you, Do you l
```

从变量<font color='red'>尾部</font>开始规则匹配，将符合最<font color='red'>长</font>的数据删除

```shell
# var4=${vartest%%ov*}
# echo $var4
I l
```

打印出`PATH`内容

```shell
# echo $PATH
/root/.nvm/versions/node/v12.22.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
```

变量内容符合旧字符串，则<font color='red'>第一个</font>旧字符串会被新字符串取代

```shell
# var5=${PATH/bin/BIN}
# echo $var5
/root/.nvm/versions/node/v12.22.1/BIN:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
```

  变量内容符合旧字符串，则<font color='red'>全部的</font>旧字符串会被新字符串取代

```shell
# var6=${PATH//bin/BIN}
# echo $var6
/root/.nvm/versions/node/v12.22.1/BIN:/usr/local/sBIN:/usr/local/BIN:/usr/sBIN:/usr/BIN:/root/BIN
```

##### 附：变量测试的基本用法

![image-20210707100135402](.\img\image-20210707100135402.png)



### 第二部分 字符串处理

#### 1.计算字符串长度

|        |          语法           |             说明             |
| :----: | :---------------------: | :--------------------------: |
| 方法一 |      `${#string}`       |              无              |
| 方法二 | `expr length "$string"` | string有空格，则必须加双引号 |

示例：

```shell
# var1="hello world"
# echo ${#var1}
11
# echo `expr length "$var1"`
11
```

#### 2.获取子串在字符串中的索引位置

| 语法 | `expr index $string substr` |
| ---- | --------------------------- |

示例：

```shell
# var1="quickstart is an app"
# echo `expr index "$var1" start`
6
# echo `expr index "$var1" uniq`
1
# echo `expr index "$var1" cnk`
4
```

<font color='red'>注意：uniq这里返回1，因为这种方式会把uniq切成一个一个字符，寻找字符在字符串中最前面的位置</font>

#### 3.获取子串长度

| 语法 | `expr match $string substr` |
| ---- | --------------------------- |

示例：

```shell
# var1="quickstart is an app"
# echo `expr match "$var1" start`
0
# echo `expr match "$var1" quick`
5
# echo `expr match "$var1" qui.*`
20
```

<font color='red'>注意：start这里返回0，因为这种方式只会从头开始匹配，中间位置的子串都会返回0，qui.*是正则表达式</font>

#### 4.抽取子串

|        |                  语法                   |               说明               |
| :----: | :-------------------------------------: | :------------------------------: |
| 方法一 |          `${string:position}`           |     从string中的position开始     |
| 方法二 |       `${string:position:length}`       | 从position开始，匹配长度为length |
| 方法三 |         `${string: -position}`          |          从右边开始匹配          |
| 方法四 |         `${string:(position)}`          |          从左边开始匹配          |
| 方法五 | `expr substr $string $position $length` | 从position开始，匹配长度为length |

示例：

```shell
# var1="quickstart is an app"
# echo ${var1:5}
start is an app
# echo ${var1:5:5}
start
# echo ${var1: -5:5}
n app
# echo ${var1:(-5)}
n app
# echo `expr substr "$var1" 5 5`
kstar
```

<font color='red'>注意：前四个方法索引下标是从0开始，方法三要在：后面加空格；方法五索引下标从1开始</font>



### 第三部分 练习-字符串处理的完整脚本

#### 需求描述：

> 变量 `string="Bigdata process framework is Hadoop,Hadoop is an open source project"`
>
> 执行脚本后，打印输出string字符串变量，并给出用户以下选项：
>
> - (1)、打印string长度
>
> - (2)、删除字符串中所有的`Hadoop`
>
> - (3)、替换第一个`Hadoop`为`Mapreduce`
>
> - (4)、替换全部`Hadoop`为`Mapreduce`
>
> 用户输入数字1|2|3|4，可以执行对应项中的功能；输入q|Q则退出交互模式  

#### 思路分析：

##### 1.将不同的功能模块划分，并编写函数

- `function print_tips`
- `function len_of_string`
- `function del_hadoop`
- `function rep_hadoop_mapreduce_first`
- `function rep_hadoop_mapreduce_all`

##### 2.实现第一步所定义的功能函数

```shell
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
```

##### 3.程序主流程的设计

example.sh

```shell
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
```



### 第四部分 命令替换

|        | 语法格式   |
| ------ | ---------- |
| 方法一 | `command`  |
| 方法二 | $(command) |

#### 示例1： 获取系统的所有用户并输出

使用 cut 对 : 进行切割，获取第一个用户的名字

> cut命令参数解释：
>
> > -d 指定分割符为":", 默认分隔符为tab
> > -f 指定分隔后的第几个字段

命令实现

```shell
# cat /etc/passwd | cut -d ":" -f 1
root
bin
daemon
adm
lp
sync
shutdown
halt
mail
operator
games
ftp
nobody
systemd-network
dbus
polkitd
sshd
postfix
chrony
nginx
apache
mysql
ftpuser
```

shell代码实现: 

sys_user.sh

```
#!/bin/bash
#
i=1
for user in `cat /etc/passwd | cut -d ":" -f 1`
do
    echo "This is $i user: $user"
    i=$(($i + 1))
done
```

#### 示例2： 根据系统时间计算今年或明年

> date时间输出
> date是Linux系统里自带的一个系统命令，用来显示当前的系统时间

`date`命令举例

```shell
# date
Wed Jul  7 12:33:05 +08 2021
# date "+%Y-%m-%d" 
2021-07-07
# date "+%Y_%m_%d %H:%M:%S" 
2021_07_07 12:38:46
```

`shell`中计算使用`$(())`

```shell
# echo "$((20+30))"
50
```

打印出今年的年份

```shell
# echo "this is $(date +%Y) year"
this is 2021 year
```

打印出明年的年份

```shell
# echo "this is $(( $(date +%Y) + 1)) year"
this is 2022 year
```

总结：
”``“和$()两者是等价的，但推荐初学者使用$()，易于掌握；缺点是极少数的UNIX可能不识别。
$(())主要用来进行整数运算，包括加减乘除，引用变量前面可以加$，也可以不加$。shell中的语言要求并不是规范，例如：

```shell
# num1=50
# num2=20
# echo "$(($num1 + $num2))"
70
# echo "$((num1 + num2))"
70
# echo "((num1 + num2))"
((num1 + num2))
```

#### 示例3： 根据系统时间获取今年还剩下多少星期，已经过了多少星期

> date时间输出
> %j   day of year (001..366)

今天是今年的第多少天

```shell
# date +%j
188
```

根据系统时间获取今年还剩下多少星期，已经过了多少星期　　

```shell
# echo "this year have passed $(date +%j) days"
this year have passed 188 days
# echo "this year have passed $(($(date +%j) / 7)) weeks"
this year have passed 26 weeks
```

今年还剩余多少天，多少星期　　

```shell
# echo "there is $((365 - $(date +%j))) days before new year"
there is 177 days before new year
# echo "there is $(((365 - $(date +%j)) / 7 )) weeks before new year"
there is 25 weeks before new year
```





