[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/fss16/blob/master/src) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 

_______



# Naturalness

small is enough.

## the big data story

devanbu, norvig, google github

## the little data story

diabetes.arff

bn.arff

cocomo

## the maths
Devanbu stuff

## Analogy

Science is about repeated patterns. We are surrounded by them, but often miss them.

Traversity

Chicken checken

four chord song

http://news.mit.edu/2015/how-three-mit-students-fooled-scientific-journals-0414

langauge model


we now describe.
Consider the sequence of tokens in a document (in our case,
a system
s),
a
1
a
2 . . . a
i
. . . a
n
.
N-gram models statistically
estimate how likely tokens are to follow other tokens. Thus,
we can estimate the probability of a document based on the
product of a series of conditional probabilities: 

https://en.wikipedia.org/wiki/Language_model#Example

http://www.youtube.com/watch?v=yvDCzhbjYWs&t=18m13s
- learned from a trillion word corpus

18m:13s to 36:30

let you go from zero so a reasonable model 
just by collecting data and running it.

data-driven approach is the ultimate in agile
programming. allows you to move quick.


techniques for smoothing the estimates of a very large number
of coefficients, some of which are larger than they should be
and others smaller. Sometimes it is better to back-off from a
trigram model to a bigram model. The technical details are
beyond the scope of this paper, but can be found in any advanced
NLP textbook


N-gram models assume a Markov property
, i.e., token occurrences
are influenced only by a limited prefix of length n,
thus for 4-gram models, we assume p(ai|a1 . . . ai−1) ' p(ai | a
i
−
3
a
i
−
2
a
i
−
1
)
These models are estimated from a corpus using simple
maximum-likelihood based frequency-counting of token sequences.
Thus, if “∗” is a wildcard, we ask, how relatively
often are the tokens
a
1, a
2, a
3 followed by
a
4
:
p
(
a
4|a
1
a
2
a
3) = count
(
a
1
a
2
a
3
a
4
)
count
(
a
1
a
2
a
3
∗
)
In practice, estimation of
n-gram models is quite a bit more
complicated. The main difficulties arise from data sparsity,
i.e., the richness of the model in comparison to the available
data. For example, with 10
4
token vocabulary, a trigram model
must estimate 1012 coefficients. Some trigrams may never occur
in one corpus, but may in fact occur elsewhere. This will
lead to technical difficulties; when we encounter a previously
unseen
n-gram, we are in principle “infinitely surprised”, because
an “infinitely improbable” event x estimated from the
previously seen corpus to have
p
(
x) = 0 actually occurs; this
leads to infinite entropy values, as will become evident below.
Smoothing is a technique to handle cases we where have not
seen the n-grams yet and still produce usable results with suf-
ficient statistical rigour. Fortunately, there exist a variety o


 In practice we found that Kneser-Ney
 
 http://www.foldl.me/2014/kneser-ney-smoothing/
 
smoothing (e.g., Koehn [
3],
§7) gives good results for software
corpora. H

bird language models

- https://www.semanticscholar.org/paper/Products-developers-and-milestones-how-should-I-Saraiva-Bird/61ffb9ee39427604841703a1ba29ad07a9995595

Could!we!just!count!and!divide?!
• No!!!Too!many!possible!sentences!!
• We’ll!never!see!enough!data!for!es*ma*ng!these!
!
P(the |its water is so transparent that) =
Count(its water is so transparent that the)
Count(its water is so transparent that)
Dan!Jurafsky!
Markov!Assump1on!
• Simplifying!assump*on:!
• Or!maybe!
!
P(the |its water is so transparent that) " P(the |that)
!
P(the |its water is so transparent that) " P(the |transparent that)


## Devanbu
