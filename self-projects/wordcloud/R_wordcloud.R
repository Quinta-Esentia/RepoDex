# Create a Word Cloud with R
# https://towardsdatascience.com/create-a-word-cloud-with-r-bde3e7422e8a

# install.packages("wordcloud")
library(wordcloud)
# install.packages("RColorBrewer")
library(RColorBrewer)
# install.packages("wordcloud2")
library(wordcloud2)


# If you're analysing twitter data, simply upload your data by using the rtweet package (see this article for more info on this). 
# https://towardsdatascience.com/a-guide-to-mining-and-analysing-tweets-with-r-2f56818fdd16
# install.packages("rtweet")
library (rtweet)



# Most often, word clouds are used to analyse twitter data or a corpus of text. 
# If you're working on a speech, article or any other type of text, 
# make sure to load your text data as a corpus. A useful way to do this is to use the tm package.

# install.packages("tm") 
library(tm)
#Create a vector containing only the text
text <- data$text
# Create a corpus  
docs <- Corpus(VectorSource(text))
