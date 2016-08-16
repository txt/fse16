[home](http://tiny.cc/fss2016) :: [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) ::
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) ::
[submit](http://tiny.cc/fss2016give) ::
[chat](https://fss16.slack.com/) 

_______



# Lectures

## Exploring the Premises

No unifying theory

+ Counter case "unifying theories of software
  engineering". Much research, including my one work
  on abduction. Rejected by numerous conferences/journals.
  Not operational. Countercase: Whitehead's power laws

## Data Mining 101

Gentle walk through N learners

- 10 learners in 10 pictures
- svm = walls in decision space
- k-means, mini-batch k-means
- "clustering" = clusters + naive Bayes + c4.5/cart
- good resource: https://rayli.net/blog/data/top-10-data-mining-algorithms-in-plain-english/
- top down dvision
- c4.5 cart, pddp, (really, all of spatial trees)

What is the same about all these learners:

- kmeans == nb (clustering)
- prism == apriori (tiny explanations)
- cart == j48 == fayyad iranni = scott-know
- RF == logitboist (Sampling)
- evaluation (precision, recall etc)
- most rows and columns don't matter

# theory of artifacts

- engieners repsonsible for their oen tools and optimizing those tools
- all those beuatiful artifacts

## Maths 101

bias, variance: basic laws 

entropy,

effect size, 

dimensionality

boostrap sampling

scott-knott

## Data Mining (again)

Buse 9

Types of learners (from
https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=commonly+used+data+mineing+algorithms)

Based on a Scientific research paper here is top 10
data mining algorithms identified by the IEEE
International Conference on Data Mining (ICDM) in
December 2006 and these top 10 algorithms are among
the most influential data mining algorithms in the
research community

C4.5
k-Means
SVM
Apriori
EM
PageRank
AdaBoost
kNN
Naive Bayes
CART

Public Voting:

Decision Trees/Rules

Regression
Clustering
Statistics (descriptive)
Visualization
Time series/Sequence analysis
Support Vector (SVM)
Association rules
Ensemble methods
Text Mining
Neural Nets
Boosting
Bayesian
Bagging
Factor Analysis
Anomaly/Deviation detection
Social Network Analysis
Survival Analysis
Genetic algorithms
Uplift modeling

Based on voting done by “Mahout user mailing list” here is the list:

Matrix factorization (SVD)
k-means
Naive Bayes
Dirichlet Process Clustering
Matrix Factorization
Frequent Pattern Matching
LDA
Expectation Maximization
SVM
Decision Trees
Logistics Regression
Random Forest


## The Process

Sanity Cycles

KDD cycles. From 1994

Goal Cycles

- find someone's hypothesis, that they care about
- find what feature extractors are needed
- consider if you need old vs new data
    - some new data as a sanity check
    - but generally, more old than new data (exception: Mechanical Turk)
    - consider the use of surrogates (stand-ins for what you might want)
    - e.g. surrogate: "happiness" = rate at which folks quit

# reserach methods

parts of a paper

- standfor intro
- data section (context variables)
- stats
- validity 

# A vision of the future

FSS taking over all. the london talk    
    
