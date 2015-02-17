---
layout: post
title: "10 minutes intro to webscraping with R: Part 1"
---

Learning new stuff is great... As long as you don't drawn under tons of details that are directly relevant to a newbie.

![](/images/webscraping_1/hydrant_2.jpg)

When learning about a new topic, this is my ideal start:
1. Get a quick - and hopefully intuitive - overview
2. Get my hands dirty. (Ever tried learning how to bike by reading "Biking for dummies"?)
3. Dig deeper as needed - And only as needed.

This why I loved Hilary Parker's post on R packages: It gives you the gist of what an R package is and can do for you, allows you to build your first package in 10 minutes, and gives you references to learn more if you want to.

While playing with the relatively new rvest package, I thought I would give a shot at writing an intro to webscraping that follows the same principles. [INSERT SHORT DESCRIPTION OF WEBSCRAPING]

### Webscraping objective:
What I want want to achieve is very simple. I want to download the most recent tweets about the #rstats hashtag on my computer, and save it in a user friendly format (aka a table). These are the steps I'm going to follow:

1. Get data from the twitter page (www.twitter.com)
2. Extract the information I need
3. Turn that information into tabular format
4. Save on my computer

## STEP 1: Get data from DC Metro webpage
The most recent tweets about #rstats can be found at the following url: [https://twitter.com/hashtag/rstats?f=realtime](https://twitter.com/hashtag/rstats?f=realtime)
The following R code read and parse the html code from the wmata homepage


{% highlight r %}
library(rvest) # Load the rvest package
url <- 'https://twitter.com/hashtag/rstats?f=realtime' # Create a variable holding the url information
twitter <- html(url) # Parse the html code downloaded from url
{% endhighlight %}

The `twitter` variable now holds raw html code. You can see this by entering `print(twitter)` in your R console.

## STEP 2: Extract the information we need
I just want 3 pieces of information:
* Twitter usernames
* Body of tweets
* Number of time tweets were favorited

The `twitter` variable holds the information I need, but it also holds a lot of stuff I don't need. In order to extract specific pieces of information from a webpage, you need to know a few things:
1. Similar pieces of information have the same identifier.
2. This identifier is called a css selector
3. You can easily find out the css selectors of the pieces of information you are interested in by using a very handy tool called [selectorGadget](http://selectorgadget.com/)

[[vimeo-52055686-688x387]]

`rvest` makes really easy to extract specific pieces of information from our `wmata` object.



{% highlight r %}
## Extract lines names
lines <- html_nodes(wmata, "#homepage-box-inner td:nth-child(2)")
{% endhighlight %}



{% highlight text %}
## Error in html_nodes(wmata, "#homepage-box-inner td:nth-child(2)"): object 'wmata' not found
{% endhighlight %}



{% highlight r %}
# Remove html tags & keep only text information
lines <- html_text(lines)
{% endhighlight %}



{% highlight text %}
## Error in xml_apply(x, XML::xmlValue, ..., .type = character(1)): Unknown input of class: function
{% endhighlight %}



{% highlight r %}
lines
{% endhighlight %}



{% highlight text %}
## function (x, ...) 
## UseMethod("lines")
## <bytecode: 0x00000000082c1fe8>
## <environment: namespace:graphics>
{% endhighlight %}


{% highlight r %}
## Extract service status information
status <-  html_nodes(wmata, ".dropt_rail a")
{% endhighlight %}



{% highlight text %}
## Error in html_nodes(wmata, ".dropt_rail a"): object 'wmata' not found
{% endhighlight %}



{% highlight r %}
status <- html_text(status)
{% endhighlight %}



{% highlight text %}
## Error in inherits(x, "XMLAbstractDocument"): object 'status' not found
{% endhighlight %}



{% highlight r %}
status
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'status' not found
{% endhighlight %}

## STEP 3: Turn to tabular format


{% highlight r %}
output <- cbind(lines, status)
{% endhighlight %}



{% highlight text %}
## Error in cbind(lines, status): object 'status' not found
{% endhighlight %}



{% highlight r %}
output <- as.data.frame(output)
{% endhighlight %}



{% highlight text %}
## Error in as.data.frame(output): object 'output' not found
{% endhighlight %}

## STEP 4: Save on my computer

{% highlight r %}
write.table(output,  
            file = 'metro_status.csv', 
            sep = ',', 
            row.names = FALSE)
{% endhighlight %}



{% highlight text %}
## Error in is.data.frame(x): object 'output' not found
{% endhighlight %}



