
def add(x, y):
   return x + y

def square(n):
   return n * n

if __name__ == "__main__":
   print "add(3, 4) ->", add(3, 4)
   assert(add(3, 4) == 7)
   #
   print "square(3) ->", square(3)
   assert(square(3) == 9)
