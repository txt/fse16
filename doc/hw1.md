[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   
[Home](http://tiny.cc/fss2016) |
[At a glance...](https://github.com/txt/fss16/blob/master/doc/glance.md) |
[Syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[Submit](http://tiny.cc/fss2016give) |
[Discuss](https://fss16.slack.com/) |
[Lecturer](http://menzies.us) 


# Homework1

![](http://tiny.cc/soonish)


![](http://tiny.cc/homeworkish)

## Before you begin


Get your Github environment going (public github, not ncstate). Add `timm` and
`bigfatnoob`
as collaborators  to that repo.

Get your development environment going. This should be code that is checked into git
and saved, regularly to your Gibhub account, and shared with any team members.

For your project, pick a development language. Use anything you want but be aware that
the lecturer and tutor can only support students using
Python on LINUX and Mac. Note also that all your team members should agree on the language.

Review your team. Ideally, a team should contain at least one moderate expert
in what ever language you are using. Got to http://tiny.cc/fss2016give and check out
our random assignments to the teams. Ask for a change if NO ONE on your team is
expert on the language you are using. If you make a change:

- mark your people with the same letter in column C, BELOW Row 20
- add your Gibub url in column B ABOVE row 20

## Read Something


## Code Something




How good are you are scripting? Do you need some extra tutoring this semester
or are you a TOP GUN or are you somewhere in-between?

Don't matter where you are, we just need to work that out and get you slotted
into the right stream.

So lets build `ZEROR`, the world's dumbest learner. It reads data files with
a small number of
`symbolic` values for its classes (so its a `classifier`). For example,
this data set only
knows 
```
@relation weather

@attribute outlook {sunny, overcast, rainy}
@attribute temperature real
@attribute humidity real
@attribute windy {TRUE, FALSE}
@attribute play {yes, no}

@data
sunny,85,85,FALSE,no
sunny,80,90,TRUE,no
overcast,83,86,FALSE,yes
rainy,70,96,FALSE,yes
rainy,68,80,FALSE,yes
rainy,65,70,TRUE,no
overcast,64,65,TRUE,yes
sunny,72,95,FALSE,no
sunny,69,70,FALSE,yes
rainy,75,80,FALSE,yes
sunny,75,70,TRUE,yes
overcast,72,90,TRUE,yes
overcast,81,75,FALSE,yes
rainy,71,91,TRUE,no

```
