[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Naive Bayes

A Bayes classifier is a simple statistical-based learning scheme.

Advantages:

+ Tiny memory footprint
+ Fast training, fast learning
+ Simplicity
+ Often works surprisingly well

Assumptions

+ Learning is done best via statistical modeling
+ Attributes are
    + equally important
    + statistically independent (given the class value)
    + Which  means that knowledge about the value of a particular attribute doesn't tell us anything about the value of another attribute (if the class is known)
	
Although based on assumptions that are almost never correct, this scheme works well in practice:

+ <em>Pedro Domingos and Michael Pazzani. 1997. [On the Optimality of the Simple Bayesian Classifier under Zero-One Loss](http://goo.gl/vURpPu). Mach. Learn. 29, 2-3 (November 1997), 103-130</em>

[![example](../img/bayes.png)](../img/bayes.png)


## Example 

_weather.symbolic.arff_:

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
    sunny    mild        normal    TRUE    yes%%

This data can be summarized as follows:

    
    
               Outlook            Temperature           Humidity
    ====================   =================   =================
              Yes    No            Yes   No            Yes    No
    Sunny       2     3     Hot     2     2    High      3     4
    Overcast    4     0     Mild    4     2    Normal    6     1
    Rainy       3     2     Cool    3     1
              -----------         ---------            ----------
    Sunny     2/9   3/5     Hot   2/9   2/5    High    3/9   4/5
    Overcast  4/9   0/5     Mild  4/9   2/5    Normal  6/9   1/5
    Rainy     3/9   2/5     Cool  3/9   1/5
    
                Windy        Play
    =================    ========
          Yes     No     Yes   No
    False 6      2       9     5
    True  3      3
          ----------   ----------
    False  6/9    2/5   9/14  5/14
    True   3/9    3/5

So, what happens on a new day:

    Outlook       Temp.         Humidity    Windy         Play
    Sunny         Cool          High        True          ?%%

First find the likelihood of the two classes

+ For "yes" = 2/9 * 3/9 * 3/9 * 3/9 * 9/14 = 0.0053
+ For "no" = 3/5 * 1/5 * 4/5 * 3/5 * 5/14 = 0.0206

Conversion into a probability by normalization:

+ P("yes") = 0.0053 / (0.0053 + 0.0206) = 0.205
+ P("no") = 0.0206 / (0.0053 + 0.0206) = 0.795

So, we aren't playing golf today.

## Bayes' rule

More generally, the above is just an application of Bayes' Theorem.

Probability of event H given evidence E:

                  Pr[E | H ] * Pr[H]
    Pr[H | E] =  -------------------
                      Pr[E]

A _priori probability_ of H= Pr[H]

+ Probability of event before evidence has been seen

A _posteriori probability_ of H= Pr[H|E]

+ Probability of event after evidence has been seen

Classification learning: what's the probability of the class given an instance?

+ Evidence E = instance
+ Event H = class value for instance

Naive Bayes assumption: evidence can be split into independent parts (i.e. attributes of instance!

                Pr[E1 | H ]* Pr[E2 | H ] * ....  *Pr[En | H ]Pr[H ]
    Pr[H | E] = ---------------------------------------------------
                                   Pr[E]

We used this above. Here's our evidence:

    Outlook       Temp.         Humidity    Windy         Play
    Sunny         Cool          High        True          ?

Here's the probability for "yes":

    Pr[ yes | E] = Pr[Outlook     = Sunny | yes] *
                   Pr[Temperature = Cool  | yes] *
                   Pr[Humidity     = High  | yes] * Pr[ yes]
                   Pr[Windy       = True  | yes] * Pr[yes] / Pr[E]
                 = (2/9 * 3/9 * 3/9 * 3/9)       * 9/14)   / Pr[E]

Return the classification with highest probability

## Pragmatics

### Probability of the evidence Pr[E]

+ Constant across all possible classifications;
+ So, when comparing N classifications, it cancels out

### Numerical errors

From multiplication of lots of small numbers

+ Safest and slowest: Use a language with arbitrary precision arithmetic e.g. LISP
+ Not so safe: use a language with big num support; e.g. Python
+ Safest:  don't multiply the numbers, add the logs

### Missing values

Missing values are a problem for any learner. Naive Bayes' treatment of missing values is particularly elegant.

+ During training: instance is not included in frequency count for attribute value-class combination
+ During classification: attribute will be omitted from calculation

Example: 

         Outlook    Temp.    Humidity    Windy    Play
         ?          Cool     High        True     ?%%

+ Likelihood of "yes" = 3/9 * 3/9 * 3/9 * 9/14 = 0.0238
+ Likelihood of "no" = 1/5 * 4/5 * 3/5 * 5/14 = 0.0343
+ So
    + P("yes") = 0.0238 / (0.0238 + 0.0343) = 41%
    + P("no") = 0.0343 / (0.0238 + 0.0343) = 59%

### The "low-frequencies problem"

What if an attribute value doesn't occur with every class value (e.g. "Humidity = high" for class "yes")?

+ Probability will be zero!
+ Pr[Humidity = High | yes] = 0
+ A posteriori probability will also be zero! Pr[ yes | E] = 0 (No matter how likely the other values are!)

So use an estimators for low frequency attribute ranges

+ Add a little "m" to the count for every attribute value-class combination
      + The Laplace estimator
      + Result: probabilities will never be zero!

And use an estimator for low frequency classes

+ Add a little "k" to class counts
      + The M-estimate

Magic numbers: m=2, k=1

### Handling numerics

The above assumes that the attributes are discrete. The usual approximation is to assume a "Gaussian" (i.e. a "normal" or "bell-shaped" curve) for the numerics.

The probability density function for the normal distribution is defined by the mean and standardDev (standard deviation)

+ `m` = mean
+ `s` = standard deviatopm
+ `x` = the value we are trying to score (will be maximum if `x` is the mean)

Code:

      function norm(x,m,s) {
           pi= 3.1415926535
           e = 2.7182818284
           a = 1/sqrt(2*pi*s^2)
           b = (x-m)^2/(2*s^2)
           return a * e ^ (-1*b)
       }

For example:

    outlook  temperature humidity windy play
    -------  ----------- -------- ----- ---
    sunny    85      85       FALSE no
    sunny    80      90       TRUE  no
    overcast 83      86       FALSE yes
    rainy    70      96       FALSE yes
    rainy    68      80       FALSE yes
    rainy    65      70       TRUE  no
    overcast 64      65       TRUE  yes
    sunny    72      95       FALSE no
    sunny    69      70       FALSE yes
    rainy    75      80       FALSE yes
    sunny    75      70       TRUE  yes
    overcast 72      90       TRUE  yes
    overcast 81      75       FALSE yes
    rainy    71      91       TRUE  no

This generates the following statistics:

    
                 Outlook           Temperature               Humidity
    =====================    =================      =================
               Yes    No             Yes    No            Yes      No
    Sunny       2      3             83     85             86      85
    Overcast    4      0             70     80             96      90
    Rainy       3      2             68     65             80      70
              -----------            ----------            ----------
    Sunny     2/9    3/5    mean     73     74.6  mean     79.1   86.2
    Overcast  4/9    0/5    std dev   6.2    7.9  std dev  10.2    9.7
    Rainy     3/9    2/5
    
                  Windy            Play
    ===================     ===========
               Yes   No     Yes     No
    False       6     2      9       5
    True        3     3
                -------     ----------
    False     6/9   2/5     9/14  5/14
    True      3/9   3/5

Example density value:

+ _f(temperature=66|yes)_ = `norm(66, 73, 6.2)` =0.0340

Classifying a new day:
    
        Outlook    Temp.    Humidity    Windy    Play
        Sunny      66       90          true     ?%%

+ Likelihood of "yes" = 2/9 * 0.0340 * 0.0221 * 3/9 * 9/14 = 0.000036
+ Likelihood of "no" = 3/5 * 0.0291 * 0.0380 * 3/5 * 5/14 = 0.000136
+ So:
     + P("yes") = 0.000036 / (0.000036 + 0. 000136) = 20.9%
     + P("no") = 0. 000136 / (0.000036 + 0. 000136) = 79.1%

Note: missing values during training: not included in calculation of mean and standard deviation

BTW, an alternative to the above is apply some discretization policy to the data. 
Such discretization is good practice since it can dramatically improve the performance of a Naive Bayes classifier (see [Dougherty95]:

+ _James Dougherty, Ron Kohavi, Mehran Sahami: [Supervised and Unsupervised Discretization of Continuous Features](http://goo.gl/NdCgop). ICML 1995: 194-202_

## Code

[See Table](https://github.com/txt/fss16/blob/master/doc/table.md#top-level-drivers)
