# -*- coding: utf-8 -*-
"""
Created on Tue Oct 28 11:44:02 2014 
@author: kmr
"""
import urllib2
from bs4 import BeautifulSoup
import MySQLdb as myDB
import pandas as pd


################################################################

# Update with your SQL username and password 
conn = myDB.connect(host='localhost',
                    user='root',
                    passwd='password',
                    db='foodtrendsDB') 
                            
#################################################################

searchData = []

# Scrape baseURL using given locations and searchwords
def scrape(baseURL, locations, searchwords):    
    locCodes = []
    for entry in locations:
       locCodes.append(entry[1])
    
    for code in locCodes:
        for word in searchwords:
            page = str(baseURL+'s/'+str(code)+'?q='+word)
            soup = BeautifulSoup(urllib2.urlopen(page))
            
            # Find number of restaurants with searchword
            result = soup.find('h1')
            result = str(result.text.strip())
            i = result.index('r')
            result = result[:i-1]
            
            # Collect price level for those restaurants
            data = soup.findAll('span',{'class':'price'})
            pricedata = []
            for entry in data:
                a = str(entry)[:24]
                level = a.count('$')
                pricedata.append(level)    
            
            searchData.append([code, word, result, average(pricedata),\
            median(pricedata)])
    
    # Convert location codes to city names in results list
    for entry in searchData:
        for loc in locations:
            if entry[0]==loc[1]:
                entry[0]=loc[0]
            
    
def exportData(source, name):    
    myDF2 = pd.DataFrame()  
    
    for result in source:
        city = [result[0]] 
        searchterm = [result[1]] 
        if searchterm == 'taco':
            searchterm = searchterm + 's'
        count = [result[2]]
        avgprice = [result[3]]
        medprice = [result[4]]        
        
        
        # Create dictionary with results
        mydict = {
            'city' : city,
            'searchterm' : searchterm,
            'count' : count,
            'avgprice' : avgprice,
            'medprice' : medprice
            }      

        # Add dictionary to dataframe 
        myDF = pd.DataFrame(mydict)  
        myDF2 = myDF2.append(myDF)
    
    # Create SQL table from dataframe                            
    myDF2.to_sql(name, conn, flavor= 'mysql',\
    if_exists= 'replace')
        

###################################################################
                    
# Input data
URL = 'http://urbanspoon.com/'
foods = ['kale','bacon','tofu','chicken and waffles','taco','food truck',\
'dumplings','quinoa','gluten-free','sriracha']
cities = [['New York',3],['Atlanta',9],['Portland',24],['Washington DC',7],\
['Charlotte',38],['Houston',8],['Los Angeles',5],['Chicago',2],['Denver',17],\
['Kansas City',34]]

    
# Runs the functions
scrape(URL,cities,foods)
exportData(searchData, 'UrbanSpoon')
