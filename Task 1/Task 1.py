#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# In[91]:


data = pd.read_csv("C:/Users/DELL/Downloads/archive/netflix_titles.csv")
print(data)


# In[ ]:


# Exploring data in pandas


# In[67]:


data.describe()


# In[4]:


data.info()


# In[5]:


data.isnull()


# In[ ]:


# Handling missing values


# In[68]:


data.isnull().sum()


# In[69]:


data["date_added"]


# In[94]:


data.fillna(method = "ffill", inplace = True)


# In[95]:


data.isnull().sum()


# In[96]:


data.fillna(method = "bfill", inplace = True)


# In[97]:


data.isnull().sum()


# In[ ]:


# Handling duplicate rows


# In[74]:


data.duplicated()


# In[75]:


data.duplicated().sum()


# In[98]:


data.drop_duplicates()


# In[99]:


data.duplicated().sum()


# In[78]:


data.info()


# In[ ]:


# Convert data to dd-mm-yyyy


# In[101]:


data["date_added"] = pd.to_datetime(data["date_added"], errors = "coerce")
#print(data["date_added"])

data["date_added"] = data["date_added"].dt.strftime("%d-%m-%y")
print(data["date_added"])


# In[103]:


data["date_added"].isnull().sum()


# In[104]:


data.info()


# In[ ]:


# Column headers


# In[110]:


data.columns

