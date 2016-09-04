[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Homework4

## Big Project

Write 1 page on what your big project in November. No need to have all the details worked out but
what are the broad strokes?

Note, there are some project ideas at the [projects](projects.md) page, but don't feel bound by them.

## Some Stats

## Nearest neighbor

Using your table class, code up a k=1NN classifier using (a)[mini-batch K-means](http://www.eecs.tufts.edu/~dsculley/papers/fastkmeans.pdf)  and (b)[KD-trees](http://code.activestate.com/recipes/577497-kd-tree-for-nearest-neighbor-search-in-a-k-dimensi/).

Such classifiers predict that the class of the test instance is the class of the k-th nearest neighbors in the train set.

Such classifiers can be very slow unless optimized via tricks like mini-batch or KN-trees

- kNN+KD-trees: use KD-trees to find the nearest thing.
- kNN+mini-batch: find the nearest centroid, find the nearest item in that cluster (note use k=20 for mini-batch. most clusters will be empty but what the heh?)

Your task:

+ Compare the runtimes between raw kNN and kNN+KD-trees or kNN+mini-batch
+ Compare the performance between kNN and KD-trees (does doing it faster mean doing it wrong?)
