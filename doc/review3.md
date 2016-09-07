[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______



# Review 3

## Spatial TRees

Spatial  tree use some _measure of confusion_ M to _split_ S the data, the recurse on each split
till some _halting_ H criteria is meet, after which some _condensation_ operator C is applied
to the summarize the leaf splits. Describe M,S,H,C for

- J48 (aka c45). Hint: explores discrete classes
- Cart. Hint: sometimes explores continuous classes.
- Recusrive k=2 means. Hint: ignores classes
- NB Tree. Hint: you've never heard of it before. It builds Naive Bayes classifiers for each leaf.
- X Tree. Hint: this is a generalization of NB tree
- PDDP: Hint. PCA:

[!](https://upload.wikimedia.org/wikipedia/commons/f/f5/GaussianScatterPCA.svg)


## Random Forests

What is the difference between a spatial tree learner and a random forest?

Explain why a random forest can better handle larger data sets with more variance than a spatial tree learner.

## Evaluation Criteria

Make a case that precision is stupid.

Make a case that accuracy is stupid.

Make a case that recall is stupid.

What is AUC(effort, recall)? [Hint](https://github.com/txt/fss16/blob/master/doc/talk2.md#multiple-numeric-goals). 
