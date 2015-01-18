---
layout: post
title: "10 minutes intro to webscraping with R: Part 1"
---

Learning new stuff is great... too much information... overwhelmed

What works for me:
1. Get a quick overview
2. Be able to implement something myself
3. Dig deeper as needed

Hilary Parker's great post on R packages

Introduction to webscraping: Simple, easy to reproduce in 10 minutes, link to more detailed explanations if you fill like digging deeper into the subject.

What I want want to achieve is very simple. I want to download the DC Metro Status information on my computer, and save it in a user friendly format (aka a table). These are the steps I'm going to follow:

1. Get data from the DC Metro webpage (www.wmata.com)
2. Extract the information we need
3. Turn to tabular format
4. Save on computer

## STEP 1: Get data from DC Metro webpage
Service status information are displayed on the site homepage: www.wmata.com
The following R code read and parse the html code from the wmata homepage


{% highlight r %}
library(rvest)
url <- 'http://www.wmata.com/'
wmata <- html(url)
{% endhighlight %}

## STEP 2: Extract the information we need
I just want 2 pieces of information:
* Name of the metro line
* Status of the metro line

In order to extract specific pieces of information from a webpage, you need to know x things:
1. Similar pieces of information have the identifier.
2. This identifier is called a css selector
3. You can easily find out css selectors using a very handy tool called [selectorGadget](http://selectorgadget.com/)

`rvest` makes really easy to extract specific pieces of information from our `wmata` object.



{% highlight r %}
## Extract lines names
lines <- html_nodes(wmata, "#homepage-box-inner td:nth-child(2)")
# Remove html tags & keep only text information
lines <- html_text(lines)
lines
{% endhighlight %}



{% highlight text %}
## [1] "Red Line"    "Orange Line" "Silver Line" "Blue Line"   "Yellow Line"
## [6] "Green Line"
{% endhighlight %}


{% highlight r %}
## Extract service status information
status <-  html_nodes(wmata, ".dropt_rail a")
status <- html_text(status)
status
{% endhighlight %}



{% highlight text %}
## [1] "Alert" "Alert" "Alert" "Alert" "Alert" "Alert"
{% endhighlight %}

## STEP 3: Turn to tabular format


{% highlight r %}
output <- cbind(lines, status)
output <- as.data.frame(output)
{% endhighlight %}

## STEP 4: Save on my computer

{% highlight r %}
write.table(output,  
            file = 'metro_status.csv', 
            sep = ',', 
            row.names = FALSE)
{% endhighlight %}


![](/images/webscraping/hydrant.jpg)
