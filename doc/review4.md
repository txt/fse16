[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Review 4

## Theory

To assess something, you need to understand the why of that that thing and whether or not that thing satisfies that why.
In class, we discussed some "whys" (and here are some more). Explain them here and determine how you would assess them (Specifically,
how would you determine if they are not working). Do you know any research
papers that address these whys?

- Eclipse (hint: programmer patterns)
- Git  (hint: value of distributed development over centralized development)
- Scrums (hint: requirements volatility)
- Databases (SQL or noSQL): [data independence](https://en.wikipedia.org/wiki/Data_independence)

Can you think of any other whys?

## Clustering

What is the difference between independent and dependent variables?

Explain:

- Standard clustering (e.g. k-means) group data using the independent variables
- Decision trees group data using the dependent variables.

**Unsupervised spatial trees** (a.k.a. clustering on independent variables):

- Draw 3 seperate squares. Imagine the dimensions of those  box are indendent variables
       - In square1  write  dots uniformly across the square. Is this kind of data suitable for clustering?
       - In square2, write down numbers 1,2,3,4 representing data that would fall naturally into k-means for k=4.
       - In square3, write down numbers 1,2,3,4 representing data that would fall naturally into a recursive k-means for k=2.

**Supervised spatial trees** (a.k.a. decision trees):

- Draw 2 more squares. Imagine the dimensions of those  box are indendent variables
      - In square4 write down little circles and squares that would be easily seperated by a decision tree
      - In square5 write down a circle of triangles surrounded by squares. Why would starndard decision tree learners have trouble with that shape?
      
When we recursively sub-divide data, we may use some stopping rule; e.g. do not divide a space containing less than _M=10_ examples.

- What are the costs and benefits of using small M?
- What are the costs and benefits of using large M?

Write down, if 2-4 lines, how mini-batch k-means works.

- Why is it so fast?


## Statistics

**Parametrics:** Given a list _n_ items long containing _x1,x2... xn_, write down:

- the mean
- the standard deviation
- Draw a diagram that shows L1,L2 with
         - small mean difference
         - small standard deviation
         - low sample size
- Given two lists L1, L2, write down a _delta_ equation  that is _larger_ given:
         - a large sample
         - a larger mean difference
         - smaller values of the standard deviation in the two lists

**Non-Parametrics:*

- Bill Gates meets 5 homeless people. What is their mean/median salary (hint: Bill Gate's net worth: 79.3 billion)
- Compute the median of the following five lists
  
        ["x1",0.34, 0.49, 0.51, 0.6],
        ["x2",0.6,  0.7,  0.8,  0.9],
        ["x3",0.15, 0.25, 0.4,  0.35],
        ["x4",0.6,  0.7,  0.8,  0.9],
        ["x5",0.1,  0.2,  0.3,  0.4] ])

**A12 test**

- Write down the A12 test (ignoring efficiency)
- Officially, the A12 effects divide into large, medium,small at A12= 71,64,56. Given that:
      - What is the threshold below which an effect is closest to _small_
- Write down two lists of numbers that are easily seperated by A12
- Write down two lists of numbers that are _NOT_ easily seperated by A12
- The following code is a faster version of A12. Why?

```python
def a12(lst1,lst2,enough=0.6):
  "how often is x in lst1 more than y in lst2?"
  class o():
    def __init__(i,**fields) : i.__dict__.update(d)
  #--------------------------
  def loop(t,t1,t2):
    while t1.j < t1.n and t2.j < t2.n:
    h1 = t1.l[t1.j]
    h2 = t2.l[t2.j]
    h3 = t2.l[t2.j+1] if t2.j+1 < t2.n else None
    if h1>  h2:
      t1.j  += 1; t1.gt += t2.n - t2.j
    elif h1 == h2:
      if h3 and h1 > h3 :
        t1.gt += t2.n - t2.j  - 1
        t1.j  += 1; t1.eq += 1; t2.eq += 1
    else:
      t2,t1  = t1,t2
    return t.gt*1.0, t.eq*1.0
  #--------------------------
  lst1 = sorted(lst1, reverse=True)
  lst2 = sorted(lst2, reverse=True)
  n1   = len(lst1)
  n2   = len(lst2)
  t1   = o(l=lst1,j=0,eq=0,gt=0,n=n1)
  t2   = o(l=lst2,j=0,eq=0,gt=0,n=n2)
  gt,eq= loop(t1, t1, t2)
  return gt/(n1*n2) + eq/2/(n1*n2)  >= enough
```
  
**Bootstrapping**

- Given the list L1=(1,2,3,4)  write L1a, L1b, L1c being  three samples with replacement (SWR) for L1.
- Given the list L2=(3,4,5,6)    write L2a, L2b, L2c being  three samples with replacement (SWR) for L2. 
- What is the _test statistic_ _T_ in bootstrapping ? In 2 lines or less, propose  a test statistic (Hint: it accepts pairs of lists
  T(L1,L2), T(L1a,L2a),  T(L1b,L2b), etc).
- Bootstrapping computes the test statistic on the raw lists ts0=T(L1,L2)  then $N$ times on  ts1=T(L1a,L2a),  ts2=T(L1b,L2b). It
  counts how many times ts1,tw2, etc are bigger than ts0. Why do we care?
- How many SWRs are required to check for a statistically significant difference between two lists of numbers?

**Scott-Knott:**

- Sort the above lists x1,...x5 on their median value
- Those lists define into three regions. Label them according to their regions.
- Scott-Knott sorts lists then divides them such that the divisons maximize the expected value of the difference in mean scores before
and after the division
      - Using x1,x2...x5, compute the FIRST division made by Scott-Knott. Show all your working.
- After dividing, Scott-Knot recruses on each divisions.
      - Show one such second-level division

## Displaying experimental results

Walk through the following list and descibe an observation at each item that would stop you doing the rest.

- Visualize the data, somehow.
- Check if the central tendency of one distribution is better than the other; e.g. compare their median values.
- Check the different between the central tendencies is not some small effect.
- Check if the distributions are significantly different;

In the above list, why check for small effect before doing the bootstrap?

## Tuning

List some magic tuning parameters for

- Any learner (hint: train/test size; stratified vs raw sampling; discretization)
- K-NN classifiers (for details on that, see section 2.2 of [the TEAK paper](http://menzies.us/pdf/10teak-v1.pdf)
- Decision tree learners
- Random forests

Here's pseudo-code for an optimizer called differential evolution (fyi- a [full working version](https://github.com/txt/ase16/blob/master/src/ase.py#L1209-L1235) is on-line):

```python
def any(n)       : # returns a number 0.... n-1
def ok(x)        : # returns true of false if the decisions in x are value
def score(x)     : # returns 1 or more objective scores for decisions in x
def better(this,that): # return True if this is  preferred to that
#-------------------------------------------------------------
cf          = 0.5 # probability of crossing over during mutation
f           = 0.5 # how "far" we cross over
generations = 25
np          = decisions*10
budget      = np*generations  # when to stop
pop         = [ anything() for _ in 1,np ]
scores      = { id(x) : score(x) for x in pop }
while budget > 0:
  for i,mum in enumerate(pop):
    a,b,c = pop[ any(np) ], pop[ any(np) ], pop[ any(np) ]
    kid   = mum[:]  # copy dad
    for j,(a1,b1,c1) in enumerate( zip(a,b,c) ):
       if rand() >  cf:
          if isa(a1,float):  
             kid[j]  = a1 + f*(b1-c1)
         else:
             kid[j]  = a1 if r() > f else (b1 if r() > f else c1)    
    j = any(decisions)
    kid[j] = mum[j] # mum has at least one item from kid
    if ok(kid):
      scores[id(kid)] = score(kid)
      budget = budget - 1 
      if better(kid, mum):
         pop[i] = kid
return pop
```

In the above, _better_ is a little complicated. Given
several objectives collected in _this_ and _that_,
we consider each objective _x,y_ indivdually in _this_ and _that_
and look at what at _loss_ if we travel from _this_ to _that_
versus _that_ to _this_ (and the one we prefer is the one
that _loss_es least).

- First, we normalize _x,y_ to  0..1
- Then we adjust the direction of the comparison depending on
  whether or not we are _minimizing_ that objective.
- Third, we raise the differences _x - y_to some exponential (i.e.
  the larger the difference, the louder we shout!)
- Lastly, we return the mean loss over all objectives.
  

```python
def (i):      # return less for minimize and more for maximize
def norm(i,x): # returns (x - lo) / (hi - lo) where lo and hi
               # are the min,max values for objective i

def better(this, that):
  x  = scores[ id(this) ]
  y  = scores[ id(that) ]
  l1 = loss(x,y)
  l2 = loss(y,x)
  return l1 < l2

def loss(x, y):
  losses= 0
  n = min(len(x),len(y))
  for i,(x1,y1) in enumerate(zip(x,y)):
    x1 = norm(i,x1),
    y1 = norm(i,y1)
    losses += expLoss( i,x1,y1,n ) 
  return losses / n

def expLoss(i,x1,y1,n):
  "Exponentially shout out the difference"
  w = -1 if minimizing(i) else 1
  return -1*math.e**( w*(x1 - y1) / n )
  
```      
       
