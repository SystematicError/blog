#!/bin/sh

AUTHOR="Systematic Error"
INPUT_DIR="src"
OUTPUT_DIR="posts"

contents=""

cp assets/home.html index.html

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

    pandoc --template assets/listing.html --variable=link:"$OUTPUT_DIR/$out_name.html" $post | \
        pandoc \
            --from html \
            --standalone \
            --metadata=title:"Blogs" \
            --metadata=author:"$AUTHOR" \
            --template index.html \
            --output index.html
done

printf "" | \
    pandoc \
        --metadata=title:"Blogs" \
        --template index.html \
        --output index.html

