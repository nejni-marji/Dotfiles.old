#!/bin/bash
cat $1 |\
#echo "$@" |\

perl -pe "s/(?<=h)h/x/g" |\
perl -pe "s/(?<=H)h/x/g" |\

perl -pe "s/(?<=s)h/x/g" |\
perl -pe "s/(?<=S)h/x/g" |\

perl -pe "s/(?<=g)h/x/g" |\
perl -pe "s/(?<=G)h/x/g" |\

perl -pe "s/(?<=c)h/x/g" |\
perl -pe "s/(?<=C)h/x/g" |\

perl -pe "s/(?<=j)h/x/g" |\
perl -pe "s/(?<=J)h/x/g" |\

#perl -pe "s/(?<=u)h/\1x/g" |\
#perl -pe "s/(?<=U)h/\1x/g" |\

perl -pe "s/(?<=[aeiou])u/\1ux/g" |\
perl -pe "s/(?<=[aeiou])U/\1Ux/g" |\

cat
