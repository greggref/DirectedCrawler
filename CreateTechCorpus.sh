BASEDIR=/Volumes/GregWorkD/Crawl

BASE="${PWD##*/}"  # http://stackoverflow.com/questions/1371261/get-current-directory-name-without-full-path-in-bash-script

# First calculate if any sentences inthe Good Text (the domain corpus) appear more than once

gzip -cd GoodText/* | tr -s ' ' | sort -T . | uniq -c | gawk '$1>1 {gsub("^ *[0-9]+ *",""); print }' > dupSent
cp dupSent dupSent2 ; gzip -f dupSent2

# Then eliminate any duplicate sentence from the Domain text

CNT=0; for i in dupSent2.gz GoodText/*  ; do CNT=`expr $CNT + 1 ` ;  gzip -cd $i | tr -s ' ' | gawk --assign=DOCNO=$CNT 'ARGIND==1{dup[$0]++;next}BEGIN{SENT=DOCNO*100000}{if(DOCNO>1 && $0 in dup) next ; print DOCNO,SENT++,$0 }' dupSent - ; done  | tr  '\015' ' ' > $BASE.Tech


for i in $BASE.Tech  ; do gawk -f $BASEDIR/StopWordsAsUnderscore.awk $i | gawk '{ print tolower($0) }' | tr -s '_' > $i.nostop ; done

for i in *.nostop ; do gawk -f $BASEDIR/porter.awk $i > $i.stemmed ; done

for i in *.nostop.stemmed ; do  gawk '/javascript:/ {next } {gsub("<[^>]*>",""); gsub("http _ / /( [^ ]+ /)* [^ ]+ "," ") ;  gsub("_+","_"); for(i=3;i<=NF;i++) if(($i ~ /[^-A-Za-z_0-9.]/) || (!($i ~ /[A-Za-z_]/))) $i="" ; print }'  $i | gawk 'NF>2' | egrep '[A-Za-z]' | tr -s ' _' > $i.onlyalph ; done
