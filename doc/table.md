
[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Software Abstractions: Table

Data miners are software. Software scientists are software
engineers. Software engineers know how to maintain and
improve software, including data miners.

The key to understanding software is patterns-
useful cliches in data structures.

## This Code

This full version of this code all works (see
[ase.py](https://github.com/txt/ase16/blob/master/src/ase.py)). But
in the following code is manually edited (to cull some dull bits)
in order to make the exposition easier.  So the following code
_may_ have some bugs. 

## Tables

Many, many things are a `Table`.

- Tables have rows and columns.
- Table headers summarize the content of each _column[i]_.
- When a row is thrown at tables, then the _column[0], column[1]...._
  summaries are all incrementally updated.

Tables are highly reusable:

- When we store disk data in RAM, it can be stored in a `Table`.
- When we cluster RAM data, we make one `Table` per cluster.
- Discretization is the process of compressing extended numeric range into a small number of bins.
    - When discretize one `Table`, we are building another `Table`.
    - The original `Table` will have some combination of `Num`bers and `Sym`bols;
    - The final `Table`'s independent variables contain only `Sym`bols.
- Prototype generation is the process of finding a (small) number of exemplary examples, thereby focusing
  the reasoning, removing outliers, and speeding up all subsequent processing
    - When we generate prototypes, some new `Table` is built from just the most interesting examples
      from a prior table.
- When we build a nearest neighbor classifier, we use information in the
  summaries to compute distances between rows.
- When we do decision tree learning,
    - When we are testing what attribute is best to branch on, we are querying the column summaries.
    - We push data down each branch, the branch data is stored in sub-`Table`s.
- When we build a Naive Bayes classifier:
    - We collect all rows of the same class into different `Table`s, one per class.
    - When we ask which class is most like the new example, we are
      querying the column summaries in the different tables.

    


### Some Details: `like` and `dist`

Two things shown below is code for `like` and `dist`.

#### Understanding `like`

To understand `like`, think of a new value arriving into a a space of old values.

- Assume the old values are somehow divided up "least common" to "most common";
- The more we `like` something, the more it calls towards "most common".

So if the values are `Sym`bols, then we report the ratio at which this new value appeared
within the old. For example, a `Sym` holding the following distribution would `like`
"blue" twice as much as "green":
then 

![](https://faculty.elgin.edu/dkernler/statistics/ch02/images/freqbar.jpg)

And if the old values are `Num`bers, then we assume a normal bell shaped curve and report
where the new values falls "up the hill" towards the mean. That way, if we are trying
to decode which distribution we fall into, we can report the one where we fall "highest up".
For example, if the following two distributions were held as two different `Num`s (one for male
and one for female), then females  `like` x=160 much more than males (and they both `like` x=170 the same amounts).

![](https://qph.ec.quoracdn.net/main-qimg-7ca1b9aeab2a1ef304aa5df52b2f9524?convert_to_webp=true)

#### Understanding `dist`

To understand the `dist` stuff, lets just preview at little bit of code from the
end of this file. This code computes the distance between 2 rows in a table.
In English, the following is Euclidean `dist`ance measure between the `n` number of `x,y` values
inside `r1,r2`. And if either `x,y` is UNKNOWN, then assume the worst case (maximum distance to
the `furthest` value).

```python
    f    = 2
    d,n = 0, 10**-32
    for col in cols:
      x, y  = r1[col.pos], r2[col.pos]
      if x is Thing.UNKNOWN and y is Thing.UNKNOWN:
        continue
      if x is Thing.UNKNOWN: x=col.my.furthest(y)
      if y is Thing.UNKNOWN: y=col.my.furthest(x)
      n    += 1
      inc   = col.my.dist(x,y)**f
      d    += inc
    return d**(1/f)/n**(1/f)
```

Why the last line where we divide by `n**0.5`? Well, that ensures that our
numbers fall 0..1 which simplifies a lot of other calculations.

### Columns are `Thing`s Containing Either `Num`s or `Sym`s

Some details:

- The first row is assumed to contain the names of the columns.
- The subsequent rows contain either `Num`bers or `Sym`bols or unknown values (marked with a "?").
- Column rows have a type (`Num` or `Sym`) which is determined by the first thing in each column that is not unknown.

Which means that we won't know that type of a column till we `add` that first not unknown value.

Before that, columns are a `Thing`. On creation, `Thing`s can be initialized with
any number of `init` values.

All my classes inherit from `Pretty` which is a little detail we can ignore (but if you have to know-- see end of this page).

```python
class Summary(Pretty):
  def __init__(i,init=[]):
    i.reset()  
    map(i.add,init)
  def reset(i):  # implemented by sub-class
    pass
  
class Thing(Summary):
  UNKNOWN = "?"
  def __init__(i,pos,txt=None):
    txt = txt or pos
    i.txt, i.pos  = str(txt), pos
    i.my = None # at creation, don't know if this is Num or Sym, yet
  def add(i,x):
    if x != Thing.UNKNOWN:
      if i.my is None:
        x,what  = atom2(x)
        i.my = what()
      x = i.my.add(x)
    return x

def atom2(x)  :
  try: return float(x),Num
  except ValueError: return x,Sym
```

_____

### Nums and Syms

Nums and Syms are column headers that know how to

- `add` and `sub` new values to the summary
- compute the variability of the `add`ed values
- find how much this summary `like` some value
- find the `dist` between values
    - using `norm,dist,furthest`


    
_____

#### Num

```python
class Num(Summary):
  def reset(i):
    i.mu,i.n,i.m2,i.up,i.lo = 0,0,0,-10e32,10e32
  def add(i,x):
    i.n += 1
    x = float(x)
    if x > i.up: i.up=x
    if x < i.lo: i.lo=x
    delta = x - i.mu
    i.mu += delta/i.n
    i.m2 += delta*(x - i.mu)
    return x 
  def sub(i,x):
    i.n   = max(0,i.n - 1)
    delta = x - i.mu
    i.mu  = max(0,i.mu - delta/i.n)
    i.m2  = max(0,i.m2 - delta*(x - i.mu))
```
Here's the `Num` variability measure:     
```python
  def sd(i):
    return 0 if i.n <= 2 else (i.m2/(i.n - 1))**0.5
```
Here's the `Num` distance methods:    
```python    
  def norm(i,x):
    if not THE.raw:
      tmp= (x - i.lo) / (i.up - i.lo + 10**-32)
      if tmp > 1: return 1
      elif tmp < 0: return 0
      else: return tmp
    return x
  def dist(i,x,y):
    return i.norm(x) - i.norm(y)
  def furthest(i,x) :
    return i.up if x <(i.up-i.lo)/2 else i.lo
```
Here's the `Num` `like` method (which reports how far "up the hill" you are of a Gaussian curve):

```python
  def like(i,x,*_):
    var   = i.sd()**2
    denom = (2*math.pi*var)**.5
    num   = math.exp(-(x-i.mu)**2/(2*var))
    return num/denom
```

Note that `like` never returns zero (just very,very small numbers if we are far away from the mean).
____

#### Syms

```python
class Sym(Summary):
  def reset(i):
     i.counts, i.most, i.mode, i.n = {},0,None,0
  def add(i,x):
    i.n += 1
    new = i.counts[x] = i.counts.get(x,0) + 1
    if new > i.most:
      i.most, i.mode = new,x
    return x
  def sub(i,x):
    i.n -= 1
    i.counts[x] -= 1
    if x == i.mode:
      i.most, i.mode = None,None
```
Here's the `Sym` variability measure:     
```python
  def ent(i):
    tmp = 0
    for val in i.counts.values():
      p = val/i.n
      if p:
        tmp -= p*math.log(p,2)
    return tmp
```
Here's the `Sym` `distance` methods:
```python
  def norm(i,x)   : return x
  def dist(i,x,y) : return 0 if x==y else 1
  def furthest(i,x): return "SoMEcrazyTHing"
```
Here's the `Sym` `like` method:
```python
  def like(i,x,prior):
    m = 2  
    return (i.counts.get(x,0) + m*prior)/(i.n + m)
```
    
In the above, the `m` and `prior` stuff is some math tricks for handling very low frequency calculations.
Without it, `like` could return zero which  means that we multiplying together many `like` values
then one very rare one would zap out all the others, even if the others are `like`d a lot.

____

### And Finally Here's the Table Class

In the header row, column attributes can contain certain magic symbols denoting their purpose in life.
For example:

```
outlook, ?temperature-, <humidity, windy,=play
sunny, 	85,    	85,    	FALSE, 	0
sunny, 	80,    	90,    	TRUE,  	0
overcast,83,   	86,    	FALSE, 	2
rainy, 	70,    	96,    	FALSE, 	1
rainy, 	68,    	80,    	FALSE, 	1
rainy, 	65,    	70,    	TRUE,  	0
overcast,64,   	65,    	TRUE,  	2
sunny, 	72,    	95,    	FALSE, 	0
sunny, 	69,    	70,    	 FALSE,	2
rainy, 	75,    	80,    	FALSE, 	3
sunny, 	75,    	70,    	TRUE,  	2
overcast,72,   	90,    	TRUE,  	1
overcast,81,   	75,    	FALSE, 	1
rainy, 	71,    	 91,   	 TRUE, 	 0
```

 

Here's a simple high-level drive that concerts test-based tables
to RAM-based tables.

```python
def csv2table(file):
  tbl= Table()
  for row in rows(file): # "rows" defined at the end of this file
    tbl(row)
  return tbl
```    

The following code handles all the internal details of converting text files
to RAM-based files. 
Recall that

- The first row is assumed to contain the names of the columns.
- The subsequent rows contain either `Num`bers or `Sym`bols or
  unknown values (marked with a "?").
- Some columns have a name marked with a "-" which means
  lets skip that column.
- When we use a `Table` we often run through special subsets
  of the columns, e.g. just the numbers. So when we are reading the header row,
  we place our `Thing`s into several groups.

| group  | example        | purpose  |        contains| notes                              |
|--------|:---------------|----------|----------------|:-----------------------------------|
| `cols` |                | getters  |  `Num`s `Sym`s | All headers                        |
| `objs` | >speed  <cost  |objectives| `Num`s         | All the numeric target variables.  |
| `klass`| =disease       | class    | `Sym`s         | The symbolic target attributes     |
| `deps` |                |dependents| `Num`s `Sym`s  |` `deps` = objs` + `klass`                    |
| `decs` |                |decisions | `Num`s `Sym`s  | `decs` = `gets` - `objs` - `klass`. Everything that is not an objective or a klass (i.e. all the independent variables) |

Note that:

- This means that the _same_  `Num` or `Sym` can appear in multiple groups.
- All `objs` are paired with a goal statement; i.e. do we want `more` or `less` of this objective.

```python
class Table(Pretty):
  MORE  = ">"  # objectives to maximize
  LESS  = "<"  # objectives to minimize
  KLASS = "="  # klasses to predict for
  SYM   = "!"  # symbols (non-numerics)
  SKIP  = "-"  # columns to skip over
  #-----------------------------------
  DIST  = {    # when doing distant calcs, use either decisions or objectives.
           'decs' : lambda tbl:tbl.decs,
           'objs' : lambda tbl:tbl.objs}[THE.dist]
  def __init__(i,inits=[]):
    i._rows = []
    i.cost = 0
    i.cols,  i.objs, i.decs = [], [], []
    i.klass, i.gets, i.dep  = [], [], []
    map(i.__call__, inits)
```
The make `Table` update function uses `__call__`:
```python
  def __call__(i,row):
    if i.cols:   # if exists, then we have already seen the header
      row     = [i.cols[put].add(row[get])  # adding the row updates all the headers
                 for put,get in enumerate(i.gets)]
      row     = Row(row)
      i._rows += [ row ]
    else:
      for get,cell in enumerate(row):
        if cell[-1] != Table.SKIP:
          i.gets += [get]
          col     = Thing(len(i.cols) , cell)
          i.cols += [col]
          if   cell[0] == Table.MORE  : i.objs  += [(col,more)]
          elif cell[0] == Table.LESS  : i.objs  += [(col,less)]
          elif cell[0] == Table.KLASS : i.klass += [col]
          else                        : i.decs  += [col]
          #---------------------------------------
          for col,_ in i.objs  : i.dep   += [col]
          for col   in i.klass : i.dep   += [col]
          if cell[-1] == Table.SYM:
            col.my = Sym()
    return row
```
In the above, `gets` is a tedious low-level thing. Some columns are marked as `SKIP`

Here's the `Table` distance calcs:
```python
  def distance(i,r1,r2,cols=None,f=None):
    cols = cols or Table.DIST(i)
    f    = f    or THE.edist
    d,n = 0, 10**-32
    for col in cols:
      x, y  = r1[col.pos], r2[col.pos]
      if x is Thing.UNKNOWN and y is Thing.UNKNOWN:
        continue
      if x is Thing.UNKNOWN: x=col.my.furthest(y)
      if y is Thing.UNKNOWN: y=col.my.furthest(x)
      n    += 1
      inc   = col.my.dist(x,y)**f
      d    += inc
    return d**(1/f)/n**(1/f)
  #---------------------------------    
  def furthest(i,r1,cols=None,f=None, better=more,init= -1,ignore=set()):
    out,d = r1,init
    for r2 in i._rows:
      if r1.rid != r2.rid:
        if not r2 in ignore:
          tmp = i.distance(r1,r2,cols,f)
          if better(tmp, d):
            out,d = r2,tmp
    return out
  #---------------------------------    
  def closest(i,r1,cols=None,f=None,ignore=set()):
    return i.furthest(r1,cols=cols,f=f,better=less,
                         init=10**32,ignore=ignore)
```
Here's some misc `Table` utilities:
```Python
  def isa(i,row):
    "Return the class of this rows."  
    return row[ i.klass[0].pos ]
  def clone(i,inits=[]):
    """Create a new blank table with 
       the same header as this table."""
    tbl = Table()
    tbl([col.txt for col in i.cols])
    map(tbl.__call__,inits)
    return tbl
```


## Top-Level Drivers

KNN and Naive Bayes... in 10 lines (ish).

```python
def knn(train=THE.train,test=THE.test): return learn(knn1,train,test)
def nb( train=THE.train,test=THE.test): return learn(nb1, train,test)

def learn(what, train, test):
  print(train,test)
  for actual, predicted in what(train, test):
    print(actual, predicted)

def knn1(train,test):
  tbl = arff2table(train)
  k   = tbl.klass[0].pos
  for _,r1 in arff2rows(test):
    r2 = tbl.closest(r1)
    yield r1[k],r2[k]
    
def nb1(train,test):
  klasses = {}
  for all,(tbl1,row) in enumerate(arff2rows(train)):
    k = tbl1.isa(row)
    if not k in klasses:
      klasses[k] = tbl1.clone()
    klasses[k](row)
  for tbl2,row in arff2rows(test):
    yield tbl2.isa(row), like(row,all,klasses)
```

Here's the `like` function used by `nb1` that multiplies together all the
`like` of all the different columns.

```python
def like(row, all, klasses):
  guess, best, nh, k = None, -1*10**32, len(klasses), THE.nbk
  for this,tbl in klasses.items():
    guess = guess or this
    like  = prior = (len(tbl._rows)  + k) / (all + k * nh)
    for col in tbl.decs:
      if col.my:
        x = row[col.pos]
        if x != Thing.UNKNOWN:
          like *= col.my.like( x, prior) # mult together all the likes
    if like > best:
      guess,best = this,like
  return guess
```    

## Low-level Details

### Support Utilities For reading Tables from CSV files

```python
def atoms(lst):
  "Convert strings to ints,floats,string."
  def atom(x)  :
    try: return int(x)
    except:
      try: return float(x)
      except ValueError:
        return Sym
        return map(atom,lst)
        
def rows(file,prep=atoms):
  "Kill comments, white space, blank lines,divide rows on ','"        
  with open(file) as fs:
    for line in fs:
      line = re.sub(r'([\n\r\t]|#.*)', "", line)
      row = map(lambda z:z.strip(), line.split(","))
      if len(row)> 0:
         yield prep(row) if prep else row


```
    
### Tables have Rows

`Row`s are Python arrays, plus some inferred values and a unique
id called `rid`.

- `rid` lets us do set membership very quickly.

The array `i.contents` holds that array and most of the `Row`s
methods are traffic cops that redirect queries to `Row` down to
`i.contents`.

```python
class Row(Pretty):
  rid = 0
  def __init__(i,lst):
    i.rid = Row.rid = Row.rid+1
    i.contents=lst
  def __repr__(i)       : return '#%s,%s' % (i.rid,i.contents)
  def __getitem__(i,k)  : return i.contents[k]
  def __setitem__(i,k,v): i.contents[k] = v
  def __len__(i)        : return len(i.contents)
  def __hash__(i)       : return i.rid 
  def __eq__(i,j)       : return i.rid == j.rid
  def __ne__(i,j)       : return not i.__eq__(j)
```


### Everything is Pretty


All my classes inherit from `Pretty` that prints attributes, sorted, while
hiding any private attributes (marked with a leading `_`).

```python
def kv(d, private="_"):
  def _private(key):
    return key[0] == private
  def pretty(x):
    return round(x,3) if isinstance(x,float) else x
  return '('+', '.join(['%s: %s' % (k,pretty(d[k]))
          for k in sorted(d.keys())
          if not _private(k)]) + ')'
          
class Pretty(object):
  def __repr__(i):
    return i.__class__.__name__ + kv(i.__dict__)
```



