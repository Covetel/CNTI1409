find ./ -type f  \( -name "*.pm" -o -name "*.pl" -o -name *.js -o -name "*.t" -o -name "*.tt2" \) \! \( -name "*jquery*" \) | xargs wc -l | sort 
