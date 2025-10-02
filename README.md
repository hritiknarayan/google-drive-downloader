# Google Drive Downloader Util

I ran into this particular message too many times while trying to download (via code/CLI) large/public datasets from Google Drive, so I made this quick util for my personal use:

```

"Too many users have viewed or downloaded this file recently. Please try accessing the file again later. If the file you are trying to access is particularly large or is shared with many people, it may take up to 24 hours to be able to view or download the file. If you still can't access a file after 24 hours, contact your domain administrator."

```

Common solutions include copying files to your own drive, etc. but I have found these to be impractical and inconsistent.

This is an extension of this helpful conversation on StackOverflow: [user sjdonado's answer](https://stackoverflow.com/a/67550427).

## Overview
This repo contains a bash script (and python helper) to bypass this usage limit (which I assume stems from using an unauthenticated user to ping google):


## Improvements:

Too lazy to do this right now but potential improvements:
Build a scraper that takes in a txt file of links, or even better, a folder link and then downloads all the contained files.

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

## Usage

### download.sh

```
chmod +x download.sh
./download.sh YOUR_ACCESS_TOKEN file_ids.txt destination_folder
```

Downloads each file listed in `file_ids.txt` to `destination_folder` as `{fileID}` and then renames them to appropriate filenames as retrieved from Google Drive.






