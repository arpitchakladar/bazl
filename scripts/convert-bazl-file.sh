#!/bin/sh
file_name=$(mktemp /tmp/bazl-file-name.XXX)
file_desc=$(mktemp /tmp/bazl-file.XXX)
file_content=$(mktemp /tmp/bazl-file-content.XXX)

cat $1 > $file_content

file_size=$(stat -c%s "$1")
sec_count=$((file_size / 512))

if [ $file_size -gt $((sec_count * 512)) ]
then
	sec_count=$((sec_count + 1))
fi

echo $2 > $file_name
truncate -s 128 $file_name
cat $file_name > $file_desc
printf '%b' $(printf '\\%03o' $sec_count) >> $file_desc
printf '%b' $(printf '\\%03o' 1) >> $file_desc
truncate -s 512 $file_desc
cat $file_desc > $1
cat $file_content >> $1
truncate -s $(((sec_count + 1) * 512)) $1

rm $file_name
rm $file_desc
