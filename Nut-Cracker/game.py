from random import randint
import string
import os



class game:
	
	# initialize the game with a random board
	def __init__(self,m,n, difficulty):
		self.size = (m,n)
		self.X_Alphabet = string.ascii_uppercase[0:n]
		self.Y_Alphabet = string.ascii_uppercase[0:m]
		
		
		self.score = 0
		self.move = 0

		if difficulty.lower() == 'easy':
			self.symbol_dictionary = {0:'[o]', 1:'<->', 2:'{:}', 3:'(#)'}
		elif difficulty.lower() == 'medium':
			self.symbol_dictionary = {0:'[o]', 1:'<->', 2:'{:}', 3:'(#)',4:'[=]',5:'{%}'}
		else:
			self.symbol_dictionary = {0:'[o]', 1:'<->', 2:'{:}', 3:'(#)',4:'[=]',5:'{%}', 6:'<@>', 7:'(X)'}
		
		self.N_nuts = len(self.symbol_dictionary)
		
		# create a random board
		self.board = []		
		for i in range(m):
			self.board.append([])
			for j in range(n):
				self.board[i].append(self.symbol_dictionary[randint(0, len(self.symbol_dictionary) - 1)])
				
		# initialize the board
		self.initialize_board()

		return None
	
	# rotate right
	def rotate_right(self):
		return map(list,zip(*self.board[::-1]))
	# rotate left
	def rotate_left(self):
		return map(list,zip(*self.board))[::-1]

		
	# print board 
	def print_board(self):
		(m,n) = self.size
		
		# print top boarder
		print ' '*7 + '|   ' + '     '.join(self.X_Alphabet) + '\n'
		print ' '*3 + '-'*3 + '|-' + '-'*(6*n) + '\n'
		
		# print board and left label
		for i in range(0,m):
			print  ' '*4 + self.Y_Alphabet[i] + ' |   ' + '   '.join(self.board[i])  + '\n'  
		print('\n'*3)
		return None

	# print score
	def print_status(self):
		print 'score: ' + str(self.score) + ' \t move:' + str(self.move) + '\n'
		self.print_board()
		return None
		

	# get the indices for every row of the horizontal nuts to crack
	def get_indices(self):
		indices = []
		for i in range(0,len(self.board)) :
			row = self.board[i]
		
			# row_indices = crack_array(board[i],i,row_indices) 
			count = 0
			for j in range(len(row)-1):
				if row[j] == row[j+1]:
					count +=1
				else:
					if count >= 2:
						indices.append((i,j,count))
					count = 0
			# check edge case
			if count >= 2:
				indices.append((i,j+1,count))

		return indices	
		

	# replace cracked nuts with blanks ' '
	def crack_rows(self,indices):
		for inds in indices:
			i = inds[0]
			j = inds[1]
			count = inds[2]
			self.board[i][j-count:j+1] = ' '*(count+1)
		
		
	


	# initialize the board
	def initialize_board(self):

					
		# get the indices of the horizontally cracked elements
		row_indices = self.get_indices()

		# crack the elements vertically
		self.board = self.rotate_left()
		col_indices = self.get_indices()
		self.crack_rows(col_indices)

		
		# crack the elements horizontally
		self.board = self.rotate_right()
		self.crack_rows(row_indices)
		
		# if both the row and col indices are empty then return 
		if not row_indices and not col_indices:
			return None
			

		 
		# remove the cracks and add random nuts to the end
		# rotate lists so that removed nuts 
		(m,n) = self.size
		self.board = self.rotate_right() 
		i = 0 # row index
		while (i<n):
			j = 0 # col index
			ncol = m
			while (j<ncol):
				if self.board[i][j]==' ':
					self.board[i].remove(' ')
					self.board[i].append(self.symbol_dictionary[randint(0,self.N_nuts -1)])		
					ncol -= 1 # decrease the number of columns
				else:
					j += 1
			i += 1
		
		
		# repeat
		self.initialize_board()
		
		return None
	
		
		
	# crack nuts
	def crack_nuts(self):
					
		# get the indices of the horizontally cracked elements
		row_indices = self.get_indices()

		# crack the elements vertically
		self.board = self.rotate_left()
		col_indices = self.get_indices()
		self.crack_rows(col_indices)

		
		# crack the elements horizontally
		self.board = self.rotate_right()
		self.crack_rows(row_indices)
		
		# if both the row and col indices are empty then return 
		if not row_indices and not col_indices:
			return None
			
			
		# show board with holes
		self.print_board()

		 
		# remove the cracks and add random nuts to the end
		# rotate lists so that removed nuts 
		(m,n) = self.size
		self.board = self.rotate_right() 
		i = 0 # row index
		while (i<n):
			j = 0 # col index
			ncol = m
			while (j<ncol):
				if self.board[i][j]==' ':
					self.board[i].remove(' ')
					self.board[i].append(self.symbol_dictionary[randint(0,self.N_nuts -1)])		
					self.score += 1
					ncol -= 1 # decrease the number of columns
				else:
					j += 1
			i += 1
		
		# return board back to the original position
		self.board = self.rotate_left()

		# print the status of the game
		self.print_status()
		
		# repeat
		self.crack_nuts()
		
		return None

	
	
	# switch nuts
	def switch_nuts(self):
		
		def enter_input(input_number):
			while True:
				loc = raw_input('Enter the location of nut ' + str(input_number) + ' (e.g., AA): ').upper()
				
				if len(loc) != 2:
					print '  You did not enter a valid location.\n'
					
				elif loc[0] not in self.Y_Alphabet:
					print '  You entered an invalid row location not on the board.'
					print '  Valid row locations include:  ' + '  '.join(self.Y_Alphabet) + '\n'
					
				elif loc[1] not in self.X_Alphabet:
					print '  You entered an invalid column location not on the board.'
					print '  Valid column locations include:  ' + '  '.join(self.X_Alphabet) + '\n'
				
				else: break
			
			print ' '
			# return (row,col)
			return (self.Y_Alphabet.index(loc[0]), self.X_Alphabet.index(loc[1]))
	
			
		# update move
		self.move += 1
		
		# get valid inputs
		L1 = enter_input(1)
		L2 = enter_input(2)
		
		
		# switch locations
		self.board[L2[0]][L2[1]], self.board[L1[0]][L1[1]] = self.board[L1[0]][L1[1]], self.board[L2[0]][L2[1]]
		
	
		
		self.print_status()
		g.crack_nuts()
		return None
		
		
		
		
		
		
		
		
		
difficulty = 'medium'

level = 1

while level !=0:
		
	# create a new level
	g = game(5,5, difficulty)
	score_threshold = 3*level + level-1
	move_threshold = level
	g.crack_nuts()
	os.system('cls')


	if level == 1 : print 'Welcome to Nut-Cracker!'
	print '\n\nLevel ' + str(level) + \
		  ':  Get a score of at least ' + str(score_threshold) + \
		  ' within ' + str(move_threshold) + ' moves.'
	print 'Switch any two nuts to begin.\n'
	g.print_status()
	
	
	while True:
		if g.score>=score_threshold:
			print 'Congratulations you passed Level ' + str(level) + '!'
			raw_input("Press Enter to continue...")
			level += 1
			break
		elif g.move>=move_threshold:
			print 'Sorry you lose.\nPlease try again.'
			level = 0
			break
		g.switch_nuts()
		


