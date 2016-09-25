self.cols = [Sym(headings[0]), Num(headings[1].split('-')[0]),
                     Num(headings[2].split('<')[1]), Sym(headings[3]),
                     Num(headings[4].split('>')[1])]


def aha_distance(i, r1, r2):
        distance = 0
        for col, row1, row2 in zip(i.cols, r1, r2):
            distance += col.dist(row1, row2)
        if distance<0:
            distance = 0
            for col, row1, row2 in zip(i.cols, r2, r1):
                distance += col.dist(row1, row2)
        return math.sqrt(distance)
        
  
# ##########
# better iterator?
def row_distance(self, row1, row2) :
        distance = 0
        index = 0
        for index in xrange(len(self.cols) - 1):
            col = self.cols[index]
            distance += (col.dist(row1[index], row2[index]))
        return math.sqrt(distance)


###########
# can i do this easier?


 def find_nearest(self, row) :
        nearest = None
        distance = sys.maxint
        for r in self.rows:
            if r != row:
                current_distance = self.row_distance(row, r)
                if distance >= current_distance:
                    nearest = r
                    distance = current_distance
        return nearest
        
    def find_furthest(self, row) :
        furthest = None
        distance = -sys.maxint - 1
        for r in self.rows:
            if r != row:
                current_distance = self.row_distance(row, r)
                if distance <= current_distance:
                    furthest = r
                    distance = current_distance
        return furthest



  def furthest(i,r1,cols=None,f=None, better=more,init= -1,ignore=set()):
    out,d = r1,init
    for r2 in i._rows:
      if r1.rid != r2.rid:
        if not r2 in ignore:
          tmp = i.distance(r1,r2,cols,f)
          if better(tmp, d):
            out,d = r2,tmp
    return out
    
  def closest(i,r1,cols=None,f=None,ignore=set()):
    return i.furthest(r1,cols=cols,f=f,better=less, init=10**32,ignore=ignore)        


# ##########
# faster equality test

    def find_nearest(self, row) :
        nearest = None
        distance = sys.maxint
        for r in self.rows:
            if r != row:
                current_distance = self.row_distance(row, r)
                if distance >= current_distance:
                    nearest = r
                    distance = current_distance
        return nearest
        
# welcome to rid        
class Row(Pretty):
  rid = 0
  def __init__(i,lst):
    i.rid = Row.rid = Row.rid+1
    i.contents=lst
    i.labelled=False
  def __repr__(i)       : return '#%s,%s' % (i.rid,i.contents)
  def __getitem__(i,k)  : return i.contents[k]
  def __setitem__(i,k,v): i.contents[k] = v
  def __len__(i)        : return len(i.contents)
  def __hash__(i)       : return i.rid #hash(set(i.contents))
  def __eq__(i,j)       : return i.rid == j.rid
  def __ne__(i,j)       : return not i.__eq__(j)
  
##########################
# why convenince lists


  def add( self, x):
    if( self.invalid ) :
      return 

    try :
      x = float(x)
    except Exception:
      self.invalid = True
      return

    self.n += 1
    self.max = max( self.max, x )
    self.min = min( self.min, x )

    delta    = x - self.mu
    self.mu  += delta/self.n
    self.m2  += delta*(x - self.mu)
    return x 

# e: ech column is a thing whose "my" initializes to None
# if my is None, then work out type and the right thing
# if mu is not Noen then fast to work out

class Thing(Summary):
  "some thing that can handle  Nums or Syms"
  UNKNOWN = "?"
  def __init__(i,pos,txt=None):
    txt = txt or pos
    i.txt, i.pos, i.my, i.samples = str(txt), pos, None, Sample()
  def sample(i):
    return i.samples.sample()
  def add(i,x):
    if x != Thing.UNKNOWN:
      if i.my is None:
        x,what  = atom2(x)
        i.my = what() # Num() or Sym()
      x = i.my.add(x)
      i.samples.add(x)
    return x
    
def atom2(x)  :
  try: return float(x),Num
  except ValueError: return x,Sym
