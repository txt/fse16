
[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Lecture 3

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

- Tables have `rows` and there are `cols`umns.
- Table headers summarize the content of each `col[i]`.
- When a row is thrown at tables, then the `col[0], col[1]....`
  summaries are all incrementally updated.

Tables are highly reusable:

- When we store disk data in RAM, it can be stored in a `Table`.
- When we cluster RAM data, we make one `Table` per cluster.
- Discretization is the process of compressing extended numeric range into a small number of bins.
    - When discretize one `Table`, we are building another `Table`.
    - The original `Table` will have some combination of `Num`bers and `Sym`bols;
    - The final `Table`'s independent variables contain only `Sym`bols.
- When we build a nearest neighbor classifier, we use information in the
  summaries to compute distances between rows.
- When we do decision tree learning,
    - When we are testing what attribute is best to branch on, we are querying the column summaries.
    - We push data down each branch, the branch data is stored in sub-`Table`s.
- When we build a Naive Bayes classifier:
    - We collect all rows of the same class into different `Table`s, one per class.
    - When we ask which class is most like the new example, we are
      querying the column summaries in the different tables.

## Columns are Things Containing Either Nums or Syms

Some details:

- The first row is assumed to contain the names of the columns.
- The subsequent rows contain either `Num`bers or `Sym`bols or unknown values (marked with a "?").
- Column rows have a type (`Num` or `Sym`) which is determined by the first thing in each column that is not unknown.

Which means that we won't know that type of a column till we `add` that first
not unknown value.

Before that, columns area `Thing`. On creation, `Thing`s can be initialized with
any number of `init` values.

```python
class Summary(Pretty):
  def __init__(i,init=[]):
    i.reset()
    map(i.add,init)

class Thing(Summary):
  UNKNOWN = "?"
  def __init__(i,pos,txt=None):
    txt = txt or pos
    i.txt, i.pos, i.my = str(txt), pos, None
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

### Nums and Syms

Nums and Syms are column headers that know how to

- `add` and `sub` new values
- find the `dist` between values
     - using `norm,dist,furthest`

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
  def sd(i):
    return 0 if i.n <= 2 else (i.m2/(i.n - 1))**0.5
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
  def like(i,x,*_):
    var   = i.sd()**2
    denom = (2*math.pi*var)**.5
    num   = math.exp(-(x-i.mu)**2/(2*var))
    return num/denom
```

`Sym`s:

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
  def norm(i,x)   : return x
  def dist(i,x,y) : return 0 if x==y else 1
  def furthest(i,x): return "SoMEcrazyTHing"
  def like(i,x,prior):
    return (i.counts.get(x,0) + THE.nbm*prior)/(i.n + THE.nbm)
  def k(i):
    return len(i.counts.keys())
  def ent(i):
    tmp = 0
    for val in i.counts.values():
      p = val/i.n
      if p:
        tmp -= p*math.log(p,2)
    return tmp
```
