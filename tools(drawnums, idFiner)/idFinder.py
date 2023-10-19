SHEET_WIDE = 6 #the part where you want to extract #number used for how many specific things in x value
SHEET_HEIGHT = 18#the part where you want to extract # number used for how many specific things in y value

NUM_COLUMNS = [5, 6] #by default every columns[1, SHEET_WIDE]
NUM_ROWS = [13, 18]#By default every rows[1, SHEET_HEIGHT]

# THIS IS FOR GRABBING C0LUMNS
a = [x * SHEET_WIDE + n for x in range(NUM_ROWS[0] - 1, NUM_ROWS[1]) for n in range(NUM_COLUMNS[0], NUM_COLUMNS[1] + 1)]
# THIS IS FOR GRABBING ROWS
# b = [x * SHEET_HEIGHT + n for x in range(SHEET_WIDE) for n in range(NUM_ROWS[0], NUM_ROWS[1] + 1)]
print(sorted(set(a)))
