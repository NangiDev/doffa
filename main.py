#!/usr/bin/python3
from tkinter import *
from tkinter import simpledialog
from tkcalendar import Calendar

import json
import calculate as calc


class Window(Frame):

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.master = master
        self.init_window()

    def init_cal(self, date, row=0, col=0):
        cal = Calendar(self, year=2018, month=2, day=5)
        cal.grid(row=row,column=col)

    def init_button(self, row=0, col=0):
        button = Button(self, text="C\nA\nL\nC")
        button.grid(row=row,column=col)

    def init_text(self, row=0, col=0):
        text = Text(self, state='disabled')
        text.grid(row=row,column=col)


    #Creation of init_window
    def init_window(self):

        self.master.title("DOFFA 1.0")
        self.pack(fill=BOTH, expand=1)
        
        menu = Menu(self.master, tearoff=0)
        self.master.config(menu=menu)
        
        menu.add_command(label="Token", command=self.typeToken)

        self.init_cal("", 0,0)
        self.init_button( 0,1)
        self.init_text(0,2)

        self.init_cal("", 1,0)
        self.init_button( 1,1)
        self.init_text(1,2)

        #end_text.insert(INSERT, json.dumps(calc.parseJson(calc.request("2020-04-08")), indent=2))

    def typeToken(self):
        title="API token"
        prompt="Enter your API token"

        with open(calc.file_name, "r") as f:
            lines = f.read().splitlines()
            initialValue = lines[0] if len(lines) > 0 else ""

        user_input = simpledialog.askstring(title=title, prompt=prompt, initialvalue=initialValue) or initialValue
        if user_input != initialValue:
            with open(calc.file_name, "w+") as f:
                f.write(user_input)

def main():
    def exit(event):
        root.destroy()

    root = Tk()

    #root.eval('tk::PlaceWindow %s center' % root.winfo_toplevel())

    Window(root)

    root.bind("<Escape>", exit)
    root.mainloop()

main()
