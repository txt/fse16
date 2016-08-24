




# Review1

## Software Science is Differnce

- We work with communities
     - Results posted to web sites (intra-nets, internets) for communities to comment on
     - Results are presented in their simplest, clearest form
          - So brevity and visualizations and intuitive explanations are  key
     
- We exploit the inherent simplicity of software
     - Language model results
     - Feature selection (throw away spurious or attributes)
          - e.g. text mining defect reports
          - reports have `W` words in `D` documents (defect reports)
          - a a word appears `w` times in `d` documents, then term-frequeny iverse document frequency is
                -
     
## Evaluation

### Classifiers (target = one column of symbols called ``classes'')

```
                     truth
                   .----.-----.
                   | no | yes |
                   .----.-----.
detector   silent  | A  |  B
           loud    | C  |  D
```         

Raw

- True negative = A
- False negagive= B
- False positive= C
- True positive = D
- Effort        = amount of code selected by detector
        - (c.LOC + d.LOC)/(Total LOC)

Derived

- recall = pd = `D/(B+D)`
- accuracy    = `(A+D)/(A+B+C +D)`
- precision   = `D/(C+D)`
- false alarm=pf= `C/(A+C)`
- pos/neg = `(B+D)/(A+C)`



Turns out, precision and accuracy aren't very precision or accurate
when the target class is very small (effort> 10).

