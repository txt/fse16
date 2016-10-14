[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______

# Review 7

## Feature Selection


- What is the difference between a FILTER and a WRAPPER?
        - In five lines or more, describe one FILTER FSS algorithm
- What is the difference between _forward select_ and _back select_
        - Which would you recommend when the selected features will be (a) very few or (b) very many. Justify your answers.
- What is the difference between a SOLO and  COMBINATION feature selector?
       - Give one example of each
       - One is faster than the other. Why?
- How does RELIEF work?
       - What stochastic properties of RELIEF make it attractive for large data sets? 
- An FSS can characterized by its _evaluation_ method and _search_ method. Describe the evaluation and search method of J48 WRAPPER.
- Name two reasons why deleting attributes can be useful, regardless of the ellarning method.
- For very small data sets, describe what FSS would you recommend. Justify your recommendations.
- For very large data sets, describe what FSS would you recommend. Justify your recommendations.
- Removing attributes in J48 can improve accuracy. Why?

## Range Selection

- Give two classes A,B of frequency 100 and 500, the range _sex=male_ appears 20 and 10 times
  in A,B respectively. Assuming that A is the target class, caculate the rank score of
  _sex=male_
       - Using the "nomogram" ranker ranker rule. Show all working
       - Using the "best or rest" ranker ranker rule. Show all working

## Instance Selection

- How can mini-batch k-means be used for instance selection?


## Defect Prediction

- What kind of data is needed as input to _defect prediction_?
- What is the nature of the class variable in defect prediction?
- What are the usual performance scores for defect prediction?
- What is transfer learning?
- What is the role of feature selection in transfer learning?
        - Hint: without transfer learning, what would be more complex in transfer learning?
- What is the role of the Kolmogorov-Smirnov Test in transfer learning?

## Mistakes

- In the [MSR'13 case study](http://www.slideshare.net/timmenzies/msr13-mistake),
  what was the role of:
        - open source data and tools?
        - support code for a paper being stored in a versioned code repository.
- List three factors that mean that this kind of error report is not common.
  
