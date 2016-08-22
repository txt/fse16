



# DON'T READ THIS

still rough notes fro after lecture

_____

# Review1


what the big ms conclusion re how to predict bugs

- what aspects of the programming languages being used for
  development where used in that "great predictor"

data science and data dabblers

science refutation. vendor. visualization, inference. data base

give examples of data-driven reasoing
- in general population
- in se

menzies beleives in no generality bcause...

nauturalness. language models

sociton-technical systems

agile, regression suites. etc. qeuuailce for softwre science?

dangers of self test:

- bias/variance trade-off
http://scott.fortmann-roe.com/docs/docs/BiasVariance/biasvariance.png
http://inside-bigdata.com/wp-content/uploads/2014/10/Bia_variance_tradeoff_fig.jpg
http://blog.fliptop.com/blog/2015/03/02/bias-variance-and-overfitting-machine-learning-overview/

http://www.astroml.org/sklearn_tutorial/practical.html

3.4.1. High Bias

If our algorithm shows high bias, the following actions might help:

Add more features. In our example of predicting home prices, it may be helpful to make use of information such as the neighborhood the house is in, the year the house was built, the size of the lot, etc. Adding these features to the training and test sets can improve a high-bias estimator
Use a more sophisticated model. Adding complexity to the model can help improve on bias. For a polynomial fit, this can be accomplished by increasing the degree d. Each learning technique has its own methods of adding complexity.
Use fewer samples. Though this will not improve the classification, a high-bias algorithm can attain nearly the same error with a smaller training sample. For algorithms which are computationally expensive, reducing the training sample size can lead to very large improvements in speed.
Decrease regularization. Regularization is a technique used to impose simplicity in some machine learning models, by adding a penalty term that depends on the characteristics of the parameters. If a model has high bias, decreasing the effect of regularization can lead to better results.
3.4.2. High Variance

If our algorithm shows high variance, the following actions might help:

Use fewer features. Using a feature selection technique may be useful, and decrease the over-fitting of the estimator.
Use more training samples. Adding training samples can reduce the effect of over-fitting, and lead to improvements in a high variance estimator.
Increase Regularization. Regularization is designed to prevent over-fitting. In a high-variance model, increasing regularization can lead to better results.
These choices become very important in real-world situations. For example, due to limited telescope time, astronomers must seek a balance between observing a large number of objects, and observing a large number of features for each object. Determining which is more important for a particular learning task can inform the observing strategy that the astronomer employs. In a later exercise, we will explore the use of learning curves for the photometric redshift problem.

points vsersus samples

Cross-val

eval defs (prec etc). include the precision paper

decisions trees.. how do they work?

entropy


pipe and filter. defs

examples

