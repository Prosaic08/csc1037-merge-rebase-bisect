
def add(x, y):
   return x + y


def subtract(x, y):
   return x - y

def multiply(x, y):
   return x * y

def divide(x, y):
   return x / y


if __name__ == "__main__":
   print "add(3, 4) ->", add(3, 4)
   assert(add(3, 4) == 7)
   #

   print "subtract(10, 6) ->", subtract(10, 6)
   assert(subtract(10, 6) == 4)
   print "multiply(3, 4) ->", multiply(3, 4)
   assert(multiply(3, 4) == 12)

   print "divide(12, 4) ->", divide(12, 4)
   assert(divide(12, 4) == 3)

