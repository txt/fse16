[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Review 5

## K-th Nearest Neighbors


Make the case the Knn suffers from the following problems:

+ They are computationally expensive (in terms of run time and memory)
+ They are intolerant of attribute noise.
+ They are intolerant of irrelevant attributes.
+ They are sensitive to the choice of the algorithm's similarity function.
+ They provide little usable information regarding the structure of the data
+ There is no natural way to work with nominal-valued attributes or missing attributes

Aha's 1991 distance measure:

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
```
    
+ How does it handle missing values and non-numerics?
+ What is normalization and what is its role in Aha's algorithm?
+ What is the euclidean measure and what is its role in Aha's algorithm?
+ I prefer dividing the results of Aha's distance measure by `sqrt(#dimensions)`. Why?

## Naive Bayes

### Naive Bayes

Write down a table of data with with 5 rows and three columns and one
class where column 2 is tightly correlated to column 1. With respect
to this data, answer:

+ Why is Naive Bayes called Naive?
+ Why is Naive Bayes fast?

Write down Bayes' theorem, carefully defining all terms.
With respect to the following data, write
down examples of all terms in the theorem.

    outlook  temperature  humidity   windy   play
    -------  -----------  --------   -----   ----
    rainy    cool        normal    TRUE    no
    rainy    mild        high      TRUE    no
    sunny    hot         high      FALSE   no
    sunny    hot         high      TRUE    no
    sunny    mild        high      FALSE   no
    overcast cool        normal    TRUE    yes
    overcast hot         high      FALSE   yes
    overcast hot         normal    FALSE   yes
    overcast mild        high      TRUE    yes
    rainy    cool        normal    FALSE   yes
    rainy    mild        high      FALSE   yes
    rainy    mild        normal    FALSE   yes
    sunny    cool        normal    FALSE   yes
    sunny    mild        normal    TRUE    yes

Using a Naive Bayes classifier, 
classify the following test example. Show all working:

    Outlook       Temp.           Windy        
    Sunny         Cool            True         

How does Naive Bayes handle missing data in the test example?

The following Python code manages the `like` computation.

+ For what to different kind of data would this new function fail? 
+ What is the purpose of the K and M variables?

```python
def like(row, all, klasses):
  "top-level pything function"
  guess, best, nh, k = None, -1*10**32, len(klasses), THE.nbk
  for this,tbl in klasses.items():
    guess = guess or this
    like  = prior = (len(tbl._rows)  + k) / (all + k * nh)
    for col in tbl.decs:
      if col.my:
        x = row[col.pos]
        if x != Thing.UNKNOWN:
          like *= col.my.like( x, prior) # see code, below
    if like > best:
      guess,best = this,like
  return guess

"Num class..."
  def like(i,x,*_):
    var   = i.sd()**2
    denom = (2*math.pi*var)**.5
    num   = math.exp(-(x-i.mu)**2/(2*var))
    return num/denom

"Sym class..."
  def like(i,x,prior):
    m = 2  
    return (i.counts.get(x,0) + m*prior)/(i.n + m)
```

- In the above, using diagrams showing specific examples can you explain what is going:
     - in `Num.like` 
     - in `Sym.like`
     
## Data Structures

`Num` and `Sym` class

- These classes have four groups of servives. For each, describe when thy ,ight be useful:
   - `add,sub`
   - variability
   - `like`
   - `dist`
- How is _variability_ different for `Num` and `Sym`?

`Table` class

- This class creates one `Num` or `Sym` object per header then stores that object in one or more "convenience" lists. For each of the following, describe when they do and when you might proces sthem different to other columns:
     - `cols`
     - `objs` (hint: not for standard data mining, but for optimization)
     - `klass` (hint: not for optimziation)
     - `deps` (hint: dependent variables)
     - `decs` (hint: independent variables)
 - `Table`'s distance function is shown below.
     - When computing distance between rows in -means, the `klass` is _not- used.  Why?   
     - For `Num` and `Sym` write down in English how `dist` might work (3rd last line). Remember normalization!    
     - Under what circumstances would `n` be less that the number of independent attributes?
     - What is point of dividing the sum of the distance by _n\*\*(1/f)_?

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
```

- How might the following algorithms use `Table`?
      - Naive Bayes
      - Mini-batch K-means
      - Reading data from disk
      - Incrementally processing data in `eras` of 1000 instances per era

