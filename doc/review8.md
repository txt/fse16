[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Review 8: Privacy

1. Why do many organizations decline to share data?
1. What is generalization for privacy? Given an example.
1. What is suppression for privacy? Given an example.
1. What is perturbation for privacy? Given an example.
1. Define k-anonymity. For k=2, show 3 rows in a training set that 
       - satisfies k=2 anonymity;
       - does not satisfy k anonymity.
1. According to Brickell+Shmatikov and Grechanik et al., data mining efficacy
   drops as data privacy is increased (using standard methods). Why is this so?
1. A data set contains F features, one of which is a class
   attribute. Explain a method
   could be used to replace that data set with a smaller data set.
1. A data set contains R features. Explain a method
  could be used to replace that data with a smaller set.
1. If a data set is replaced with 25% of its columns and 10%
  of its rows, what is its percent privacy (measured in terms
  of private cells)?
1. Explain, with an example, the 1st law of trusted data sharing ("don’t share everything; just the 'corners');
1. Explain why  there needs to be a 2nd law of trusted data sharing 
  ("anonymize the data in the “corners'");
1. Explain, with an example, how to operationalize the 3rd law of trusted data sharing
  ("never mutate across 'decision boundary'"). In your explanation, make sure you **also** explain
   what happens if this third law is violated.
1. Describe the LACE2 "pass the parcel" procedure.  Your answer needs to mention how LACE2 uses 
  privacy and anomaly detection.
1. LACE2 is a "supervised privacy algorithm" while k-anonymity is an "unsupervised privacy algorithm".
     - What are the differences between these two classes of algorithms?
     - What can be done with unsupervised privacy algorithms that _can't_ be done with supervised privacy?
     - Empirically, what are the results describing the benefits of unsupervised vs supervised privacy?
