[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______



# Review 2

1. Distinguish data science and data dabbling.
2. Science should be about at least the following five terms. For each, describe one way a data dabler might **NOT** achieve that goal:
      - refutability;
      - repeatability;
      - critical review of old ideas;
      - wide spread community discussion;
      - research. 
2. Name two commonly used conventions in agile we-based development that, in theory, could support the
following aspects of    science.
      - Repeatability
      - wide spread community discussion;
3. Some scientists seek grand unifying theories of everything. Name two factors that might make it hard to build such unifying theories in SE.
4. Recall, accuracy, precision, false alarms, f, g
      - Define using a  formula
      - Using specific data, give examples  where accuracy and precision might be  misleading
5. Using the above, derive the Zhang equation. What are the implications of that equation?
6. How to build a detector with zero false alarms? What would be drawbacks of such a detector?
7. How to build a detector with 100% recall? What would be drawbacks of such a detector?
8. SMOTE:
       - In one line, describe SMOTE
       - When would you use it
       - In five to ten lines of text, offer details on SMOTE
       - Where should SMOTE _**not** be applied?
9. How does ZeroR work?
9. Decision tree learning
       - Write down a set of 10 symbols with high entropy
       - Write down a set 10 symbols with low entropy
       - What is the equation for entropy? Apply it to one of the above sets. Feel free to leave your equation in fractional form,
       - Write down a set of 10 numbers with high standard deviation
       - Write down a set 10  numbers with low standard deviation
       - What is the equation for standard deviation ? Apply it to one of the above sets. Feel free to leave your equation in fractional form,
       - How are entropy and standard deviation **similar**?
       - DT is also called "iterative dichotomization". Why?        
9. What is M*N cross-validation?
       - What happens in the M step? Why?
       - What happens in the N step? Why?
       - Given 10000 examples, what values for M,N might you recommend?
       - Given 50 examples, what values for M,N might you recommend?
10. What is Devanbu's "naturalness" thesis? How might "naturalness" change the nature of software engineering?
11. In work on NASA defect reports, Menzies and Marcus applied "tf idf" to reduce the number of words being reported.
       - What is the intuition behind tf idf?
       - What is the tf idf formula?
       - What is the purpose of the log function within that formula?
       - In studies with five real world defect reports, what did Menzies and Marcus uncover about the 100,000s of words in those defect reports?
       - What is the connection (if any) between the work of Menzies and Marcus and Devanbu?
12. What is feature subset selection?
       - What is the following output reporting?
       - What is the connection (if any) between feature subset selection and the work of Menzies and Marcus and Devanbu?


```
number of folds (%)  attribute
           2( 20 %)     1 S1
           0(  0 %)     2 S2
           2( 20 %)     3 S3
           1( 10 %)     4 S4
           0(  0 %)     5 S5
           1( 10 %)     6 S6
           6( 60 %)     7 S7     <==
           1( 10 %)     8 F1
           1( 10 %)     9 F2
           2( 20 %)    10 F3
           2( 20 %)    11 D1
           0(  0 %)    12 D2
           5( 50 %)    13 D3     <==
           0(  0 %)    14 D4
           0(  0 %)    15 T1
           1( 10 %)    16 T2
           1( 10 %)    17 T3
           1( 10 %)    18 T4
           0(  0 %)    19 P1
           1( 10 %)    20 P2
           0(  0 %)    21 P3
           1( 10 %)    22 P4
           6( 60 %)    23 P5     <==
           1( 10 %)    24 P6
           2( 20 %)    25 P7
           1( 10 %)    26 P8
           0(  0 %)    27 P9
           2( 20 %)    28 Hours
           8( 80 %)    29 KLoC   <==
           4( 40 %)    30 Language
           3( 30 %)    32 log(hours)
```


     
