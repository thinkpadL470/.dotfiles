# while read B
# do
#   [ $B -lt 1024 ] && printf '%s\n' "${B}B" && break
#   KB=$(((B+512)/1024))
#   [ $KB -lt 1024 ] && printf '%s\n' "${KB}KB" && break
#   MB=$(((KB+512)/1024))
#   [ $MB -lt 1024 ] && printf '%s\n' "${MB}MB" && break
#   GB=$(((MB+512)/1024))
#   [ $GB -lt 1024 ] && printf '%s\n' "${GB}GB" && break
#   printf '%s\n' "$(((GB+512)/1024))TB"
# done
#
# awk '
#     function human(x) {
#         if (x<1000) {return x} else {x/=1024}
#         s="kMGTEPZY";
#         while (x>=1000 && length(s)>1)
#             {x/=1024; s=substr(s,2)}
#         return int(x+0.5) substr(s,1,1)
#     }
#     {sub(/^[0-9]+/, human($1)); print}'
awk 'function human(x) {
         s=" B   KB MB GB TB EB PB YB ZiB"
         while (x>=1024 && length(s)>1) 
               {x/=1024; s=substr(s,5)}
         s=substr(s,1,4)
         xf=(s==" B  ")?"%5d   ":"%8.2f"
         return sprintf( xf"%s", x, s)
      }
      {gsub(/^[0-9]+/, human($1)); print}'