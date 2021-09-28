import tkinter as tk
from tkinter import ttk
import subprocess

commlist = ['''
    if ! command -v brew &> /dev/null;
    then /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; fi''',
    'brew update',
    '''brew install openocd dfu-util gcc-arm-embedded;
    find /usr/local/Caskroom/gcc-arm-embedded -type f -perm +111 -print | xargs spctl --add --label "gcc-arm-embedded";
    find /usr/local/Caskroom/gcc-arm-embedded | xargs xattr -d com.apple.quarantine''',
    'echo done']

textlist = ['Installing Homebrew', 'Upgrading Homebrew', 'Installing Packages (This may take a while)', 'Done!']
sub_proc = None


def Cancel():
    if(sub_proc):
        sub_proc.kill()
    exit()

def Install():
    for i in range(len(commlist)):                

        # write new text
        txt.delete('0.0', tk.END)
        txt.insert(tk.END, textlist[i])
        root.update()

        # run the command in a child
        sub_proc = subprocess.Popen(
                ['/bin/bash', '-c', commlist[i]]
#                stdout=proc_log,
#                stderr=proc_log
        )

        # do graphics while we wait for the child
        while sub_proc.poll() is None:
            #proc_log.flush()
            #os.fsync(proc_log)
            root.update()

        # increment the progress bar
        p.step()            



root = tk.Tk()
root.title("DaisyToolchain Installer")

txt = tk.Text(root)
txt.insert(tk.END, "license goes here")
txt.pack()

p = ttk.Progressbar(root,orient=tk.HORIZONTAL,length=200,mode="determinate",takefocus=True,maximum=len(commlist))
p.pack()

cancelButton = tk.Button(root, text="Cancel", command=Cancel)
cancelButton.pack()

installButton = tk.Button(root, text="Agree to License and Install", command=Install)
installButton.pack()


while (True):
    root.mainloop()
