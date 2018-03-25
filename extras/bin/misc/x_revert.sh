#!/bin/bash
cat $1 |\

perl -pe "s/hx/ĥ/g" |\
perl -pe "s/Hx/Ĥ/g" |\

perl -pe "s/sx/ŝ/g" |\
perl -pe "s/Sx/Ŝ/g" |\

perl -pe "s/gx/ĝ/g" |\
perl -pe "s/Gx/Ĝ/g" |\

perl -pe "s/cx/ĉ/g" |\
perl -pe "s/Cx/Ĉ/g" |\

perl -pe "s/jx/ĵ/g" |\
perl -pe "s/Jx/Ĵ/g" |\

perl -pe "s/ux/ŭ/g" |\
perl -pe "s/Ux/Ŭ/g" |\

cat
