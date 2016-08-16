[home](http://tiny.cc/fss2016) :: [copyright](https://github.com/txt/fss16/blob/master/LICENSE.md) &copy;2016, tim&commat;menzies.us<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   <br>
[overview](https://github.com/txt/fss16/blob/master/doc/overview.md) ::
[syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) ::
[submit](http://tiny.cc/fss2016give) ::   
[chat](https://fss16.slack.com/) 

_______



# Homework1


## Before you begin

- Get your URL shortener going. Go get an account at http://tiny.cc. 
- Get your Github environment going (public github, not ncstate). Add `timm` and
`bigfatnoob` as collaborators  to that repo.
     + The name of that repo should be `fss16xxx` where `xxx` is anything you like.
     + Add directories to that repo as follows

```
project
paper
read   -- all your weeklies readings go here
code/1 -- code for week1.
code/1/README.md : answers to any questions asked this week
code/2
code/3
etc
```

- Get your development environment going. This should be:
       - code that is checked into git and saved, regularly to your Gibhub account, and shared with any team members.
       - Some Unix-type environment: LINUX, Mac (with xcode installed), c9.io (a free web-based IDE).
       - Some folks report success with Windows and
         gitbash (https://git-for-windows.github.io/) but that is up to you.
              - GitBash https://git-for-windows.github.io/
              - Chocolatey package manager https://chocolatey.org/
       - Note that all your team members need to running the same environment (which makes
           c9.io an attractive option).
- For your project, pick a development language. Use anything you want but be aware that
the lecturer and tutor can only support students using
Python on LINUX and Mac. Note also that all your team members should agree on the language.
- Review your team. Ideally, a team should contain at least one moderate expert
in what ever language you are using. Got to http://tiny.cc/fss2016give and check out
our random assignments to the teams. Ask for a change if NO ONE on your team is
expert on the language you are using. If you make a change:
      - mark your people with the same letter in column C, BELOW Row 20
      - add your Gibub url in column B ABOVE row 20

## Read Something

Write a summary of one research paper from 2012 relating to data mining and software engineering.
For more details see [Reading12345678](Reading12345678.md).

## Install Something


Into a fresh subdirectory, download and unpack https://github.com/dotninjas/dotninjas.github.io/archive/master.zip. Important note: the pathname to that directory should not have any spaces in it.

      wget https://github.com/dotninjas/dotninjas.github.io/archive/master.zip
      unzip master.zip 
      mv dotninjas.github.io-master/* .
      cd ninja/
      sh ninja

That should generate the following lame Ascii Art version of a ninja throwing a star.


```
          ___                                                             
         /___\_/                                                          
         |\_/|<\                         Command line ninjas!
         (`o`) `   __(\_            |\_  Attack!                               
         \ ~ /_.-`` _|__)  ( ( ( ( /()/                                   
        _/`-`  _.-``               `\|   
     .-`      (    .-.                                                    
    (   .-     \  /   `-._                                                
     \  (\_    /\/        `-.__-()                                        
      `-|__)__/ /  /``-.   /_____8                                        
            \__/  /     `-`                                               
           />|   /                                                        
          /| J   L                                                        
          `` |   |                                                            
             L___J                                                        
              ( |
             .oO()                                                        
_______________________________________________________
/usr/bin/java
/usr/bin/gawk
/usr/bin/python
/usr/bin/zip
/usr/bin/unzip
/usr/bin/git
/usr/bin/perl
ATTENTION: missing nothing; can you install nothing?

ninja.rc v1.0 (c) 2016 Tim Menzies, MIT (v2) license

NINJA: workspace/ninja 37> 

```

Note that list of installed files (all the '/usr/bin' stuff). If any of those are absent, do

    sudo apt-get install XXX

## Run Something

For the following commands, first

     type command
     command

e.g.

     type eg0
     eg0

Hand in one file with 5 lines of text describing each eg.

The commmands are

    eg0 eg1 eg2
    eg3 eg4 eg5
    eg6 eg7 eg8
    eg9 eg10

Notes:

- Hint. Read the notes in https://github.com/dotninjas/dotninjas.github.io/blob/master/ninja/ninja.rc.md
- To understand eg5, look up [this paper](http://menzies.us/pdf/07precision.pdf) and read the definitions
column2, page1.
- For eg6, answer the following question. Is this code doing stratified cross-validation (read more
[here](https://en.wikipedia.org/wiki/Cross-validation_(statistics)#k-fold_cross-validation).
- For eg8, what is a _named column_?
- For eg9, note that eg8 has to be run first.
     - What is the advantage (if any) of separating
     (a)the reporting of a data mining run (as done in eg9) from (b)the execution of that run (as done in eg8)?
     - When do shells scripts like 
- For eg10, write 2 lines describing any _two_ of the following learners j48, jrip,nb, rbfnet bnet
     - Browse ninja.rc till you find the definition of that function; e.g. rbfnet
     - Look up its class name; e.g. RBFNetwork
     - Go to http://wiki.pentaho.com/display/DATAMINING/RBFNetwork and search (top right).
     - Go to the package definition (usually, first search return).
     - Read!
     - By the way, for some  cool notes on bnet, see [here](http://weka.sourceforge.net/manuals/weka.bn.pdf)

____

## Working with Cloud9

As of June 2015, the procedure for doing that was:

+ Go to Github and create an empty repository.
+ Log in to Cloud9 using your GitHub username (at `http://c9.io`, there is a button for that, top right).
+ Hit the green _CREATE NEW WORKSPACE_ button
    + Select _Clone from URL_;
    + Find _Source URL_ and enter in `http://github.com/you/yourRepo`
	+ Wait ten seconds for the screen to change.
	+ Hit the green _START EDITING_ button. 

This will drop you into the wonderful Cloud9
integrated development environment. Here, you can
edit code and backed up your code outside Cloud9, over at
`Github.com` (which means that if ever Cloud9 goes
away, you will still have your code).

The good news about Cloud9 is that it is very easy
to setup and configure. The bad news is that each
Cloud9 workspace has the same limits as Github- a
1GB size limit. Also, for CPU-intensive
applications, shared on-line resources like Cloud9
can be a little slow. That said, for the newbie,
Cloud9 is a very useful tool to jump start the
learning process.

For sites other than Cloud9, see Koding, Nitrous.IO and many more besides.


