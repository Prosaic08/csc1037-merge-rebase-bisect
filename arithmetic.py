
def add(x, y):
   return x + y

def multiply(x, y):
   return x * y

if __name__ == "__main__":
   print "add(3, 4) ->", add(3, 4)
   assert(add(3, 4) == 7)
   #
   print "multiply(3, 4) ->", multiply(3, 4)
   assert(multiply(3, 4) == 12)
