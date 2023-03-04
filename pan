#!/bin/sh

AUTHOR="Systematic Error"
INPUT_DIR="src"
OUTPUT_DIR="posts"

dates=""

for post in "$INPUT_DIR"/*; do
    out_name=${post##*/}
    out_name=${out_name%.*}
    
    pandoc \
        --standalone \
        --table-of-contents \
        --number-sections \
        --no-highlight \
        --metadata=author:"$AUTHOR" \
        --template assets/post.html \
        --output "$OUTPUT_DIR/$out_name.html" \
        "$post"
   
    date=$(pandoc --template assets/date.txt --variable=post_name:"$out_name" "$post")
    dates="$dates$date\n"
done

dates=$(printf -- "$dates" | sort -n -r)
listings=""

while IFS= read -r post; do
    post=${post##[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] }

    listing=$(pandoc --template assets/listing.html --variable=link:"$OUTPUT_DIR/$post.html" "$INPUT_DIR/$post.md")
    listings="$listings$listing"
done << EOF
$dates
EOF

printf -- "$listings" |
    pandoc \
        --standalone \
        --from html \
        --metadata=title:"Blogs" \
        --metadata=author:"$AUTHOR" \
        --template assets/home.html \
        --output index.html

