import os
from mutagen.mp3 import MP3


def seconds_to_minutes(seconds):
    minutes = seconds // 60
    remaining_seconds = seconds % 60
    time_format = "{:02d}:{:02d}".format(minutes, remaining_seconds)
    return time_format


def bytes_to_megabytes(bytes_size):
    megabytes = bytes_size / (1024 ** 2)
    return megabytes


def list_files_and_metadata(folder_path):
    try:
        # Get a list of all files in the folder
        files = os.listdir(folder_path)

        # Loop through the files and print their names, sizes, and lengths for MP3 files
        for file in files:
            file_path = os.path.join(folder_path, file)
            if os.path.isfile(file_path):  # Check if it's a file (not a subdirectory)
                size = os.path.getsize(file_path)

                # Get length for MP3 files
                if file.lower().endswith('.mp3'):
                    audio = MP3(file_path)
                    length_in_seconds = int(audio.info.length)
                    print(f"Song(\n"
                          f"title: '{file[:-4]}',\n"
                          f"description: '{bytes_to_megabytes(size):.2f}Mb    {seconds_to_minutes(length_in_seconds)}mn',\n"
                          f"url: 'assets/music/happy/{file}',\n"
                          f"coverUrl: 'assets/images/hapy.png',\n"
                          f"),\n")
    except FileNotFoundError:
        print(f"The folder '{folder_path}' does not exist.")
    except Exception as e:
        print(f"An error occurred: {e}")


# Replace 'your_folder_path' with the path to the folder containing MP3 files
list_files_and_metadata(r'C:\Users\Hiba Daoud\Desktop\booth\MoodMuse\assets\music\happy')