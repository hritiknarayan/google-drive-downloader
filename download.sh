#!/bin/bash

ACCESS_TOKEN=$1
FILE_IDS_PATH=$2
DESTINATION_FOLDER=$3

if [[ -z "$ACCESS_TOKEN" || -z "$FILE_IDS_PATH" || -z "$DESTINATION_FOLDER" ]]; then
    echo "Usage: $0 ACCESS_TOKEN FILE_IDS_TEXT_FILE DESTINATION_FOLDER"
    exit 1
fi

if [[ ! -f "$FILE_IDS_PATH" ]]; then
    echo "File IDs input file not found: $FILE_IDS_PATH"
    exit 1
fi

mkdir -p "$DESTINATION_FOLDER"

while IFS= read -r FILE_ID || [[ -n "$FILE_ID" ]]; do
    # Skip empty lines or lines with just spaces
    if [[ -z "${FILE_ID// }" ]]; then
        continue
    fi
    echo "Downloading file ID $FILE_ID ..."
    curl -L -H "Authorization: Bearer $ACCESS_TOKEN" \
         "https://www.googleapis.com/drive/v3/files/$FILE_ID?alt=media" \
         -o "$DESTINATION_FOLDER/${FILE_ID}"
done < "$FILE_IDS_PATH"

echo "Downloads complete."

python get_drive_filenames.py "$ACCESS_TOKEN" "$FILE_IDS_PATH" "${DESTINATION_FOLDER}/filenames.txt"

while IFS=',' read -r fid realname; do
    src="${DESTINATION_FOLDER}/${fid}"
    dest="${DESTINATION_FOLDER}/${realname}"

    if [[ -f "$src" ]]; then
        echo "Renaming $src to $dest"
        mv -n "$src" "$dest"
    else
        echo "File not found: $src"
    fi
done < "${DESTINATION_FOLDER}/filenames.txt"

echo "All files renamed."

