

# Foundations of Software Science 

<img src="/_img/mad.jpg" align=right width=300>

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

## But Why "Software Science" and not plain-old "Data Science"

Because software science is different. Consider what it means to reason about software:

1. No underlying physical/chemical theory we can rely on for reasoning from first principles.  No background theory
(e.g. Black–Scholes or E=mc^2). Welcome to Simon's
[science of the artificial](http://courses.washington.edu/thesisd/documents/Kun_Herbert%20Simon_Sciences_of_the_Artificial.pdf): a constantly changing phenomena which we keep changing, every time we study it.

2. Constantly changing effects: new developers, new platforms, new tools, new tasks.

3. Socio-technical factors that mean we cannot reason just about software but we also have to reason over the communities of people that design, build, use, and host those tools

4.   A fundamental simplicity to the thing we are modeling (software). Welcome to Devanbu's [naturalness of software](http://macbeth.cs.ucdavis.edu/natural.pdf):
       - <em> Programmingg languages, in theory, are complex, flexible
and powerful, but the programs that real people
actually write are mostly simple and rather repetitive,
and thus they have usefully predictable statistical properties
that can be captured in statistical language models
and leveraged for software engineering tasks.</em>

5. While other communities might be content to use data science software tools, built by others, software scientists know how
to maintain and extend and deply rapdily changing software. Hence software scientists are well equiped to change and improve
data science tools. 

Points 1+2 means we must always be modeling, always checking old theories,
never accepting the models from other people without due diligence.  

Point 3 means that human factors will always be intruding and confusing any trite  mathematical characterization of the system (so   forget any notion of data being generated from some simple stochastic data model-- we will have to hunt
for that signal using a range of algorithmic tools or creative visualizations).

If that sounds all too hard, then remember point 4. Naturalness is what makes it possible to understand software using
simple  models (which is [James Larus](https://www.youtube.com/watch?v=kO9OYnkeRTM)'s point).  So, sure, sometimes,  we
need deep learning etc etc for some complex text,video, audio
artifacts. But also, for most other things we can generate
simple models that people can use. And simplicity means comprehenssibility and usability.
 
Finally, point 5 means that software scientists are sources of innovation and improvement for data science tools.