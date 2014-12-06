# Author: kmr

fooddata = read.table("C:/Users/Kit/Desktop/allFT.csv", header=TRUE, sep=",")

fooddata = within(fooddata, {
  loc = ifelse(city == "New York", "501",
               ifelse(city == "Atlanta", "524",
                      ifelse(city == "Portland", "820",
                             ifelse(city == "Washington DC", "511",
                                    ifelse(city == "Charlotte", "517",
                                           ifelse(city == "Houston", "618",
                                                  ifelse(city == "Los Angeles", "803",
                                                         ifelse(city == "Chicago", "602",
                                                                ifelse(city == "Denver", "751",
                                                                       ifelse(city == "Kansas City", "616", 0))))))))))
  
  pc_count = count/TotPop
  pc_tweets = tweets/TotPop
  
})
