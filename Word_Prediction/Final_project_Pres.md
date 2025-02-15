
Word Prediction
========================================================
**Coursera**
Final Project of the *Data Science Specialization*

**Word Prediction!**

Author: DLE             
Date: 11-06-2018

Presentation
=========================================================
This Presentation document is created in relation to the **Data Science Specialization** course available on Coursera.

*The Goal for the eventual Shiny App:*
- Speed : The algorithm has to be somewhat quick. 
- Efficiency : The algorithm has to be able to find a correct word prediction given the context
- Flexibility : The algorithm should provide flexibility in the choice of words prediction 
- Replicability : The algorithm should be able to use easily other past words in the prediction model

At first glance, the model will be based on a variety of n-grams that will be converted in matrix and stored for a quicker access.
This matrix of probability is easily comparable to the **Graph Theory** where more benefical statistics could be used to enhance the current model in development.


Pros and Cons
=========================================================
+ Nice illustration
+ Calculation of key statistics for further research
+ Easlily implemented using other network graph of words

One of the key feature is the possibility to build sub-graph model that uses more specific words or conversation which can be easily weighted in the current graph prediction model.

The following is a basic plot of the weighted frequency of certain words. 

![plot of chunk wordcloud](./WWW/WordCloud.png)


Data Storage RunTime Efficiency
========================================================

When compariing the methodologies using DataFrame and Matrix storagage we can easily see that the sparse matrix storage provide a memory efficient way to store the data.
the 4 dataframe represent a weight of 1740 Mb and the Sparse matrix representation is only using only 151 Mb as Storage and the names represent 460Mb as weight. In order to quicken the import we bundled the matrices with their name which create a total weight of 1071 Mb. 

The final model was implemented using Matrices, even though it is not the fastest model for the moment, we assume that some further training set and tuning could turn this model as the one with the best usefulness. Moreover, the current work is made in order to think outside of the box and try something I haven't seen online or anywhere.

While Memory usage is important, the runtime can be even more central in a decision of using any types of algorithm.

|                             | nb_lines_training|
|:----------------------------|-----------------:|
|nb.words in Blogs training   |           3701739|
|nb.words in News training    |            260748|
|nb.words in Twitter training |           2958116|


|                            | nb_lines_training|
|:---------------------------|-----------------:|
|nb.line in Blogs training   |             89928|
|nb.line in News training    |              7725|
|nb.line in Twitter training |            236014|



Creating the model
====================================================================

The following list is the step used to build the model
- Creation of the first 4 Ngram models after some cleaning have been done using regular rule in the text-mining analysis industry
- Creation of the dataframe using the "quanteda" library
        -The first step was to create a frequency matrix and then transform this matrix in a adjacency matrix and the graph                  structure
- Creation of the model using the different network to predict the netxt words
- The sentence to be checked is passed trough the cleaning function to allow the word to be "converted" to the same language as the network

*The model looks into the 4 ngrams network structure in order to finds if there is any match that fit the current sentence*

