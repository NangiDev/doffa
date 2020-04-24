#!/usr/bin/python3
from tkinter import *
from tkinter import simpledialog
from tkcalendar import Calendar
from datetime import datetime, timedelta
import os
import json
import calculate as calc


class Window(Frame):

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.master = master
        self.init_window()

    def init_gui(self, start_date, end_date):
        frame_width=250
        frame_height=150


        cal1 = Calendar(self, year=start_date.year, month=start_date.month, day=start_date.day)
        cal1.grid(row=0,column=0)

        textFrame1 = Frame(self, width=frame_width, height=frame_height)
        textFrame1.grid(row=0, column=2, sticky=W+E+S+N)
        textFrame1.columnconfigure(0, weight=10)
        textFrame1.grid_propagate(False)
        text1 = Text(textFrame1, state=DISABLED)
        text1.grid(row=0,column=0, sticky=W+E+S+N)

        cal2 = Calendar(self, year=end_date.year, month=end_date.month, day=end_date.day)
        cal2.grid(row=1,column=0)

        textFrame2 = Frame(self, width=frame_width, height=frame_height)
        textFrame2.grid(row=1, column=2, sticky=W+E+S+N)
        textFrame2.columnconfigure(0, weight=10)
        textFrame2.grid_propagate(False)
        text2 = Text(textFrame2, state=DISABLED)
        text2.grid(row=1,column=0, sticky=W+E+S+N)

        def update_start():
            date=cal1.selection_get()
            data=calc.parseJson(calc.request(date.strftime(calc.date_fmt)))
            pretty=json.dumps(data, indent=2)
            text1.config(state=NORMAL)
            text1.delete('1.0', END)
            text1.insert(INSERT, pretty)
            text1.config(state=DISABLED)
            return data

        def update_end():
            date=cal2.selection_get()
            data=calc.parseJson(calc.request(date.strftime(calc.date_fmt)))
            pretty=json.dumps(data, indent=2)
            text2.config(state=NORMAL)
            text2.delete('1.0', END)
            text2.insert(INSERT, pretty)
            text2.config(state=DISABLED)
            return data

        btn_text="F\nE\nT\nC\nH"
        button1 = Button(self, text=btn_text, command=update_start)
        button1.grid(row=0,column=1)
        button2 = Button(self, text=btn_text, command=update_end)
        button2.grid(row=1,column=1)

        textDiffFrame = Frame(self, width=frame_width, height=frame_height)
        textDiffFrame.grid(row=3, column=2, sticky=W+E+S+N)
        textDiffFrame.columnconfigure(0, weight=10)
        textDiffFrame.grid_propagate(False)
        textDiff=Text(textDiffFrame, state=DISABLED)
        textDiff.grid(row=0,column=0, sticky=W+E+S+N)

        textRatioFrame = Frame(self, width=frame_width, height=frame_height)
        textRatioFrame.grid(row=3, column=0, sticky=W+E+S+N)
        textRatioFrame.columnconfigure(0, weight=10)
        textRatioFrame.grid_propagate(False)
        textRatio=Text(textRatioFrame, state=DISABLED)
        textRatio.grid(row=0, column=0,sticky=W+E+S+N)

        def calculate():
            data={"start": update_start(), "end": update_end()}
            diff_data=calc.getDiff(data)
            pretty=json.dumps(diff_data, indent=2)
            textDiff.config(state=NORMAL)
            textDiff.delete('1.0', END)
            textDiff.insert(INSERT, pretty)
            textDiff.config(state=DISABLED)
            textRatio.config(state=NORMAL)
            textRatio.delete('1.0', END)
            lean=int((diff_data["lean"]/diff_data["kg"])*100+0.5)
            fat=int((diff_data["fat"]/diff_data["kg"])*100+0.5)
            textRatio.insert(INSERT, "Lean/Fat: {}/{}".format(lean, fat))
            textRatio.config(state=DISABLED)
            return data

        button=Button(self, text="CALCULATE", command=calculate)
        button.grid(row=2,column=0, columnspan=3)

    #Creation of init_window
    def init_window(self):
        end_date=datetime.today()
        start_date=end_date - timedelta(weeks=1)

        self.master.title("DOFFA 1.0")
        self.pack(fill=BOTH, expand=1)
        
        menu = Menu(self.master, tearoff=0)
        self.master.config(menu=menu)
        
        menu.add_command(label="Token", command=self.typeToken)

        self.init_gui(start_date, end_date)

    def typeToken(self):
        title="API token"
        prompt="Enter your API token"

        if not os.path.exists(calc.file_name):
            with open(calc.file_name,"w"): pass

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

    Window(root)

    root.bind("<Escape>", exit)
    root.mainloop()

main()
