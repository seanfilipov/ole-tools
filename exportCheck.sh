#!/bin/bash

VUFIND=/vufind
SCRIPTS_DIR=${VUFIND}/scripts

echo "Positional Parameters"
echo '$0 = ' $0
echo '$1 = ' $1
echo '$2 = ' $2
echo '$3 = ' $3


if [ $# -gt 0 ]; then
    echo "Your command line contains $# arguments"
else
    echo "Your command line contains no arguments"
fi

#if [ "$1" != "" ]; then
#    echo "Positional parameter 1 contains something"
#else
#    echo "Positional parameter 1 is empty"
#fi

mysql -ureport -preport -holereport01  ole -e "select bib_id from ole_ds_bib_t where staff_only = 'N'" >  $SCRIPTS_DIR/oleDatabase.txt


#yaz-marcdump $1*.mrc | grep -i '^001 ' | sed 's/^....//'> $SCRIPTS_DIR/exportFiles.txt

yaz-marcdump $1*.mrc | sed -n -e '/^001 /s/^001 //p' > $SCRIPTS_DIR/exportFiles.txt

#awk 'FNR==NR{a[$1]++;next}!a[$1]' /vufind/scripts/oleDatabase.txt /vufind/scripts/exportFiles.txt > /vufind/scripts/diffFile.txt
awk 'FNR==NR{a[$1]++;next}!a[$1]' $SCRIPTS_DIR/exportFiles.txt   $SCRIPTS_DIR/oleDatabase.txt  > $SCRIPTS_DIR/diffFile.txt

wc -l $SCRIPTS_DIR/diffFile.txt  
less  $SCRIPTS_DIR/diffFile.txt
