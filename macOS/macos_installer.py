import os
import text
from tkinter import *

# Global Vars
title_text = ["Welcome to Daisy Toolchain Setup", "License Agreement", "Choose Install Location", "Installing..."]
body_text = [text.body_text_0, text.body_text_1, text.body_text_2, "Installing..."]
next_button_text = ["Next>", "I Agree", "Install", "Install"]

page_num = 0

def Install():
    os.system('install.command')

def UpdatePage():
    global next_button_text, next_button, back_button, page_num

    if(page_num > -1 and page_num < 4):
        title_label['text'] = title_text[page_num]
        body_label['text'] = body_text[page_num]
        next_button['text'] = next_button_text[page_num]

    if(page_num == 1):
        body_label['height'] = 3
        license_scroll.pack(side=TOP)
    else:
        license_scroll.pack_forget()
        body_label['height'] = 7


    if(page_num < 0):
        page_num = 0
    elif(page_num == 0):
        back_button['state'] = 'disabled'
    elif(page_num < 3):
        back_button['state'] = 'active'
    else:
        next_button['state'] = 'disabled'
        back_button['state'] = 'disabled'
        Install()


def Next():
    global next_button_text, next_button, back_button, page_num
    page_num += 1
    UpdatePage()

def Back():
    global back_button_text, back_button, page_num
    page_num -= 1
    UpdatePage()

def Cancel():
    exit()

# Graphics Setup
tk = Tk()
tk.geometry("500x400")
tk.title('Daisy Toolchain Installer')

# text
title_label = Label(tk, text=title_text[0], font=("Arial", 10))
title_label.pack(side=TOP, padx=5, pady=10)

body_label = Label(tk, text=body_text[0], font=("Arial", 10), height=7, width=80, justify='left', wraplength=450)
body_label.pack(padx=10, pady=5)

license_scroll = Text(tk, font=("Arial", 10), height=15, width=70)
license_scroll.insert('end', text.license_text)
license_scroll.config(state='disabled')

# buttons
butt_frame = Frame(tk, relief=FLAT, borderwidth=1, height=40)
butt_frame.pack(fill=X, expand=False, side=BOTTOM)
butt_frame.pack_propagate(0)  # otherwise it wants to be chonky

#  push the buttons to the left
butt_pad_frame = Frame(butt_frame, relief=FLAT, borderwidth=1, height=40, width=150)
butt_pad_frame.pack(fill=X, expand=False, side=RIGHT)
butt_pad_frame.pack_propagate(0)  # otherwise it wants to be chonky

next_button = Button(butt_frame, text="Next>", command = Next)
next_button.pack(side=RIGHT, padx=5, pady=5)

back_button = Button(butt_frame, text="<Back", command = Back)
back_button['state'] = 'disabled'
back_button.pack(side=RIGHT, padx=5, pady=5)

cancel_button = Button(butt_frame, text="Cancel", command = Cancel)
cancel_button.pack(side=RIGHT, padx=5, pady=5)

# render graphics forever...
tk.mainloop()