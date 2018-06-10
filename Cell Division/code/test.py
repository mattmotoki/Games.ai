from tkinter import *
import PIL.Image
import PIL.ImageTk


CELL_PIXELS = 120
BOARD_WIDTH = 5
BOARD_HEIGHT = 5

BOARD_WIDTH_PIXELS = BOARD_WIDTH*CELL_PIXELS
BOARD_HEIGHT_PIXELS = BOARD_HEIGHT*CELL_PIXELS

PLAYER_COLORS = ['g', 'f']



def plot_grid(canvas):

   # vertical lines at an interval of "line_distance" pixel
   for x in range(CELL_PIXELS, BOARD_WIDTH_PIXELS, CELL_PIXELS):
      canvas.create_line(x, 0, x, BOARD_HEIGHT_PIXELS, width=1, fill="#476042")
      
   # horizontal lines at an interval of "line_distance" pixel
   for y in range(CELL_PIXELS, BOARD_HEIGHT_PIXELS, CELL_PIXELS):
      canvas.create_line(0, y, BOARD_WIDTH_PIXELS, y, width=1, fill="#476042")

def plot_connection(canvas, loc, direction=''):
    i, j = loc

    if direction == '':
        i_start, i_end = i*CELL_PIXELS, (i+1)*CELL_PIXELS
        j_start, j_end = j*CELL_PIXELS, (j+1)*CELL_PIXELS

    canvas.create_line(i_start, j_start, i_end, j_end,fill="#476042")


def plot_cell(canvas, loc, player, connection_type='0000'):

    i, j = loc[0]*CELL_PIXELS, loc[1]*CELL_PIXELS
    image_name = f'../images/{PLAYER_COLORS[player]}{connection_type}.png'    
    canvas.images.append(PIL.ImageTk.PhotoImage(PIL.Image.open(image_name)))
    canvas.create_image(i, j, image=canvas.images[-1], anchor=NW)
    print(canvas.images)
    
    # img = PhotoImage(file=image_name)
    # 

master = Tk()
w = Canvas(master, 
           width = BOARD_WIDTH_PIXELS,
           height = BOARD_HEIGHT_PIXELS)
w.pack()
w.images = []

plot_connection(w, (1,1))
plot_cell(w, (0,0), 0)
plot_cell(w, (1,0), 1)
plot_grid(w)
# img = PhotoImage(file='../images/g0000.png')
# w.create_image(20,20, anchor=NW, image=img)  

mainloop()