[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______



# Homework3

## Extend Your Table Code

### Normalize Numbers

Extend your `Table` reader (from last week) with methods to "normalize" numbers
and return distances between numbers

```python
class Num
 ...
 def norm(i,x):
    tmp= (x - i.lo) / (i.up - i.lo + 10**-32)
    if tmp > 1: return 1
    elif tmp < 0: return 0
    else: return tmp
  def dist(i,x,y):
    return i.norm(x) - i.norm(y)
  def furthest(i,x) :
    return i.up if x <(i.up-i.lo)/2 else i.lo

```

### Normalize Symbols

Extend your `Sym` class (from last week) to "normalize" symbols  (actually, to do nothing at all)

```python
class Sym
  ...
  def norm(i,x)   : return x
  def dist(i,x,y) : return 0 if x==y else 1
  def furthest(i,x): return "SoMEcrazyTHing"
```

### Implement distance between two rows

Implement Aha's algorithm (http://goo.gl/ZspOeL, p42, first para)
for the distance between two rows in a table of data
(where the columns are symbols or numbers)

For what its worth, here's that code from one of my tools:

- missing values are denoted "?"
- my `i.cols` headers contain the column numbers of the headers. So `r1[col.pos]`
means "ask my column header where to look in the row".
- All my `i.cols` `Num`s or `Sym`s so i can defer to them to find the distances
- I divide Aha's
  term by _n^1/2_ (where n is th e number of variables) so that my distances
  range 0 to 1.


```
 UNKNOWN = "?"
 def distance(i,r1,r2,f=2):
    d,n = 0, 10**-32
    for col in i.cols:
      x, y  = r1[col.pos], r2[col.pos]
      if x is UNKNOWN and y is UNKNOWN:
        continue
      if x is UNKNOWN: x=col.my.furthest(y)
      if y is UNKNOWN: y=col.my.furthest(x)
      n    += 1
      inc   = col.dist(x,y)**f
      d    += inc
    return (d**(1/f)) / (n**(1/f))
```

### Test

For data/weather, for the first two rows, find the nearest and furthest rows

Important note: in the distance calc, do not include the dependent variable (the class).
Distance is usually computed between independent variables.

### Integrated into Ninja.rc

Using the tricks explored last week.



### What to hand in

Code

Example output from _Test_. Make you print out rows1,2 and, for each, print the row
closest and furthest away.
