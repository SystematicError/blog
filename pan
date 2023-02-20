#!/bin/sh

AUTHOR="Systematic Error"
INPUT_DIR="src"
OUTPUT_DIR="posts"

contents=""

for post in "$INPUT_DIR"/*; do
    out_name=${post##*/}
    out_name=${out_name%.*}

    pandoc \
        --from markdown \
        --to html \
        --standalone \
        --table-of-contents \
        --number-sections \
        --no-highlight \
        --metadata=author:"$AUTHOR" \
        --template assets/post.html \
        --output "$OUTPUT_DIR"/"$out_name".html \
        "$post"

    contents="$contents\n- [$out_name]($OUTPUT_DIR/$out_name.html)"
done

printf -- "$contents" | \
    pandoc \
    --from markdown \
    --to html \
    --standalone \
    --metadata=title:"Blogs" \
    --metadata=author:"$AUTHOR" \
    --template assets/home.html \
    --output index.html
