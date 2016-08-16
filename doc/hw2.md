[home](http://tiny.cc/fss2016) | [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016  tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/glance.md) |
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[submit](http://tiny.cc/fss2016give) |
[chat](https://fss16.slack.com/) 


_______



# Homework2





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
