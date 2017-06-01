BEGIN { if( PID=="") PID="." ; else PID="."PID }
/^ *[0-9]+[.] http/  { if($0 ~ /[.](jpeg|jpg|mpeg|mpg|mp4|mp3|zip|gz|7z)/ ) next;
    if($0 ~ /(youtube|vimeo|dailymotion)/) next; 
    sub("^ *[0-9]+[.] ",""); print >> "lynx"PID".newurls."ID ; next}
/^ *[*] \[[0-9]+\]/ { next }
{ gsub("\[[0-9]+\] *alternate","") }


/^   Visible [lL]inks/ || /^  Liens visibles/  { inlinks==1}
inlinks != 1 { gsub("\\[[0-9]+\\]",""); 
    print >> "lynx"PID".text."ID ; }
