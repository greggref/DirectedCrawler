for i in $1 ; 
do  mkdir -p $i ;  
lynx --dump "https://www.bing.com/search?q=%22"$i"%22+language%3Aen" > toto.$$ ;  egrep '^ *[0-9]+[.] ' toto.$$ | grep -v bing | egrep -v microsoft | grep http | gawk '{gsub("^.* ",""); print }' > $i/SeedUrls ; 
for j in vocabulary terms diagnosis symptoms ;
do 
lynx --dump "https://www.bing.com/search?q=%22"$i"%22+$j+language%3Aen" > toto.$$ ;  egrep '^ *[0-9]+[.] ' toto.$$ | grep -v bing | egrep -v microsoft | grep http | gawk '{gsub("^.* ",""); print }' >> $i/SeedUrls ;
done
lynx --dump "https://www.bing.com/search?q=%22"$i"%22+$j+language%3Aen&start=20" > toto.$$ ; egrep '^ *[0-9]+[.] ' toto.$$ | grep -v bing | egrep -v microsoft |grep http | gawk '{gsub("^.* ",""); print }' >> $i/SeedUrls ; 
echo $i | gawk '{ print $0; print tolower($0); gsub("[-_]"," "); print $0 ; print tolower($0) }' | sort -u > $i/Patterns; 
echo $i ;
rm toto.$$
done
