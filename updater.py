import requests
import zipfile
import io
import hashlib
import shutil
import os
import tkinter as tk
from tkinter import messagebox
import stat
from tkinter.ttk import Progressbar

def get_current_version():
    url = 'http://shaunrsimons.com/updates/current_version.txt'
    version = requests.get(url=url).text.strip('\n')
    return version+'.zip'


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


def remove_readonly(func, path, excinfo):
    os.chmod(path, stat.S_IWRITE)
    func(path)


def check_checksum(filename, zfile, checksum_dict):
    calc_hash = hashlib.sha256(zfile.content).hexdigest()
    return checksum_dict[filename] == calc_hash


def save_zip(file, filename):
    current_directory = os.getcwd()
    if os.path.exists(f'{current_directory}\\versions\\{filename[:-4]}'):
        shutil.rmtree(f'{current_directory}\\versions\\{filename[:-4]}')
    z = zipfile.ZipFile(io.BytesIO(file.content))
    z.extractall(current_directory + '\\versions\\'+filename[:-4])
    z.close()


def update(filename):
    current_directory = os.getcwd()
    for file in os.listdir(current_directory+f'\\versions\\{filename[:-4]}'):
        original_path = current_directory+f'\\versions\\{filename[:-4]}\\'+file
        target_path = current_directory+'\\'+file
        if os.path.exists(target_path):
            if os.path.isdir(target_path):
                shutil.rmtree(target_path)
            else:
                os.remove(target_path)
        shutil.move(original_path, target_path)


def progress_screen():
    progress = tk.Tk()
    x = progress.winfo_screenwidth()
    y = progress.winfo_screenheight()
    a = 0.3
    b = 0.15
    progress.geometry(str(round(x * a)) +
                  'x'
                  + str(round(y * b)) +
                  '+'
                  + str(round((-a * x + x) / 2)) +
                  '+'
                  + str(round((-b * y + y) / 2)))
    progress.title('Updating')
    updating_label = tk.Label(progress, text='Updating.....', font='Courier 15 bold')
    updating_label.pack()
    progress_bar = Progressbar(progress, orient=tk.HORIZONTAL, length=(x*a)-10, mode='determinate')
    progress_bar.pack()
    progress_label = tk.Label(progress, text='Downloading Checksums', font='Courier 8')
    progress_label.pack()

    progress_bar['value'] = 10
    progress_bar.update()
    progress_label.config(text='Downloading checksums')

    checksums = parse_checksums()

    progress_bar['value'] = 20
    progress_label.config(text='Checksums downloaded')
    progress_bar.update()
    if checksums != 'Error':
        filename = get_current_version()
        progress_bar['value'] = 25
        progress_label.config(text=f'Downloading {filename}')
        progress_bar.update()
        zfile = retrieve_zip(filename)
        if zfile != 'Error':
            progress_bar['value'] = 70
            progress_label.config(text=f'Comparing checksums')
            progress_bar.update()
            if check_checksum(filename, zfile, checksums):
                progress_bar['value'] = 85
                progress_label.config(text=f'Checksums match')
                progress_bar.update()
                save_zip(zfile, filename)
                progress_bar['value'] = 95
                progress_label.config(text=f'{filename} saved')
                progress_bar.update()
                print('Saved')
                update(filename)

                progress_bar['value'] = 100
                progress_label.config(text=f'Updated')
                progress_bar.update()
                print('Updated')
                messagebox.showinfo('Update Successful', 'MonsterTruck updated successfully')
                progress.destroy()
                root.destroy()

            else:
                tk.messagebox.showerror('Checksum Fail', 'Update download failed checksum test. Try updating later.', parent=progress)
        else:
            tk.messagebox.showerror('Download Error', 'Update failed to download', parent=progress)
    else:
        tk.messagebox.showerror('Checksum Download Failed', 'Checksum.txt failed to download.', parent=progress)


# os.chdir('C:\\Users\\shaun\\monsterTruckEXE\\app')
print(os.getcwd())
current_version = get_current_version()
root = tk.Tk()
root.grid_columnconfigure(0, weight=1)
root.grid_columnconfigure(1, weight=1)
root.grid_rowconfigure(0, weight=1)
root.grid_rowconfigure(1, weight=1)
root.grid_rowconfigure(2, weight=1)
x = root.winfo_screenwidth()
y = root.winfo_screenheight()
a = 0.3
b = 0.2
root.geometry(str(round(x * a)) +
              'x'
              + str(round(y * b)) +
              '+'
              + str(round((-a * x + x) / 2)) +
              '+'
              + str(round((-b * y + y) / 2)))

root.title('Monster Truck Updater')
title = tk.Label(root, text='Monster Truck Updater Tool', font='Courier 15 bold')
title.grid(row=0, columnspan=2)
message = tk.Label(root, text=f'This tool will update Monster Truck to {current_version[:-4]}')
message.grid(row=1, columnspan=2)
cancel_button = tk.Button(root, text='Cancel', command=root.destroy)
cancel_button.grid(row=2, column=0)
ok_button = tk.Button(root, text='Ok', command=progress_screen)
ok_button.grid(row=2, column=1)



root.mainloop()

