Word2vecDIR=/Volumes/GregWorkD/word2vec
cat - >> ../blacklist <<EOF
using
isn't
we'll
they're
let's
i'm
i'll
aren't
we're
we've
isn
called
click
comments
due
lLinks
nbsp
order
people
posted
subclass
think
usually
a
able
ampersand
and
aren
aren<E2><80><99>t
as
b
being
biliary
but
c
called
cannont
cdata
class
come
commons
couldn
d
del
didn
div
doesn
doesn<E2><80><99>t
don't
donn
donn<C3><A9>es
donot
due
e
f
firefox
first
for
g
gif
gmail
going
google+
h
hadn
happen
hasn
here
hi
his
how
href
htm
i
if
img
in
included
info
it
jpg
k
l
less
license
like
m
make
n
name=&quot
nbsp
need
next
nofollow
o
one
out
p
quot
r
rated
re's
realize
ref
referrer
rel
require
s
see
self
sharealike
she
shouldn
simplest
span
specific
src
stop
strong
style
sub
sup
sure
t
take
that
the
they
think
third
this
true
try
two
typically
ul
use
usually
utilise
v
vous
vs
want
wasn
wasn't
we
week
well
weren
what
when
wouldn
wouldn't
y
year
you
you've
you<E2><80><99>d
EOF

NAME=$1
gawk --assign=NAME=$NAME 'BEGIN{print NAME ; print "EXIT"}' | $Word2vecDIR/trunk/distance newNEUT.bin | fgrep -v "'" | gawk '/^--/ {fl=1}fl==1 && /^ / { print $1 }' |gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist - > 3.w2v..in.$NAME
if [ -s MustHaves ] 
then 
   cat MustHaves >> 3.w2v..in.$NAME
fi
cat 3.w2v..in.$NAME | gawk '{t[$0]++}END {for(i in t) s=s" "i ; gsub("^ *","",s); gsub(" *$","",s); print s ;  print "EXIT"}' | $Word2vecDIR/trunk/distance newNEUT.bin | fgrep -v "'" | gawk 'NF==2 && $2>0 { print $1 }'| gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' | gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist -  >3.w2v..in.2
cat 3.w2v..in.$NAME 3.w2v..in.2  | gawk '{t[$0]++}END {for(i in t) s=s" "i ; gsub("^ *","",s); gsub(" *$","",s); print s ;  print "EXIT"}' | $Word2vecDIR/trunk/distance newNEUT.bin | fgrep -v "'" | gawk 'NF==2 && $2>0 { print $1 }'| gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' | gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist -  >3.w2v..in.3
cat 3.w2v..in.$NAME 3.w2v..in.2 3.w2v..in.3  | gawk '{t[$0]++}END {for(i in t) s=s" "i ; gsub("^ *","",s); gsub(" *$","",s); print s ;  print "EXIT"}' | $Word2vecDIR/trunk/distance newNEUT.bin | fgrep -v "'" | gawk 'NF==2 && $2>0 { print $1 }'| gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' | gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist -  >3.w2v..in.4
cat 3.w2v..in.$NAME 3.w2v..in.2 3.w2v..in.3  | gawk '{t[$0]++}END {for(i in t) s=s" "i ; gsub("^ *","",s); gsub(" *$","",s); print s ;  print "EXIT"}' | $Word2vecDIR/trunk/distance newNEUT.bin | fgrep -v "'" | gawk 'NF==2 && $2>0 { print $1 }'| gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' | gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist -  >3.w2v..in.4
cat 3.w2v..in.$NAME 3.w2v..in.2 3.w2v..in.3 3.w2v..in.4  | gawk '{t[$0]++}END {for(i in t) s=s" "i ; gsub("^ *","",s); gsub(" *$","",s); print s ;  print "EXIT"}' | $Word2vecDIR/trunk/distance newNEUT.bin | fgrep -v "'" | gawk 'NF==2 && $2>0 { print $1 }'| gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' | gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist -  >3.w2v..in.5
cat 3.w2v..in.$NAME 3.w2v..in.2 3.w2v..in.3 3.w2v..in.4 3.w2v..in.5 | gawk '{t[$0]++}END {for(i in t) s=s" "i ; gsub("^ *","",s); gsub(" *$","",s); print s ;  print "EXIT"}' | $Word2vecDIR/trunk/distance newNEUT.bin | fgrep -v "'" | gawk 'NF==2 && $2>0 { print $1 }'| gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' | gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist -  >3.w2v..in.6.$NAME
cat 3.w2v..in.$NAME 3.w2v..in.2 3.w2v..in.3 3.w2v..in.4 3.w2v..in.5 3.w2v..in.6.$NAME | sort -u| gawk -f /Volumes/GregWorkD/Crawler/StopWordsAsUnderscore.awk | gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist -  >$NAME.3.w2v..cand
gawk --assign=NAME=$NAME '{print $0" "NAME}END{print "EXIT"}' $NAME.3.w2v..cand | $Word2vecDIR/trunk/distance newNEUT.bin | fgrep -v "'" | gawk '/^ / && $2 > 0.3 { if(cnt++ <= 10) print $1 } /^---/ {cnt=0}' | cat - $NAME.3.w2v..cand | sort -u |  gawk 'ARGIND==1 { t[$0]++; next } length($0)<=1 || $0 in t { next} { print}' ../blacklist -  > 3.w2v..close25.$NAME


gawk ' length($1)>2'  3.w2v..close25.NEUT > w2v.close25.NEUT.3ormore
gawk -f /Volumes/GregWorkD/Crawl/StopWordsAsUnderscore.awk w2v.close25.NEUT.3ormore > w2v.close25.NEUT.3ormore.nostop
# gawk '{ gsub(" NEUT",""); gsub(" +"," "); print }' newNEUT | sort | uniq -c | sort -nr > new.NEUT.phrases.sort.3
gawk 'ARGIND==1 { t[$0]++ ; next  } NF <= 7{for(i=2;i<=NF;i++) if($i in t) { print ; next}   } '  w2v.close25.NEUT.3ormore.nostop new.NEUT.phrases.sort > w2v.close25.NEUT.3ormore.vocab.3
# fgrep -wf w2v.close25.NEUT.3ormore.nostop | gawk '/ [^ ] / || / com / || / [^ ]$/ || / www / || NF>5 {next} {print}' | sort | uniq -c | sort -nr > w2v.close25.NEUT.3ormore.vocab
