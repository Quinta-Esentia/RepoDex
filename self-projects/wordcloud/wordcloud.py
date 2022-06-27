# -*- coding: utf-8 -*-
"""
Created on Thu Jan 14 14:02:41 2021

@author: https://www.geeksforgeeks.org/generating-word-cloud-python/
"""

# Python program to generate WordCloud 
  
# importing all necessery modules 
from wordcloud import WordCloud, STOPWORDS 
import matplotlib.pyplot as plt 
import pandas as pd 
import os


# Dataset Link : https://archive.ics.uci.edu/ml/machine-learning-databases/00380/

# Reads 'Youtube04-Eminem.csv' file  
directory = r'C:\Users\Dexter.Camison2\Documents\Rio Grad Projects\Self Projects\wordcloud'
df = pd.read_csv(os.path.join(directory,"Youtube04-Eminem.csv"), encoding ="latin-1") 

#%% 2. View data
print(df.columns)
with pd.option_context('display.max_rows', None, 'display.max_columns', None, 'display.max_colwidth', 65):  
    print(df[['AUTHOR', 'CONTENT', 'CLASS']])
#%%
comment_words = '' 
stopwords = set(STOPWORDS) 
stopwords = stopwords.update([r'â â', r'ï', ])
  
# iterate through the csv file 
for val in df.CONTENT: 
      
    # typecaste each val to string 
    val = str(val) 
  
    # split the value 
    tokens = val.split() 
      
    # Converts each token into lowercase 
    for i in range(len(tokens)): 
        tokens[i] = tokens[i].lower() 
      
    comment_words += " ".join(tokens)+" "
  
wordcloud = WordCloud(width = 800, height = 800, 
                background_color ='black', 
                stopwords = stopwords, 
                min_font_size = 10).generate(comment_words) 
  
# plot the WordCloud image                        
plt.figure(figsize = (8, 8), facecolor = None) 
plt.imshow(wordcloud) 
plt.axis("off") 
plt.tight_layout(pad = 0) 
  
plt.show() 



#%%
df['CLASS'].value_counts()
df_filtered= df.loc[df['CLASS'] == 0, ['AUTHOR', 'CONTENT']]

 
# iterate through the csv file 
for val in df_filtered['CONTENT']: 
      
    # typecaste each val to string 
    val = str(val) 
  
    # split the value 
    tokens = val.split() 
      
    # Converts each token into lowercase 
    for i in range(len(tokens)): 
        tokens[i] = tokens[i].lower() 
      
    comment_words += " ".join(tokens)+" "
  
wordcloud = WordCloud(width = 800, height = 800, 
                background_color ='black', 
                stopwords = stopwords, 
                min_font_size = 10).generate(comment_words) 
  
# plot the WordCloud image                        
plt.figure(figsize = (8, 8), facecolor = None) 
plt.imshow(wordcloud) 
plt.axis("off") 
plt.tight_layout(pad = 0) 
  
plt.show() 

