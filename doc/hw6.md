[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Homework6:  Anomaly Detection


## Data generator

Take a data set with at least 3 classes.

Build a data generator that randomly

- spits out 1000 rows with the 3 classes at probability 50,50,0%
- then switches to spit out 1000 more rows at probability 10,30,60% (i.e. the third
  class magically "appears" after 1000 rows).

## Data reader

Build an incremental data reader that reads data in `eras` of 100 instances at a time.

- When run on the above data, print out the recall at eras 1,2,3,4,5,..,20 (note:
  at era 11, there should be a dip in the performance).

## Incremental NB

Write an Naive Bayes classifier

- that learns on eras 1..i
- then tests on era i+1.
- and prints out each predicted class _and_ the log of the likelihood of that prediction

##  Anomaly detector

Using the A12 test, can you automatically raise an alert when the log of the likelihoods
of era `j` are different and worse to era `j-1'?
