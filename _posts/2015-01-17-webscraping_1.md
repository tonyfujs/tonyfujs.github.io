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

While playing with the relatively new rvest package, I thought I would give a shot at writing an intro to webscraping that follows the same principles.

### Webscraping objective:
What I want want to achieve is very simple. I want to download the most recent tweets about the #rstats hashtag on my computer, and save it in a user friendly format (aka a table). These are the steps I'm going to follow:

1. Get data from the twitter page (www.twitter.com)
2. Extract the information I need
3. Turn that information into tabular format
4. Save on my computer

## STEP 1: Get data from Twitter
The most recent tweets about #rstats can be found at the following url: [https://twitter.com/hashtag/rstats?f=realtime](https://twitter.com/hashtag/rstats?f=realtime)
The following R code read and parse the html code from the wmata homepage


<pre><code class="prettyprint ">library(rvest) # Load the rvest package
url &lt;- 'https://twitter.com/hashtag/rstats?f=realtime' # Create a variable holding the url information
twitter &lt;- html(url) # Parse the html code downloaded from url</code></pre>

The `twitter` variable now holds raw html code. You can see this by entering `print(twitter)` in your R console.

## STEP 2: Extract the information we need
I just want 3 pieces of information:
* Twitter usernames
* Body of tweets
* Number of time tweets were favorited

The `twitter` variable holds the information I need, but it also holds a lot of stuff I don't need. In order to extract specific pieces of information from a webpage, you need to know a few things:
1. Similar pieces of information have the same identifier.
2. This identifier is called a css selector
3. You can easily find out the css selectors of the pieces of information you are interested in by using a very handy tool called Selector Gadget. Watch the 2 minutes tutorial [here](http://selectorgadget.com/).

Using these css selectors and the `rvest` package, it is now really easy to extract specific pieces of information from our `twitter` variable.



<pre><code class="prettyprint ">## Extract tweets
tweets &lt;- html_nodes(twitter, &quot;.tweet-text&quot;) # Extract raw tweets
tweets &lt;- html_text(tweets) # Remove html tags
print(tweets[1:3]) # Print the first 3 tweets</code></pre>



<pre><code>## [1] &quot;MT @sqlbelle: Shared from Stephane Frechette Good tutorial: How to transition from Excel to #Rstats https://lnkd.in/bYUqpZZ \&quot;&quot;                       
## [2] &quot;\&quot;Scripting and #HCS Tools in #KNIME\&quot; workshop at #KNIME UGM #Berlin Feb 27 http://www.knime.org/ugm2015  #data #rstats #molecule #biology #genetics&quot;
## [3] &quot;#rstats blog post by @opencpu: Introducing js: tools for working with JavaScript in R https://www.opencpu.org/posts/js-release-0-1 …&quot;
</code></pre>



<pre><code class="prettyprint "># Extract user name
users &lt;-  html_nodes(twitter, &quot;.js-action-profile-name b&quot;)
users &lt;- html_text(users)
print(users[1:3])</code></pre>



<pre><code>## [1] &quot;GGorczynski&quot; &quot;knime&quot;       &quot;pogrebnyak&quot;
</code></pre>



<pre><code class="prettyprint "># Extract number of time tweet was favorited
favorited &lt;- html_nodes(twitter, &quot;.js-actionFavorite .ProfileTweet-actionCountForPresentation&quot;)
favorited &lt;- html_text(favorited)
print(favorited[1:3])</code></pre>



<pre><code>## [1] &quot;&quot; &quot;&quot; &quot;&quot;
</code></pre>

## STEP 3: Turn to tabular format
Here I just put together in one table the tweets, users, and favorited vectors.


<pre><code class="prettyprint ">my_table &lt;- cbind(users, tweets, favorited)</code></pre>

## STEP 4: Save on my computer
Finally, I save `my_table` as a .csv file named "rstat_tweets.csv". The file will be saved in the working directory.

<pre><code class="prettyprint ">write.table(my_table,  
            file = 'rstat_tweets.csv', 
            sep = ',', 
            row.names = FALSE)</code></pre>

That's it!! Hopefully this post is short and simple enough to get anyone started in 15 minutes. Feel free to contact me if you get stuck.

