#!/bin/bash

if [ $# -lt 1 ]
then
  exit 1
fi

curl -s -L "http://thesaurus.reference.com/search?q="$1 | ruby -rnokogiri -e "Nokogiri::HTML(STDIN.read).search('.relevancy-list').search('.text').each {|x| puts x.text}"


