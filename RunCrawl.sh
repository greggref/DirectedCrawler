#!/bin/bash                                                                                                          
BASEDIR=/Volumes/GregWorkD/Crawl
# need commands: gawk gsort tail gtimeout lynx 
# local AWk programs: sentencize.awk quickEnglish.awk CountEnglish.awk delynx.awk

# script to do a targeted crawl. iIt expects two files "SeedUrls", a list of URLs and  "Patterns," aset of filter words.
# First, create a seed urls file and name it, SeedUrls (the dmoz script does these two steps)
# and then create a filter patterns or key words file and name it  Patterns
# Then run this shell Run.sh in that directory
# CALL: sh ../Run.sh

MAXGOODFILES="$1"

if [ "$MAXGOODFILES" = "" ]
then
   MAXGOODFILES=2000   # default number of pages to crawl
fi

                                                                                              
mkdir -p  GoodText Noise URLS

if [ -s seenDomains ] 
then 
 echo "" > /dev/null
else 
# cp SeedUrls ToCrawl
 gawk '{  sub("https:","http:"); sub("[#].*$","");  print }' SeedUrls > ToCrawl
 echo -n "" > SeenUrls
 cp SeenUrls seenDomains
fi

# counts the number of files downloaded
counter=1
if [ -s NegativeFilter ] 
then 
   echo "Negative Filter"
   cat NegativeFilter
else
   echo -n "" > NegativeFilter
fi

# While the file 'ToCrawl' exists and is not empty
while [  -s ToCrawl ]
do
counter=`expr $counter + 1`
# pick off the first URL from 'ToCrawl' as the next page to crawl
   head -1 ToCrawl  > NewUrl ;

  modcount=`expr $counter % 100 `
  if [ $modcount -eq 0 ]         # every 100 pages, mix up the ToCrawl file (sort -R) 
  then
   tail -n +2 ToCrawl | gsort -R | uniq > tmp.$counter ; mv tmp.$counter ToCrawl
  else
   tail -n +2 ToCrawl | uniq  > tmp.$counter ; mv tmp.$counter ToCrawl
  fi
    
  # Check whether we visited this domain too often
  MAXFROMDOMAIN=100

  gawk '{ gsub("^.*://(www.)?",""); gsub("/.*",""); print }' NewUrl > tmpDomain
  TMPCNT=`fgrep -f tmpDomain seenDomains | wc -l `

  if [ $TMPCNT -lt $MAXFROMDOMAIN ]
  then 

  fgrep -f NewUrl SeenUrls      # see if we have seen this Url                                                           
  if [ $? -gt 0 ]               # if fgrep worked then $? equals 0                                                       
  then
   cat NewUrl >> SeenUrls 
   cat NewUrl > URLS/url.$counter
   # fetch the new URL
   gtimeout 60 lynx -connect_timeout=3 --dump "`cat NewUrl`" | head -c 1000000 > lynx.$$.$counter

   # delynx.awk will extract text and new links from the fetched page
   cat lynx.$$.$counter | gawk  --assign=ID=$counter --assign=PID=$$ -f $BASEDIR/delynx.awk > /dev/null 

   # check if output is English enough

   rm -fr text.$counter.english
   cat lynx.$$.text.$counter | gawk -f $BASEDIR/CountEnglish.awk | gawk '$1 > .8 * $2 { print "XXXXX"}' > text.$counter.english 
   cat lynx.$$.text.$counter | gawk -f $BASEDIR/quickEnglish.awk |  gawk -f $BASEDIR/sentencize.awk | gawk 'NF>4 && NF <100' > text.$counter

   egrep -i -f Patterns text.$counter   # search fetched text for some filter Pattern
   GoodPatternFound=$?            # if fgrep worked then $? equals 0  
   egrep -i -f NegativeFilter text.$counter # search fetched text for some negative patterns 
   NegativeFound=$?            # if fgrep worked then $? equals 0  
   if [ $GoodPatternFound -eq 0 ] && [ -s text.$counter.english ] && [ $NegativeFound -ne 0 ] # if at least one pattern found and English enough
   then      # keep the Good text and new URLS to crawl
      mv text.$counter  GoodText/text.$counter ; gzip -f  GoodText/text.$counter &
      cat tmpDomain>> seenDomains 
      if [  -s lynx.$$.newurls.$counter ] ; then gawk  '{ sub("https:","http:"); sub("[#].*$",""); print }' lynx.$$.newurls.$counter >> ToCrawl ; fi
   else     # or send the text to the Noise directory
      mv text.$counter  Noise/text.$counter ; gzip -f Noise/text.$counter &
   fi

  rm -fr lynx.$$.* text.$counter.english
  fi
  fi


# after $MAXGOODFILES good files found, stop by removing ToCrawl file
NbGoodFiles=`ls GoodText/ | wc -l `

if [ $NbGoodFiles -gt $MAXGOODFILES ]
then
    mv ToCrawl ToCrawl.$MAXGOODFILES.Seen
fi


done # while loop Urls to Crawl                                                                                        

