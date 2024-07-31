
import json

def get_filenames_with_categories(json_file):
    with open(json_file, 'r') as f:
        data = json.load(f)

    filenames_category_1 = set()
    filenames_category_2 = set()

    # Iterate through the annotations and select filenames with category ID 1 and 2
    for entry in data['annotations']:
        image_id = entry['image_id']
        for img_entry in data['images']:
            if img_entry['id'] == image_id:
                filename = img_entry['file_name']
                if entry['category_id'] == 2:
                    filenames_category_1.add(filename)
                elif entry['category_id'] == 3:
                    filenames_category_2.add(filename)
    
    # Remove common prefix and convert to list for printing
    filenames_category_1 = [filename.replace('..\\Users\\Hiba Daoud\\Desktop\\dataset\\', '') for filename in filenames_category_1]
    filenames_category_2 = [filename.replace('..\\Users\\Hiba Daoud\\Desktop\\dataset\\', '') for filename in filenames_category_2]

    return list(filenames_category_1), list(filenames_category_2)

# Example usage:
json_file = r"C:\Users\Hiba Daoud\Desktop\P2M\dataset\unknown\uknown_dataset.json"
filenames_cat1, filenames_cat2 = get_filenames_with_categories(json_file)
print("Filenames with category ID 1:")
print(filenames_cat1)
print("\nFilenames with category ID 2:")
print(filenames_cat2)
print(len(filenames_cat1))
print(len(filenames_cat2))
