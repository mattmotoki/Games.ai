from random import randint
from sys import exit
from msvcrt import getch
from copy import deepcopy
import numpy as np
import string
import os


class game:
	#------------------
	# attributes
	#------------------
	def __init__(self, w, h):
		self.board = np.zeros((h,w), dtype=np.int)  # board
		self.score = 0

	#------------------
	# methods
	#------------------	
	# display the status of the board
	def print_board(self):
		print('\nScore: ' + str(self.score))
		for k in range(h):
			row = deepcopy(self.board[k,:])
			row[row==0] = -1

			row = [str(x) + '      ' for x in row]
			row = [x[:6] for x in row]
			row = ''.join(x for x in row)
			row = row.replace('-1', '. ')
			print('|     ' + row + '|')
		print('-'*(len(row) + 7))

	#------------------
	# enter a random piece into the board
	def add_block(self):
		free_cells = np.where(self.board==0)
		ind = np.random.choice(len(free_cells[0]), 1)
		self.board[free_cells[0][ind], free_cells[1][ind]] = np.random.choice([2,4], 1, p=[0.75, 0.25])[0]
		return None

	#------------------
	# implement move
	def move_blocks(self):
		def get_move():
			while True:
				key = ord(getch())
				if key == 27: break
				elif key == 224: 
					key = ord(getch())
					if key == 80: return 'down'
					if key == 72: return 'up'
					if key == 77: return 'right'
					if key == 75: return 'left'

		# move and combine all entries to the left
		def combine_left(row):
			N = len(row)
			row = [x for x in row if x!=0 ]
			i=0
			k = len(row)
			while i < k-1:
				if row[i] == row[i+1]:
					self.score += 2*row[i]
					row[i] *= 2
					del row[i+1]
					k-=1
				else: i+=1
			return row + [0]*(N-k)

		# rotate board so combine_left can be applied
		def rotate_board(move):
			if move == 'left': return self.board
			if move == 'right': return np.fliplr(self.board)
			if move == 'up': return np.transpose(self.board)
			if move == 'down': return np.fliplr(np.transpose(self.board))

		# rotate board to original orientation
		def unrotate_board(move):
			if move == 'left': return self.board
			if move == 'right': return np.fliplr(self.board)
			if move == 'up': return np.transpose(self.board)
			if move == 'down': return np.transpose(np.fliplr(self.board))

		# loop through rows/cols and combine
		def implement_move(move):
			# implement move
			N = h if move in ['left', 'right'] else w
			self.board = rotate_board(move)
			for i in range(N):
				row = self.board[i,:]
				self.board[i,:] = combine_left(row)
			return unrotate_board(move)

		# check if the game has been lost
		def game_over_check():
			# check if board is full
			if (self.board==0).any(): return None

			# if board is full then check all four moves
			old_board = deepcopy(self.board)
			for move in ['left', 'right', 'down', 'up']:
				self.board = implement_move(move)
				if (old_board != self.board).any(): return None

			# if the above fails to return then game over
			os.system('cls')
			self.print_board()
			print('Game over. No posssible moves.  Thanks for playing!')
			exit()

		# check to see that moves are even possible
		game_over_check()

		# update board
		print('Press any arrow key:')
		old_board = deepcopy(self.board)
		while (old_board == self.board).all():
			# get move
			move = get_move()
			self.board = implement_move(move)

	#------------------
	# put everything together
	def play_game(self):
		while True:
			# update board
			self.add_block() 
			os.system('cls')
			self.print_board()
			
			# get move
			self.move_blocks() 


w, h = 4, 3 # not variable yet
g = game(w,h)
print(g.board)
g.add_block()
print(g.board)
#g.play_game()


