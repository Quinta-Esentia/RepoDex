# -*- coding: utf-8 -*-
"""
Created on Fri Nov 27 11:10:35 2020

@author: Dexter.Camison
"""

# https://www.youtube.com/watch?v=Y6cir7P3YUk&list=PLQVvvaa0QuDclKx-QpC9wntnURXVJqLyk&index=3

import tkinter as tk

LARGE_FONT = ("Verdana", 12)

class MovieTinder(tk.Tk):
    
    def __init__(self, *args, **kwargs):

        tk.Tk.__init__(self, *args, **kwargs)
        container = tk.Frame(self)
        
        container.pack(side = 'top', fill = 'both', expand = True)
        
        container.grid_rowconfigure(0, weight = 1)
        container.grid_columnconfigure(0, weight = 1)
        
        
        self.frames = {}
    
        frame = StartPage(container, self)
        
        self. frames[StartPage] = frame
        
        frame.grid(row = 0, column = 0, sticky = 'nsew') # stretches everything to the size of that window
        
        self.show_frame(StartPage)
        
    def show_frame(self, cont):
        
        frame = self.frames[cont]
        frame.tkraise()
        

class StartPage(tk.Frame):
    
    def __init__(self, parent, controller):
        tk.Frame.__init__(self, parent)
        label = tk.Label(self, text = "Start Page", font = LARGE_FONT)
        label.pack(pady = 10, padx = 10) # pack for basic layouts, otherwise use grid
    
    
app = MovieTinder()
app.mainloop()
    