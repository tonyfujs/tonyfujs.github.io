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


<pre><code class="prettyprint ">library(rvest)
url &lt;- 'http://www.wmata.com/'
wmata &lt;- html(url)</code></pre>

## STEP 2: Extract the information we need
I just want 2 pieces of information:
* Name of the metro line
* Status of the metro line

In order to extract specific pieces of information from a webpage, you need to know x things:
1. Similar pieces of information have the identifier.
2. This identifier is called a css selector
3. You can easily find out css selectors using a very handy tool called [selectorGadget](http://selectorgadget.com/)

`rvest` makes really easy to extract specific pieces of information from our `wmata` object.



<pre><code class="prettyprint ">## Extract lines names
lines &lt;- html_nodes(wmata, &quot;#homepage-box-inner td:nth-child(2)&quot;)
# Remove html tags &amp; keep only text information
lines &lt;- html_text(lines)
lines</code></pre>



<pre><code>## [1] &quot;Red Line&quot;    &quot;Orange Line&quot; &quot;Silver Line&quot; &quot;Blue Line&quot;   &quot;Yellow Line&quot;
## [6] &quot;Green Line&quot;
</code></pre>


<pre><code class="prettyprint ">## Extract service status information
status &lt;-  html_nodes(wmata, &quot;.dropt_rail a&quot;)
status &lt;- html_text(status)
status</code></pre>



<pre><code>## [1] &quot;Alert&quot; &quot;Alert&quot; &quot;Alert&quot; &quot;Alert&quot; &quot;Alert&quot; &quot;Alert&quot;
</code></pre>

## STEP 3: Turn to tabular format


<pre><code class="prettyprint ">output &lt;- cbind(lines, status)
output &lt;- as.data.frame(output)</code></pre>

## STEP 4: Save on my computer

<pre><code class="prettyprint ">write.table(output,  
            file = 'metro_status.csv', 
            sep = ',', 
            row.names = FALSE)</code></pre>


![](/images/webscraping/hydrant.jpg)
