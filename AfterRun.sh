export Word2vecDIR=/Volumes/GregWorkD/word2vec

sh ../CreateTechCorpus.sh
gawk ' ARGIND == 1 { $1=$2=""; t[$0]++; next } {$1=$2=""; if(t[$0]-- == 1)  print }' *.Tech.nostop *.Tech.nostop |tr '_/' '\012\012' | gawk 'NF {  gsub("[^[:alpha:][:digit:]_ '"'"']"," "); gsub(" +"," ");   print }' | egrep -v http  |egrep -v ' (com|www|org) '  | gawk '{ gsub(" (.|..) "," "); print }' |  gawk 'NF { gsub(" +"," NEUT "); $1=""; print }' | gawk 'NF' | tr -s ' '  > newNEUT

gawk '{ gsub(" NEUT",""); gsub(" +"," "); print }' newNEUT | sort | uniq -c | sort -nr > new.NEUT.phrases.sort


# cat /Volumes/GregWorkD/Crawler/*/*.Tech.nostop | gawk '{ $1=$2=""; print }' |tr '_/' '\012\012' | gawk 'NF {  gsub("[^[:alpha:][:digit:]_ '"'"']"," "); gsub(" +"," ");   print }' | egrep -v http  |egrep -v ' (com|www|org) '  | gawk '{ gsub(" (.|..) "," "); print }'  | tr '\012' ' ' | tr -s ' ' | head -c 1000000000 > ../all.w2v.text.1G


cat ../all.w2v.text.100M | cat newNEUT - | tr -s '\012' ' ' | tr -s ' ' > w2v.text.NEUT.all

$Word2vecDIR/trunk/word2vec -train w2v.text.NEUT.all -output vectors.bin.all.including -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

ln -s vectors.bin.all.including newNEUT.bin

sh -x ../loop3.sh NEUT
