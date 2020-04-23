#!/usr/bin/python3
from tkinter import *
from tkinter import simpledialog

class Window(Frame):

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.master = master
        self.init_window()

    #Creation of init_window
    def init_window(self):

        self.master.title("DOFFA 1.0")
        self.pack(fill=BOTH, expand=1)
        
        menu = Menu(self.master, tearoff=0)
        self.master.config(menu=menu)
        
        menu.add_command(label="Token", command=self.typeToken)

    def typeToken(self):
        title="API token"
        prompt="Enter your API token"

        file_name="token.txt"
        with open(file_name, "r") as f:
            lines = f.read().splitlines()
            if len(lines) > 0:
                initialValue=lines[0]
            else:
                initialValue=""

        user_input = simpledialog.askstring(title=title, prompt=prompt, initialvalue=initialValue) or initialValue
        if user_input != initialValue:
            with open(file_name, "w+") as f:
                f.write(user_input)

def main():
    root = Tk()
    root.geometry("400x300")
    #root.eval('tk::PlaceWindow %s center' % root.winfo_pathname(root.winfo_id()))
    root.eval('tk::PlaceWindow %s center' % root.winfo_toplevel())
    app = Window(root)
    root.mainloop()

main()
