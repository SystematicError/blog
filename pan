#!/bin/sh

AUTHOR="Systematic Error"
INPUT_DIR="src"
OUTPUT_DIR="posts"

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
        --output "$OUTPUT_DIR"/"$out_name".html \
        "$post"
done