-  Issue of missed balanced data
-  Standard trick: during cross-val, [SMOTE](https://www.jair.org/media/953/live-953-2037-jair.pdf) the training set
       - take the minority class with `E` examples
       - randomly throw away majority classes till you get to `3*E` examples
       - randomly build new minority examples by (a) find the five nearest neighbors
         of the same minority class X, (b) pick P, one of those five at random; (c) create a new
         minority class member at a random point between X and P; (d) repeat till you get `3*E` examples
       - Beginner trap: you can SMOTE to training set but not the test set.
      

<img src="../img/smote.png" width=600>

PD and effort are linked. The more modules that trigger
       the detector, the higher the PD. However, effort also gets
        increases.
        
        
High PD or low PF comes at the cost of high PF or low PD
        (respectively). This linkage can be seen in a standard
        receiver operator curve (ROC).  Suppose, for example, LOC> x
        is used as the detector (i.e. we assume large modules have
        more errors). LOC > x represents a family of detectors. At
        x=0, EVERY module is predicted to have errors. This detector
        has a high PD but also a high false alarm rate. At x=0, NO
        module is predicted to have errors. This detector has a low
        false alarm rate but won't detect anything at all. At 0<x<1,
        a set of detectors are generated as shown below:


                 pd
               1 |           x  x  x                KEY:
                 |        x     .                   "."  denotes the line PD=PF
                 |     x      .                     "x"  denotes the roc curve 
                 |   x      .                            for a set of detectors
                 |  x     .
                 | x    . 
                 | x  .
                 |x .
                 |x
                 x------------------ pf    
                0                   1

Note that:

- The only way to make no mistakes (PF=0) is to do nothing
        (PD=0)
- The only way to catch more detects is to make more
         mistakes (increasing PD means increasing PF).
- Our detector bends towards the "sweet spot" of
         <PD=1,PF=0> but does not reach it.
- The line pf=pd on the above graph represents the "no information"
         line. If pf=pd then the detector is pretty useless. The better
         the detector, the more it rises above PF=PD towards the "sweet spot".

### Problems with precision

All the above are linked as follows

- Recall prec = `D/(D+C)`
- Divide top and bottom by `D` to get `1/(1+C/D)`
- This can be exanded to `1 / (1+ neg/pos * pf/recall)`
- Re-arranging `pf = pos/neg * (1-prec)/prec *recall`

So these variables are all connected via properties of the data set. For more on this,
see 

- Problems with Precision, 2007, http://menzies.us/07precision.pdf
- [abcd.py](../src/abcd.py)


### Numerics Goals

When the goal is numeric

Results for one example

- E= expected
- A= actual
- Residual = E-A

results fro many examples

- AR = magnitude residual = abs(E-A)
- MdAR = median magnitude residual
- Pred(N) = percent of examples where AR < N%
      - e.g. Pred(30)
- SA = `1 - (MdAR/ baseline)` where the baseline is the the MdAR after doing the simplest
  possible estimation; e.g. set expected to the median value of all the perfromance scores

### Multiple Numeric Goals

Some aggregation function that turns N nums into 1:

- e.g. f-measure = `(2 * pd * prec) / (pd + prec)`
      - has the property that if either are low, the product is low as well.
- e.g. g-measure = `(2 * pd * (1-pf))/ (pd + 1 - pf)`
      - Use if you are worried about precision

Area-under the curve

- useful for combining two variables
    - e.g AUC(prec,recall)

- Common on software analytics
      - find most code after reading least code
      - `Bad` = modules predicted defective
      - `Other` = all other modules
      - Sort each increasing by LOC
      - Track the recall

<img src="../img/roc.png">

Multi-objective-domination

- Given examples X,Y,Z,.... with N goals
     - each goal N has a direction for `better` (more, less)
     - e.g. cost is usually better if less; i.e. minimize
- `X` "dominates" `Y` if
     - binary domination: better on at least on goal and worse on none
            - returns true, false
            - if many goals, then often false (so bad for 3+ goals)
     - continuous domination: sum of different in each goal, raised to an exponential
            - so small differences SHOUT louder
            - X dominates Y if the the "losses" X to y are less than the "losses" y to X
            - better for large numbers of goals

```python
def bdom(x, y, abouts):
  x       = abouts.objs(x)
  y       = abouts.objs(y)
  betters = 0
  for obj in abouts._objs:
    x1, y1 = x[obj.pos], y[obj.pos]
    if   obj.better(x1,y1) : 
       betters += 1
    elif x1 != y1: 
       return False # must be worse, go quit
  return betters > 0
```

Continuous domination:

<img src="../img/cdom.png">

```python
def cdom(x, y, abouts):
  "many objective"
  x= abouts.objs(x)
  y= abouts.objs(y)
  def w(better):
    return -1 if better == less else 1
  def expLoss(w,x1,y1,n):
    return -1*math.e**( w*(x1 - y1) / n )
  def loss(x, y):
    losses= []
    n = min(len(x),len(y))
    for obj in abouts._objs:
      x1, y1  = x[obj.pos]  , y[obj.pos]
      x1, y1  = obj.norm(x1), obj.norm(y1)
      losses += [expLoss( w(obj.want),x1,y1,n)]
    return sum(losses) / n
  l1= loss(x,y)
  l2= loss(y,x)
  return l1 < l2 
 ``` 

     
Space of all non-dominated solutions = Pareto frontier

 <img src="../img/pareto.jpg">    


- `M` optimizers each explore a population of size `S` 
  while struggling to find good solutions 
      - this create `Pm` multiple frontiers
- The _reference frontier_ `R` is:
       - `Q = removeDups( union(Pm))`
       - `R = reduced( nondiminated(Q) )` where nondominated was defined above and
         `reduced` is some sorting function that selects no more than `S` items
                - By convention, nondominated is with `bdom`
- The value of `M` is how close `Pm` is to `R`
       - `IGD` = inter-generational distance = for all items in `Pm`, what is the
         closest item in `R`
       - `M1` is better than `M2` if its IGDs are _smaller_.


what the big ms conclusion re how to predict bugs

- what aspects of the programming languages being used for
  development where used in that "great predictor"

data science and data dabblers

science refutation. vendor. visualization, inference. data base

give examples of data-driven reasoing
- in general population
- in se

menzies beleives in no generality bcause...

nauturalness. language models

sociton-technical systems

agile, regression suites. etc. qeuuailce for softwre science?

dangers of self test:

- bias/variance trade-off
http://scott.fortmann-roe.com/docs/docs/BiasVariance/biasvariance.png
http://inside-bigdata.com/wp-content/uploads/2014/10/Bia_variance_tradeoff_fig.jpg
http://blog.fliptop.com/blog/2015/03/02/bias-variance-and-overfitting-machine-learning-overview/

http://www.astroml.org/sklearn_tutorial/practical.html

3.4.1. High Bias

If our algorithm shows high bias, the following actions might help:

Add more features. In our example of predicting home prices, it may be helpful to make use of information such as the neighborhood the house is in, the year the house was built, the size of the lot, etc. Adding these features to the training and test sets can improve a high-bias estimator
Use a more sophisticated model. Adding complexity to the model can help improve on bias. For a polynomial fit, this can be accomplished by increasing the degree d. Each learning technique has its own methods of adding complexity.
Use fewer samples. Though this will not improve the classification, a high-bias algorithm can attain nearly the same error with a smaller training sample. For algorithms which are computationally expensive, reducing the training sample size can lead to very large improvements in speed.
Decrease regularization. Regularization is a technique used to impose simplicity in some machine learning models, by adding a penalty term that depends on the characteristics of the parameters. If a model has high bias, decreasing the effect of regularization can lead to better results.
3.4.2. High Variance

If our algorithm shows high variance, the following actions might help:

Use fewer features. Using a feature selection technique may be useful, and decrease the over-fitting of the estimator.
Use more training samples. Adding training samples can reduce the effect of over-fitting, and lead to improvements in a high variance estimator.
Increase Regularization. Regularization is designed to prevent over-fitting. In a high-variance model, increasing regularization can lead to better results.
These choices become very important in real-world situations. For example, due to limited telescope time, astronomers must seek a balance between observing a large number of objects, and observing a large number of features for each object. Determining which is more important for a particular learning task can inform the observing strategy that the astronomer employs. In a later exercise, we will explore the use of learning curves for the photometric redshift problem.

points vsersus samples

Cross-val

eval defs (prec etc). include the precision paper

decisions trees.. how do they work?

entropy


pipe and filter. defs

examples

