import sys
from googleapiclient.discovery import build
from google.oauth2.credentials import Credentials

def get_filenames(service, file_ids):
    filenames = {}
    for file_id in file_ids:
        try:
            file = service.files().get(fileId=file_id, fields='name').execute()
            filenames[file_id] = file.get('name', 'UNKNOWN')
        except Exception as e:
            filenames[file_id] = f"ERROR: {str(e)}"
    return filenames

def main():
    if len(sys.argv) != 4:
        print("Usage: python get_drive_filenames.py <ACCESS_TOKEN> <INPUT_FILE_IDS.txt> <OUTPUT_FILE.txt>")
        sys.exit(1)

    access_token, input_file_path, output_file_path = sys.argv[1], sys.argv[2], sys.argv[3]

    try:
        with open(input_file_path, "r") as f:
            file_ids = [line.strip() for line in f if line.strip()]
    except FileNotFoundError:
        print(f"Input file not found: {input_file_path}")
        sys.exit(1)

    creds = Credentials(token=access_token)
    service = build('drive', 'v3', credentials=creds)

    filenames = get_filenames(service, file_ids)

    try:
        with open(output_file_path, "w") as out_file:
            for fid, fname in filenames.items():
                out_file.write(f"{fid},{fname}\n")
        print(f"Saved file ID and name pairs to {output_file_path}")
    except Exception as e:
        print(f"Failed to write output file: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
