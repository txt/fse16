from __future__ import division,print_function
import sys,string,re, math
sys.dont_write_bytecode=True

def same(x)   : return x
def atoms(lst): return map(atom,lst)

def atom(x)  :
  try: return int(x)
  except:
    try:               return float(x)
    except ValueError: return x
    
def rows(file,prep=same):
  with open(file) as fs:
    for line in fs:
      line = re.sub(r'([\n\r\t]|#.*)', "", line)
      row = map(lambda z:z.strip(), line.split(","))
      if len(row)> 0:
         yield prep(row) if prep else row

for row in rows('../data/weather.csv',atoms):
   print(row)
