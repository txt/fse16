[<img width=900 src="https://raw.githubusercontent.com/txt/fss16/master/img/fss16.png">](http://tiny.cc/fss2016)   
[Home](http://tiny.cc/fss2016) |
[At a glance...](https://github.com/txt/fss16/blob/master/doc/glance.md) |
[Syllabus](https://github.com/txt/fss16/blob/master/doc/syllabus.md) |
[Submit](http://tiny.cc/fss2016give) |
[Discuss](https://fss16.slack.com/) |
[Lecturer](http://menzies.us) |
[&copy; 2016](https://github.com/txt/fss16/blob/master/LICENSE.md) tim@menzies.us


# Lecture 1

![](http://tiny.cc/lecturing)

Agenda:

+ Hellos
+ Why this subject is different (naturalness of software)

## About this subject.

![](../img/science.png)

_Science_ is about making and maintaining and monitoring our best current guesses about X,Y,Z...

- "All models are wrong, but some are useful." -- George Box
- Sure, data supports many models, many "truths"
      - But there are lot more "wrongs" that are not supported in any data set
- It is the grease beneath the wheels of insight
      - The tool that drives us to being probably more right-er than wrong-er  
- And the most important moment in science is not "Eureka!" but "huh, that's odd".

(BTW, for a formal model of science, see Kuhn and "science as refuation")

Sometimes, data science is _science_:

- Science is about communities discussing and improving refutable conclusions.

- But, sadly, some data science is just about vendors selling you their latest whiz bang tool/service
       - How to check?
       - Are communities constantly checking old beilefs and updating their ideas w.r.t. new ones?
       - Are conclusions replayable (so not 1000 clicks in a pretty GUI but a script that can re-run)

Sometimes data science is about _software science_:

- Software science is about software engineering projects
       - So a software scientist needs to know much about software engineering
       - Hence, nearly a quarter of the marks in this subject are from reading assignments
- Software science is about an set of experimental standards accepted by this community:
       - Which we will teach by example in this class
- IMHO, Software science cannot be about general models of SE
       - But cost effective ways of finding local models?
       - Why?
               - Constantly changing effects: new developers, new platforms, new tools, new tasks.
               - Socio-technical factors that mean we cannot reason just about software but we also have to reason over the communities of people that design, build, use, and host those tools
               - No underlying physical/chemical theory we can rely on for reasoning from first principles.  No background theory
(e.g. Black–Scholes or E=mc^2). Welcome to Simon's
[science of the artificial](http://courses.washington.edu/thesisd/documents/Kun_Herbert%20Simon_Sciences_of_the_Artificial.pdf): a constantly changing phenomena which we keep changing, every time we study it.
- Software science is about refutable conclusions
      - So all our code will be sharable, in Github
      - Our projects will include preproduction packages that allow people to take our code and repeat
        the analysis
       
- Software engineering has some remarkable _natural_ properties:
       - <em>Programming languages, in theory, are complex, flexible
and powerful, but the programs that real people
actually write are mostly simple and rather repetitive,
and thus they have usefully predictable statistical properties
that can be captured in statistical language models
and leveraged for software engineering tasks.</em> <br> -- Devanbu et al. [naturalness of software](http://macbeth.cs.ucdavis.edu/natural.pdf)
- This leads to some remarkably simple results that are most useful
        - [Watch James Larus video](https://www.youtube.com/watch?v=kO9OYnkeRTM)
        - [Read Matt Martin's poster](http://tiny.cc/iposter)
        point).
        - e.g. the strange tale of NASA's [text-based severity defect prediction](http://menzies.us/pdf/07anomalies-pits.pdf)
        - e.g. give me 3 variables and [I can predict project effort](http://menzies.us/pdf/05chen.pdf)

_Software science_ also studies its own software:

- As software engineers, we are the people who are most suspicious of our software(hell, we wrote it,
and we know how dumb we can be)
- regression suites, on-line comment forums, code that others can fork improve and (maybe) be merged back within our own code.
- Otherwise, people can get hurt
     - Space shuttle Columbia ice strike (size= 1200 cm<sup>3</sup>
Speed: 477 mpg


Certified as “safe” by CRATER  
micro-meteorite software model
Typical  CRATER training example:
Speed: 100 mpg
Size: 3 cm3  


Lesson: conclusions should come with “certification envelope”
Raise alert when new problems fall outside of old envelope 
What else should learners come with?


## Resources

### Data sets

So many places. Too many to list. One place to start:

![](../img/promise.png)

Software Analytics, So What?

- [Menzies and Zimemrmann, 2013](http://ieeexplore.ieee.org/stamp/stamp.jsp?reload=true&arnumber=6547619)
-  Argues that before we ask "what tool to use?" we ask "what questions are useful to  ask, a lot"
- Initially, we have to ask many many questions before we find the most useful ones
- Finally, we can code tools to make those "most useful questions" easy to be asked.

![](../img/questions.png)

Recent books on software analytics (optional, no need to buy)

- 2014: Me and my friends:  [Sharing Data and Models[(https://www.amazon.com/Sharing-Data-Models-Software-Engineering/dp/0124172954). Come geek out with timm!
- 2015: Details, from the mining software repositories community: [The Art and Science of Analzyzing
Software Data](https://www.amazon.com/Art-Science-Analyzing-Software-Data/dp/0124115195/ref=pd_sim_14_1?ie=UTF8&dpID=51oNmb8bLJL&dpSrc=sims&preST=_AC_UL160_SR130%2C160_&psc=1&refRID=MG3VE0637M484XBQ7Z9Q) : 100s of top names in SE
- 2016: For a broader view: lists dozens of small ``mantras'' of software science:
[Perspectived on Data Science](https://www.amazon.com/Perspectives-Data-Science-Software-Engineering/dp/0128042060/ref=sr_1_1?s=books&ie=UTF8&qid=1471278031&sr=1-1&keywords=perspectives+on+data+science)

![](../img/books3.png)
  




Slides: [Data Science<sup>2</sup>](https://docs.google.com/presentation/d/18kEQKcHFuJ95uEtUygryxiY9ZQdYDl6jX9PQFTdggRM/edit?usp=sharing)


Most software companies now learn their policies via
data-driven methods. Modern practitioners treat
every planned feature as an experiment, of which
only a few are expected to survive. Key performance
metrics are carefully monitored and analyzed to
judge the progress of a feature. Even simple design
decisions such as the color of a link are chosen by
the outcome of software experiments.

This subject will explore methods for designing data
collection experiments; collecting that data;
exploring that data; then presenting that data in
such a way to support business-level decision making
for software projects.

#

## But Why "Software Science" and not plain-old "Data Science"

Because software science is different. Consider what it means to reason about software.

Software Science is about software engineering which means that effective software scientists need extensive domain knowledge about software engineering.


2. While other communities might be content to use data science software tools, built by others, software scientists know how
to maintain and extend and deply rapdily changing software. Hence while  AI researchers might be the source of 
better data miners algorithms, it is software  scientists who package and wrap those algorithms
in environments that support usability, reproducibility, maintainability and scalability.

3. Extensive sets of standard for what is a valid experiment.

4. Software scientists must explain their results to software engineerings-- who are busy people. Hence, software
scientists need to be very concerned about the comprehensibility of the learned models.

4. The inherent complexity of the task of software science:
     - Constantly changing effects: new developers, new platforms, new tools, new tasks.
     - Socio-technical factors that mean we cannot reason just about software but we also have to reason over the communities of people that design, build, use, and host those tools
     - No underlying physical/chemical theory we can rely on for reasoning from first principles.  No background theory
(e.g. Black–Scholes or E=mc^2). Welcome to Simon's
[science of the artificial](http://courses.washington.edu/thesisd/documents/Kun_Herbert%20Simon_Sciences_of_the_Artificial.pdf): a constantly changing phenomena which we keep changing, every time we study it.

5.  At the same time, inherent simplicities in the data we study:

    - A fundamental simplicity to the thing we are modeling (software). Welcome to Devanbu's [naturalness of software](http://macbeth.cs.ucdavis.edu/natural.pdf):
          - <em> Programmingg languages, in theory, are complex, flexible
and powerful, but the programs that real people
actually write are mostly simple and rather repetitive,
and thus they have usefully predictable statistical properties
that can be captured in statistical language models
and leveraged for software engineering tasks.</em>


6. Finally, software engineers are engineers and hence are duty bound to follow
ethical practices in their work. Appropriate ethics for data science is still an
evolving area-- which means that software scientists have to be more alert to
  ethical issues that  other kinds of data scientists 

Point 2  means that software scientists are
sources of innovation and improvement for data
science tools.

Points 4 means we must always be modeling, always
checking old theories,
never accepting the models from other people without due diligence.  

And point 5 makes everything possible.
Naturalness is what makes it possible to
understand software using simple models (which is
[James Larus](https://www.youtube.com/watch?v=kO9OYnkeRTM)'s
point).  So, sure, sometimes, we need deep learning
etc etc for some complex text,video, audio
artifacts. But also, for most other things we can
generate simple models that people can use. And
simplicity means comprehenssibility and usability.
 


