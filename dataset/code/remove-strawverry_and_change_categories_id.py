import json

def change_category_and_modify_filenames(input_file, output_file):
    with open(input_file, 'r') as f:
        data = json.load(f)

    # Change category_id of images with category_id 2 to 1
    for entry in data['annotations']:
        if entry['category_id'] == 3:
            entry['category_id'] = 2
        if entry['category_id'] == 4:
            entry['category_id'] = 3
        elif entry['category_id'] == 5:
            entry['category_id'] = 4
        elif entry['category_id'] == 6:
            entry['category_id'] = 5
    
    # prefix = "..\\Users\\Hiba Daoud\\Desktop\\P2M\\dataset\\"
    prefix = "..\\"
    for img_entry in data['images']:
        # img_entry['file_name'] = img_entry['file_name'].replace(prefix, '').split('train\\', 1)[-1]
        img_entry['file_name'] = img_entry['file_name'].replace(prefix, '')


    # Save modified JSON to output file
    with open(output_file, 'w') as f:
        json.dump(data, f, indent=4)

# Example usage:
input_file = r"C:\Users\Hiba Daoud\Desktop\P2M\dataset\unknown\unknown.json"
output_file = r"C:\Users\Hiba Daoud\Desktop\P2M\dataset\unknown\unknown.json"
change_category_and_modify_filenames(input_file, output_file)
