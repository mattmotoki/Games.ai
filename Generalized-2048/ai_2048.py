from random import randint
from sys import exit
from msvcrt import getch
from copy import deepcopy
import numpy as np
import string
import os
import time



class game:
	#------------------
	# attributes
	#------------------
	def __init__(self, w, h):
		self.board = np.zeros((h,w), dtype=np.int)  # board
		self.feasible_moves = []
		self.score = 0

	#------------------
	# methods
	#------------------	
	# display the status of the board
	def print_board(self):
		print('\nScore: ' + str(self.score))
		board = deepcopy(self.board)
		for k in range(h):
			row = board[k,:]
			row[row==0] = -1
			row = [str(x) + '      ' for x in row]
			row = [x[:6] for x in row]
			row = ''.join(x for x in row)
			row = row.replace('-1', '. ')
			print('|     ' + row + '|')
		print('-'*(len(row) + 7))
		print('Press any of the following arrow key(s):')

	#------------------
	# enter a random piece into the board
	def add_block(self):
		free_cells = np.where(self.board==0)
		ind = np.random.choice(len(free_cells[0]), 1)
		self.board[free_cells[0][ind], free_cells[1][ind]] = np.random.choice([2,4], 1, p=[0.75, 0.25])[0]
		return None

	#------------------
	# get user input for move
	def get_move():
		while True:
			key = ord(getch())
			if key == 27: print('Thanks for playing!');   exit()
			elif key == 224: 
				key = ord(getch())
				if key == 80: return 'down'
				if key == 72: return 'up'
				if key == 77: return 'right'
				if key == 75: return 'left'

	#------------------
	# check if the game has been lost
	def game_over_check(self):
		# check if board is full
		if (self.board==0).any(): return None
		
		# check if any moves are feasible
		if self.feasible_moves: return None
		
		# otherwise game over
		os.system('cls')
		self.print_board()
		print('Game over. No posssible moves.  Thanks for playing!')
		exit()
			
	#------------------
	# implement a move 
	
	# rotate board so combine_left can be applied
	def rotate_board(board, move):
		if move == 'left': return board
		if move == 'right': return np.fliplr(board)
		if move == 'up': return np.transpose(board)
		if move == 'down': return np.fliplr(np.transpose(board))
		
	# rotate board to original orientation
	def unrotate_board(board, move):
		if move == 'left': return board
		if move == 'right': return np.fliplr(board)
		if move == 'up': return np.transpose(board)
		if move == 'down': return np.transpose(np.fliplr(board))
	
	# implement a given move 	
	def implement_move(self, move):
		# move and combine all entries to the left
		def combine_left(row):
			N = len(row)
			row = [x for x in row if x!=0 ]
			i=0
			k = len(row)
			while i < k-1:
				if row[i] == row[i+1]:
					row[i] *= 2
					self.score += row[i]
					del row[i+1]
					k-=1
				else: i+=1
			return row + [0]*(N-k)
		
		# make a copy of the board
		board = deepcopy(self.board)
		
		# loop through rows/cols and combine
		M = h if move in ['left', 'right'] else w
		board = game.rotate_board(board, move)
		for i in range(M):
			row = board[i,:]
			board[i,:] = combine_left(row)
		return game.unrotate_board(board, move)

	#------------------
	# if board is full then check all four moves
	def update_feasible_moves(self):
		# see if move to the left is feasible
		def move_left_is_feasible(row): 
			# if we can remove zeros
			if (np.diff(0+(row>0))>0).any(): return True
			
			# see if blocks can be combined
			row = [x for x in row if x!=0 ]
			if len(row)>1: return any([ x==y for (x,y) in zip(row[:-1], row[1:])])
			return False

		# check all moves
		for move in ['left', 'right', 'down', 'up']:
			M = h if move in ['left', 'right'] else w
			board = deepcopy(self.board)
			board = game.rotate_board(board, move)
			for i in range(M):
				if move_left_is_feasible(board[i,:]):
					self.feasible_moves.append(move)
					break

	#------------------
	# put everything together
	def play_game(self):
		while True:
			# update board
			self.add_block() 
			os.system('cls')
			self.print_board()
			
			# check to see if the game is over
			self.update_feasible_moves()
			self.game_over_check()
			
			# get move
			move = ''
			print(self.feasible_moves)
			while move not in self.feasible_moves:
				move = game.get_move()
			self.board = self.implement_move(move)			
			self.feasible_moves = [] # reset feasible moves
			
	#------------------
	# use heuristic strategy
	def play_game_heuristic(self):
		heuristic_policy = ['right', 'down', 'left']
		while True:
			# update board
			self.add_block() 
			os.system('cls')
			self.print_board()
			
			# check to see if the game is over
			self.update_feasible_moves()
			self.game_over_check()
			
			# get move from the heuristic_policy
			move = next(x for x in heuristic_policy if x in self.feasible_moves)
			#time.sleep(0.01) 
			self.board = self.implement_move(move)			
			self.feasible_moves = [] # reset feasible moves		

	#------------------
	# use greedy strategy
	def play_game_greedy(self):
		heuristic_policy = ['right', 'down', 'left']
		heuristic_score = {'right':0.3, 'down':0.2, 'left':0.1, 'up':0} # to break ties
		while True:
			# update board
			self.add_block() 
			os.system('cls')
			self.print_board()
			
			# check to see if the game is over
			self.update_feasible_moves()
			self.game_over_check()
			
			# calculate the greedy decision
			n_feasible = len(self.feasible_moves)
			if n_feasible==1:
				move = self.feasible_moves[0]
			else:
				base_score = self.score
				new_score = dict(zip(self.feasible_moves, [0]*n_feasible))
				for move in self.feasible_moves:
					self.implement_move(move)
					new_score[move] = self.score + heuristic_score[move]
					self.score = base_score
				move = max(new_score, key=new_score.get)
			print(move)
			#time.sleep(0.01) 
			self.board = self.implement_move(move)			
			self.feasible_moves = [] # reset feasible moves

			
w, h = 4, 4 # not variable yet
g = game(w,h)
g.play_game_greedy()


