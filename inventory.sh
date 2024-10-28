#!/usr/bin/env sh

#set -x

# Directory to save output
out_dir="/home/chelle/working_files"

# Enter output filename
read -r -p "Enter output filename: " out_filename

# Output TSV file
out_file="$out_dir/$out_filename.tsv"

# Start writing the TSV file
printf "File name\tFile path\tFile size\tMIME type\tLast modified date\n" > "$out_file"

# Find all files in the directory and its subdirectories
find . -type f ! -name ".*" ! -name "~*"| while read -r FILE; do
  # Extract file details
  FILE_NAME=$(basename "$FILE")
  FILE_PATH=$(dirname "$FILE")
  ABSOLUTE_PATH=$(realpath "$FILE_PATH")
  FILE_SIZE=$(stat -c%s "$FILE")
  MIME_TYPE=$(file --mime-type -b "$FILE")
  LAST_MODIFIED_DATE=$(stat -c%y "$FILE" | cut -d' ' -f1)

  # Append file details to the TSV file
  printf "%s\t%s\t%s\t%s\t%s\n" "$FILE_NAME" "$ABSOLUTE_PATH" "$FILE_SIZE" "$MIME_TYPE" "$LAST_MODIFIED_DATE" >> "$out_file"
done

echo "Report generated: $out_file"
