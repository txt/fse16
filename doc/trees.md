[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______


Decision Trees
--------------

Bayes classifiers *perform* but they do not *explain* their performance.
If you ask "what is going on? how does it make its decisions?", there's
no answer except to browse the complicated frequency count tables.

Q: So, how to learn a *decision tree* whose leaves are classifications
and whose internal nodes are tests on attributes?

        curb-weight <= 2660 : 
        |   curb-weight <= 2290 : 
        |   |   curb-weight <= 2090 : 
        |   |   |   length <= 161 : price=6220
        |   |   |   length >  161 : price=7150
        |   |   curb-weight >  2090 : price=8010
        |   curb-weight >  2290 : 
        |   |   length <= 176 : price=9680
        |   |   length >  176 : 
        |   |   |   normalized-losses <= 157 : price=10200
        |   |   |   normalized-losses >  157 : price=15800
        curb-weight >  2660 : 
        |   width <= 68.9 : price=16100
        |   width >  68.9 : price=25500

### Preliminaries: Entropy

-   entropy of a bunch of symbols occurring with probability p1, p2, ...
    then   
        - entropy(p1,p2,...) = &Sigma; -p * log2(p)
		- btw, log2 = log base 2
-   Hints:
    -   if your favorite programming language has no "base 2", then use
        log2(x)=log(x)/log(2)
    -   If "x" occurs f times in a sample of size "n", then "p = f/n"
-   Examples:
    -   Entropy of 2 apples and 3 oranges:  
         entropy(2/5,3/5) = -2/5 * log(2/5) - 3/5 * log(3/5) = 0.971
        bits
    -   Entropy of 4 apples and no oranges:    
         entropy(4/4,0/4) = entropy(1) = 0 (i.e. no mixed up)

-   Simplification trick:
    -   entropy([2/9,3/9,4/9])     
         = -2/9 * log(2/9) - 3/9 * log(3/9) - 4/9 * log(4/9)   
         = [ -2 * log(2) - 3 * log(3) - 4 * log(4) + 9 * log(9)]/9

### Iterative Dichotomization

Back to tree learning...

-   Given a bag of mixed-up stuff.
    -   Need a *measure* of "mixed-up-ness" (entropy).

-   *Split*: Find something that divides up the bag in two new sub-bags
    -   And each sub-bag is less mixed-up;
    -   Each split is the root of a sub-tree.

-   *Recurse*: repeat for each sub-bag
    -   i.e. on just the data that falls into each part of the split
        -   Need a Stop rule
        -   Condense the instances that fall into each sub-bag (report
            majority class).

### Example

Which feature *splits* generates symbols that are less mixed up?

![](http://unbox.org/open/trunk/472/14/spring/doc/img/splits.jpg)

Which is the best attribute to split on?

-   The one which will result in the smallest tree
-   Heuristic: choose the attribute that produces the "purest" nodes
-   Purity = not-mixed-up
-   Popular impurity criterion: information gain
-   Information gain increases with the average purity \
     of the subsets that an attribute produces
-   Strategy: choose attribute that results in greatest *information
    gain*.

Compare the number of bits required to encode the splits with the number
of bits required to encode the un-split data.

-   Entropy of un-split data = entropy(9/14,5.14) =    
     -5/14 * log(5/14)/log(2) - 9/14 * log(9/14)/log(2) = 0.94
-   Entropy of the split data:
    -   Weighted sum of the entropy of the splits of size, say, 5, 4, 5
    -   5/14 * ent1 + 4/14  * ent2 + 5/14  * ent3

e.g. Outlook= sunny

-   info([2,3])= entropy(2/5,3/5) =    
    -2/5 \* log(2/5) - 3/5 \* log(3/5) = 0.971 bits

Outlook = overcast

-   info([4,0]) = entropy(1,0) =    
    -1 * log(1) - 0 * log(0) = 0 bits

Outlook = rainy

-   info([3,2]) = entropy(3/5, 2/5) =    
    -3/5 * log(3/5) - 2/5 * log(2/5) = 0.971 bits

Expected info for Outlook = Weighted sum of the above

-   info([3,2],[4,0],[3,2]) =    
    5/14 * 0.971 + 4/14 * 0 + 5/14 * 0.971 = 0.693

Computing the information gain

-   e.g. information before splitting minus information after splitting
-   e.g. gain for attributes from weather data:
-   gain("Outlook") = info([9,5]) - info([2,3],[4,0],[3,2]) = 0.940 -
    0.963 = 0.247 bits
-   gain("Temperature") = 0.247 bits
-   gain("Humidity") = 0.152 bits
-   gain("Windy") = 0.048 bits

Repeatedly split recursively:

<center>
<img width=400
    src="http://unbox.org/open/trunk/472/14/spring/doc/img/finaltree.jpg"
	>
</center>

-   Note, final tree: not all leaves are pure
-   Splitting stops when data can't be split any further
-   Or too few examples left to split (the *-M 2* flag in J48)
