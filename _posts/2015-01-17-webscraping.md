---
layout: post
title: "10 minutes intro to webscraping with R"
---

Intro goes here:
Blah blah blah

1. Get data from webpage
2. Extract the information we need
2. Turn to tabular format
3. Save on computer

## Get data from webpage


```r
library(rvest)
url <- 'http://www.wmata.com/'
raw <- html(url)
```


![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 


