# Google Drive Downloader Util

I ran into this particular message too many times while trying to download (via code/CLI) large/public datasets from Google Drive, so I made this quick util for my personal use:

```

"Too many users have viewed or downloaded this file recently. Please try accessing the file again later. If the file you are trying to access is particularly large or is shared with many people, it may take up to 24 hours to be able to view or download the file. If you still can't access a file after 24 hours, contact your domain administrator."

```

This is an extension of this helpful Stackoverflow answer: [user sjdonado's answer](https://stackoverflow.com/a/67550427).

## Overview
This repo contains two scripts to bypass this usage limit (which I assume stems from using an unauthenticated user to ping google):

- `download.sh`: Downloads files given a txt list of ID names.
- `get_drive_filenames.py`: Creates id, original-fname pairs, since `download.sh` saves files as `{id}` with no names/extensions. 

---

## Improvements:

Too lazy to do this right now but potential improvements:
Build a general scraper that grabs ID from links, and grabs original fnames straight from the ID during the download process.

---

## Prerequisites

### Install Required Python Packages
```
pip install google-api-python-client google-auth google-auth-oauthlib
```

### Generate OAuth Access Token
1. Go to the [OAuth 2.0 Playground](https://developers.google.com/oauthplayground/).
2. In **Select the Scope**, paste this scope: https://www.googleapis.com/auth/drive.readonly
3. Click **Authorize APIs** and sign in with your Google account.
4. Click **Exchange authorization code for tokens**.
5. Copy the **Access token**,

---

## Usage

### download.sh

```
chmod +x download.sh
./download.sh YOUR_ACCESS_TOKEN file_ids.txt destination_folder
```

Downloads each file listed in `file_ids.txt` to `destination_folder` as `{fileID}`.

---

### get_drive_filenames.py

```
python get_drive_filenames.py YOUR_ACCESS_TOKEN file_ids.txt output_filenames.txt
```

Reads file IDs from `file_ids.txt`, fetches their Drive filenames, and saves `fileID,filename` pairs to `output_filenames.txt`.

---

## Notes

- OAuth access tokens expire quickly; generate a new token as needed.




