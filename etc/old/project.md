[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______



# Project: csc591

## Project Work

The premises of this subject are that:

- very small models can do (nearly) as well as more complex ones;
- models change, a lot:
     - over time, as new data arrives
     - over different sub-samples since different parts of the data support different conclusions

<iframe seamless="seamless" style="width: 100%; border: none; display: block; max-width: 420px; height: 360px;" src="https://getyarn.io/yarn-clip/embed/6772ff56-2fc3-4125-8d59-f115533708f1?autoplay=false"> </iframe>

So, go on make me a liar. Prove me wrong. From any source of SE data, show that:

- Models learned from data at time _i_ **are not** very different at some later time _j_;
- Models learned from different sub-samples of the data **are not**  very different
- The performance of small, carefully built, models are **much worse** (*) that more complex ones.

(*) where "worse" means allowing for variances over
different sub-samples of the training data and
includes tests for statistical significance and
effect size.


## Homeworks

normalization: 10bins znorm

knn

naiveBayes

Smote

decisionTree

prism

prism on relevants only

## Big project

Incremental learning

- baseline. learn on all data
- incremental. read data, N instances at a time. update models after N. j48. regrow. kdd the witten way. nb: icnremental.
- report memory growth
- if perforamce era i+1 old, turn off learner
- if performance era i+1 worse, look for old learners that are useful (note: so no global learners)

Build a decisiont ree elarner. Build a contrast set learner

Build a recursive k-means . do anomaly detection. report how often subtrees are anomalous. do re-learning on sub-trees.

As above, but use where.
