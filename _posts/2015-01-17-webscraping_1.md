---
layout: post
title: "10 minutes intro to webscraping with R: Part 1"
---

Learning new stuff is great... As long as you don't drawn under tons of details irrelevant to newbies.

![](/images/webscraping_1/hydrant_2.jpg =512x)

When learning about a new topic, this is my ideal start:

1. Get a quick - and hopefully intuitive - overview
2. Get my hands dirty. (Reading is great, but if learning how to bike, you'll need to climb on a bike at some point)
3. Dig deeper as needed - And only as needed.

This is why I loved [Hilary Parker's post](http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/) on R packages: It gives you the gist of what an R package is and can do for you, allows you to build your first package in 10 minutes, and gives you references to learn more if you want to.

While playing with the relatively new rvest package, I thought I would give a shot at writing a short and easy to follow intro to webscraping.

### Webscraping objective:
What I want want to achieve is very simple. I want to download the most recent tweets about the #rstats hashtag on my computer, and save them in a user friendly format (aka a table). These are the steps I'm going to follow:

1. Get data from the twitter page (www.twitter.com)
2. Extract the information I need
3. Turn that information into tabular format
4. Save on my computer

## STEP 1: Get data from Twitter
The most recent tweets about #rstats can be found at the following url: [https://twitter.com/hashtag/rstats?f=realtime](https://twitter.com/hashtag/rstats?f=realtime)
The following R code read and parse the [html](https://www.khanacademy.org/computing/computer-programming/html-css/intro-to-html/v/making-webpages-intro) code from the twitter page.


{% highlight r lineos %}
# Load the rvest package
library(rvest) 
# Create a variable holding the url information
url <- 'https://twitter.com/hashtag/rstats?f=realtime' 
# Parse the html code downloaded from url
twitter <- html(url) 
{% endhighlight %}

The `twitter` variable now holds parsed html code. You can see this by entering `print(twitter)` in your R console.

## STEP 2: Extract the information I need
I just want 3 pieces of information:

* Twitter usernames
* Body of tweets
* Number of time tweets were favorited

The `twitter` variable holds the information I need, but it also holds a lot of stuff I don't need. In order to extract specific pieces of information from a webpage, you need to know a few things:

1. Similar pieces of information have the same identifier.
2. This identifier is called a [css selector](http://flukeout.github.io/)
3. You can easily find out the css selectors of the pieces of information you are interested in by using a very handy tool called Selector Gadget. Watch the 2 minutes tutorial [here](http://selectorgadget.com/).

Using these css selectors and the `rvest` [package](http://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/), it is now really easy to extract specific pieces of information from our `twitter` variable.



{% highlight r lineos %}
## Extract tweets
# Extract raw tweets
tweets <- html_nodes(twitter, ".tweet-text")
# Remove html tags
tweets <- html_text(tweets) 
# Extract user name
users <-  html_nodes(twitter, ".js-action-profile-name b")
users <- html_text(users)
# Extract number of time tweet was favorited
favorited <- html_nodes(twitter, ".js-actionFavorite .ProfileTweet-actionCountForPresentation")
favorited <- html_text(favorited)
{% endhighlight %}

## STEP 3: Turn to tabular format
Here I just put together in one table the tweets, users, and favorited vectors.


{% highlight r lineos %}
my_table <- cbind(users, tweets, favorited)
{% endhighlight %}

## STEP 4: Save on my computer
Finally, I save `my_table` as a .csv file named "rstat_tweets.csv". The file will be saved in the working directory.

{% highlight r lineos %}
write.table(my_table,  
            file = 'rstat_tweets.csv', 
            sep = ',', 
            row.names = FALSE)
{% endhighlight %}

That's it!! Hopefully this post is short and simple enough to get anyone started in 15 minutes. Part 2 will follow soon, and focus on automating this webscraping process.

For more information about webscraping with R, a good reference is [Automated Data Collection with R](http://www.amazon.com/Automated-Data-Collection-Practical-Scraping/dp/111883481X).

