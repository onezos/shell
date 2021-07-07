#!/bin/bash
#
i=1
for user in `cat /etc/passwd | cut -d ":" -f 1`
do
    echo "This is $i user: $user"
    i=$(($i + 1))
done