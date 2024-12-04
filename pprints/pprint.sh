#!/bin/bash

filenumber=$(cat ~/pprints/.counter.txt)
touch ~/pprints/file$filenumber

ls ~/pprints > ~/pprints/.wordcounts.txt
wordc=$(wc -l < ~/pprints/.wordcounts.txt)

if [[ $wordc -ge 100 ]]; then
    echo "The process prints folder is full (99 items). Wanna delete all the prints and restart? (y/n):"
    while true; do
        read -rsn1 key
        if [[ $key == 'y' ]]; then
            mv ~/pprints/.pprint.sh ~
            rm -r ~/pprints
            mkdir ~/pprints
            mv ~/.pprint.sh ~/pprints
            echo 0 > ~/pprints/.counter.txt
            touch ~/pprints/.wordcounts.txt
            break
        elif [[ $key == 'n' ]]; then
            exit 0
        fi
    done
fi

date > ~/pprints/file$filenumber
ps aux >> ~/pprints/file$filenumber

nextnumber=$((filenumber + 1))
echo $nextnumber > ~/pprints/.counter.txt

