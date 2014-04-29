#!/bin/sh
#tsvfmt - TSV Formatter
#Author: Donald L. Merand
#----------
#Takes a TSV file, and outputs a text-only representation of the table,
#+ justified to the max width of each column. Basically, you use it when 
#+ you want to "preview" a TSV file, or print it prettily.
#----------
#Accepts standard input, or piped/redirected files
#----------

#set this to whatever you want to show up between columns
field_separator=" | "
tmp_filename=tsv_${RANDOM}_tmp.txt
tmp_widths=tsv_${RANDOM}_widths.txt


#take file input, or standard input, and redirect to a temporary file
#also, convert mac line-endings to UNIX ones
perl -p -e 's/(:?\r\n?|\n)/\n/g' > "$tmp_filename"

#now we're going to extract max record widths from the file
#send the contents to awk
cat "$tmp_filename" |
awk '
BEGIN {  
  FS="\t"
  max_nf = 0 
}
{
  for (i=1; i<=NF; i++) {
    #set the max-length to this field width if it is the biggest
    if (max_length[i] < length($i)) { max_length[i] = length($i) }
  }
  if (max_nf < NF) { max_nf = NF }
}
END {
  for (i=1; i<=max_nf; i++) {
    printf("%s\t", max_length[i])
  }
  printf("\n")
}
' > "$tmp_widths" #store widths in a TSV temp file

#now start over by sending our temp file to awk. THIS time we have a widths
#+file to read which gives us the maximum width for each column
cat "$tmp_filename" |
awk -v field_sep="$field_separator" '
BEGIN {
  FS="\t"
  #read the max width of each column
  getline w < "'"$tmp_widths"'"
  #split widths into an array
  split(w, widths, "\t")
  #get the max number of fields
  max_nf = 0
  for (i in widths) { max_nf++ }
}
{
  printf("%s", field_sep)
  for (i=1; i<max_nf; i++) {
    printf("%-*s%s", widths[i], $i, field_sep)
  }
  printf("\n")
}
'
#now we're done. remove temp files
rm "$tmp_filename" "$tmp_widths"
