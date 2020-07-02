import requests
import zipfile
import io
import hashlib
import shutil
import os

def parse_checksums():
    url = 'http://shaunrsimons.com/updates/'
    print('Downloading checksum.txt..............', end='')
    checksums = requests.get(url+'checksum.txt')
    if checksums.status_code == 200:
        print('Success')
        checksums = checksums.text.split('\n')
        checksums = [i.split() for i in checksums[:-1]]
        checksums = [(i[1],i[0]) for i in checksums]
        check_dict = dict(checksums)
        return check_dict
    else:
        print('Failed')
        return False

def retrieve_zip(filename):
    url = 'http://shaunrsimons.com/updates/'
    print(f'Downloading {filename}...............', end='')
    zfile = requests.get(url+filename)
    if zfile.status_code == 200:
        print(f'Success')
        return zfile
    else:
        print('Failed')
        return 'Error'

def check_checksum(filename, zfile, checksum_dict):
    calc_hash = hashlib.sha256(zfile.content).hexdigest()
    return checksum_dict[filename] == calc_hash

def save_zip(file, filename):
    z = zipfile.ZipFile(io.BytesIO(file.content))
    z.extractall('./versions/'+filename[:-4])
    z.close()

def update(filename):
    for file in os.listdir(f'./versions/{filename[:-4]}/{filename[:-4]}/monster_truck2'):
        print(file)
        original_path = f'./versions/{filename[:-4]}/{filename[:-4]}/monster_truck2/'+file
        target_path = './test_app/'+file
        shutil.copyfile(original_path, target_path)

if __name__ == '__main__':
    checksums = parse_checksums()
    if checksums != 'Error':
        filename = 'v2.1.0.beta.zip'
        zfile = retrieve_zip(filename)
        if zfile != 'Error':
            if check_checksum(filename, zfile, checksums):
                save_zip(zfile, filename)
                print('saved')
                update(filename)
                print('Updated')
            else:
                print("Checksums don't match")
        else:
            'Print could not download zip file'
    else:
        'Could not download checksum.txt'
