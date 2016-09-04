[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______



# Projects

here are some ideas, do not feel bound by these.

Anything that supports _science_ and data mining and software engineering. Where _science_ means:

+ improving existing ideas (tuning studies)
      + open issue: is the effort associated with tuning worth the improvements (if any)? if tuned results are compared to untuned, any real difference? is tuning data set specific or can 1 size fit all?
+ recognizing new and useful ideas (learning)
+ recognizing better ideas (local learning)
      + open issue: if we cluster and learn one model per cluster, are the new models "better"? i.e. lower variance, lower worst case performance, better median performance, faster to run, easier to explain, what?
+ explaining new ideas succinctly (feature selection, row selection, visualizations)
      + open issue: does _explaining_ means simplying things so they no logner _perform_ as well
+ sharing new ideas so others can check (packaging
      + open issue: how to packagge such that most people can use it? Hint: [it ain't easy](https://github.com/SoftwareEngineeringToolDemos/Paper/blob/master/Publication%20-%20Conference%20-%20Tool%20Demos/document.pdf) Package managers? Virtual machines? Docker? Makefiles? what?
+ recognizing when old ideas are not working anymore (manual replication studies, automatic anomaly detection, certification envelopes)
     + open issue: how to reduce the human time, CPU, RAM, disk storage  associated with   these? And what about data privacy?
 + repairing old ideas (stream mining, repair)
     + open issue: how?


## Project Ideas (incompelte)

### Verifications

Take any data set and look for instabilities in either:

- The performance of the learned model
- The structure of the learned model

across different groupings of the data, or across the same data set at different times.

### Anomaly Detection

Write some gizmo that recognizes when new test examples are far away from what has been seen before.

+ e.g. a Naive Bayes classifier that print conclusions with the log of their likelihood
+ e.g. a clustering algorithm that reports when new examples are far away from old examples
+ e.g. run the data in `era`s of size `N` and learns one




### Replications

Convert some prior papers into reproduction package (e.g. make them a Pyton Pip Package). Use
any paper that is interesting but, just a suggestion, use something where you can
get ready access to a local expert. e.g.

+ E. Kocaguneli, T. Menzies and J. W. Keung, "On the Value of Ensemble Effort Estimation," in IEEE Transactions on Software Engineering, vol. 38, no. 6, pp. 1403-1416, Nov.-Dec. 2012.
doi: 10.1109/TSE.2011.111
keywords: {software development management;ensemble effort estimation;error measures;multiple estimation method;single method;software effort estimation;Costs;Machine learning;Measurement uncertainty;Neural networks;Regression tree analysis;Software performance;Support vector machines;Taxonomy;Software cost estimation;analogy;ensemble;k-NN;machine learning;neural nets;regression trees;support vector machines},
URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6081882&isnumber=6363456
+ E. Kocaguneli, T. Menzies, A. Bener and J. W. Keung, "Exploiting the Essential Assumptions of Analogy-Based Effort Estimation," in IEEE Transactions on Software Engineering, vol. 38, no. 2, pp. 425-438, March-April 2012.
doi: 10.1109/TSE.2011.27
keywords: {pattern clustering;program testing;project management;software cost estimation;trees (mathematics);Albrecht data set;Coc81 data set;Desharnais data set;ISBSG data set;Nasa93 data set;Turkish companies;analogy-based effort estimation;binary cluster tree;cluster subtrees;dynamic selection;essential assumption;estimation variance;nearest neighbor selection;project data;software effort estimator design;subtree variance;supertree variance;Estimation;Euclidean distance;Humans;Linear regression;Software;Training;Training data;Software cost estimation;analogy;k-NN.},
URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5728833&isnumber=6173074

