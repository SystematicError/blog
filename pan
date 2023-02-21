#!/bin/sh

AUTHOR="Systematic Error"
INPUT_DIR="src"
OUTPUT_DIR="posts"

contents=""

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
        --output "$OUTPUT_DIR/$out_name".html \
        "$post"
    
    listing=$(pandoc --template assets/listing.html --variable=link:"$OUTPUT_DIR/$out_name.html" $post)
    contents="$contents$listing"
done

printf -- "$contents" |
    pandoc \
        --standalone \
        --from html \
        --metadata=title:"Blogs" \
        --metadata=author:"$AUTHOR" \
        --template assets/home.html \
        --output index.html

