from random import randint
from sys import exit
from msvcrt import getch
import numpy as np
import string




class game:
	#------------------
	# attributes
	#------------------
	def __init__(self, w, h):
		self.board = np.zeros((h,w), dtype=np.int)  # board
		self.score = 0
		self.changed = False

	#------------------
	# methods
	#------------------
	# display the status of the board
	def print_board(self):
		for k in range(h):
			row = self.board[k,:]
			row = ' '.join(str(e) for e in row)
			row = row.replace('0','.')
			print('| ' + row + ' |')

		print('-'*17)
		print('  ' + ' '.join(str(e) for e in range(w)))        

	#------------------
	# enter a random piece into the board
	def add_block(self):
		free_cells = np.where(self.board==0)
		ind = np.random.choice(len(free_cells[0]), 1)
		self.board[free_cells[0][ind], free_cells[1][ind]] = 2
		self.print_board()
		return None

    
	#------------------
	# implement move    
	def get_move(self):
		print('Press any arrow key:')
		while True:
			key = ord(getch())
			if key == 27: break
			elif key == 224: 
				key = ord(getch())
				if key == 80: return 'down'
				if key == 72: return 'up'
				if key == 77: return 'right'
				if key == 75: return 'left'

	def move_blocks(self):
		def combine_left(row):
			row = [x for x in row if x!=0 ]
			i=0
			N = len(row)
			while i < N-1:
				if row[i] == row[i+1]:
					row[i] *= 2
					del row[i+1]
					N-=1
				else: i+=1
			return row + [0]*(4-N)
		
		def rotate_board(move):
			if move == 'left': return self.board
			if move == 'right': return np.fliplr(self.board)
			if move == 'up': return np.transpose(self.board)
			if move == 'down': return np.fliplr(np.transpose(self.board))
			
		def unrotate_board(move):
			if move == 'left': return self.board
			if move == 'right': return np.fliplr(self.board)
			if move == 'up': return np.transpose(self.board)
			if move == 'down': return np.transpose(np.fliplr(self.board))				
		
		# get move
		move = self.get_move()
		
		# implement move
		self.board = rotate_board(move)
		for i in range(4):
			row = self.board[i,:]
			self.board[i,:] = combine_left(row)
		self.board = unrotate_board(move)
		
		
w, h = 4, 4 # not variable yet
g = game(w,h)

while True:
	g.add_block()
	g.move_blocks()
	
