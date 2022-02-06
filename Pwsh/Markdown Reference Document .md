# Markdown Reference Document

## Headings

**There are 6 types of Headings which are as below.**

# Header1

## Header2

### Header3

#### Header4

##### Header5

###### Header 6
_____________________________

# Emphasis

## Italics Letters

We can use italics in 2 different ways

_italics_ or *italics* both single underscore and single star are treated in same way

## Bold Letters

We can denote Bold letters in 2 different ways one by using two consecutive underscores (__) second by using two stars (**) for eg __im Bold__ or **Im Bold**

  

## Escape Characher

a Back slash \ is used as an escape character if we want the markdown engine to consider certain symbol as it is.

  

# Quote Example

  

A Greater then sign is use to denote a Quite for

> Quote: - Just Remember that you are absolutely unique.
>like everyone else

#

# Representing Source Code in Markdown

  

in order to represent a code we use Back Tick (\`) for eg  
 `get-childitem`

  

or

we can use **4 Tab spaces** and in some case just **1 Tab space** will also work before a code line and it will automatically be taken as a code for eg.

				Get-Childitem
				Get-Process
				Get-Service
				Get-Help
	Note:- inside of a code block all the special characters are avoided as exception.
# List in Markdown.
 we can denote a list in markdown by three characters \( * or + or - ) examples are as below.  
				 

* Item1

+ Item2

- item3

		**or we can also make the list as below**

1. Item a

2. Item b

3. Item c

4. Item d

## Nested List
while creating a multi leavel list make a normal list and for sub items we need to give 2 or 4 indent spaces it depends on the render engine

* item a
	* item1
		* item2
			* item3
* Item b
	* item 1
	* item 2

# Horizontal Rule

We can create a horizontal line using three ways 
* using three or more stars (*)
* using three or more Dashes (_)
* or using three or more hyphens (-)
* ***
* or
 ___
* or
---
# Using links in a document
we need to use a pair of square brackets to refer a link for eg.
1. Google [ google.com]  or   
2. Google ( Google.com) or   
3. [Google](google.com "Google search engine") or  
*[msb]: www.Google.com is "Google Search engine".
4. Google [msb] 
*note:-* this MSB reference methord may or may not work according to the rendering engine ideall the below line should disappear while rendering engine.

5. We can also use angle Brackets for links <Google.com>
6. in order to reprset a hyper link limply use pair of two brackets one sqare brackets and one round crackts \[] () place the text you want the hyper link to work uppon and in round bracket plaace the link [Google.com](Www.google.com)
		
		[Google.com](Www.google.com)

---
# Images in documents.

To link an image in markdown we follow below syntax.Exclamation represents its an image link square brackets shows the text and in round brackets there is actual link then using inverted commas we can give out hover text
			
		![](Link "")

![Google image](https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png "Google PNG")

![This is an image](https://raw.githubusercontent.com/Vibhu2/Pwsh/main/GItNotes.PNG)

# Fenced CodeBlock

We can Define Fenced Code Block by using Back tick character three in a row and in between 2 rows of back tick we can place our code we can also define code language after back ticks and if supported the code will get highlited as well.

```Powershell
Get-Process
Get-service
```

# Tables in Markdown
*Note:-* if colon is just present in right hand side of table te text well be righr alligned if colon is presenton both sides of the line text will be centered and if its on left side the tet will be left alligned.

|Item1 | Item2 | item3|
|:----:|:-----:|:----:|
|green |yellow |red   |

# Checkboxes in Markdown

We use two angle brackets to make a checkbox for eg. it works in Github as tested.

- [ ] Task1
- [X] Task2
___
# Github Markdown Course
## Communicating using Markdown
[Course link](https://lab.github.com/githubtraining/communicating-using-markdown)

- [x] Additional markup is supported, including @mentions, #references, [links](url), **emphasis**, and <del>HTML tags</del>.
- [x] List syntax is required.
  - You can nest lists below, too!
- [x] This item is completed.
- [ ] This item is not complete.
- [ ] invent things
- [x] Do gym

# Cheat Sheet
This cheat sheet provides a quick overview of all the Markdown syntax elements.
It can’t cover every edge case! If you need more information about any of these

## Another markdown language or falvour
*Pandoc

# Applications Supporting markdown
 - Bear app.
 - Standard Notes.
 - Joplin.
 - Obsidian.
 - Ghost
 - Python Notebooks

 # Inter document reference Links
 We can create a index kind a list using below example inside a document.

 1. [Github Markdown Course](#github-markdown-course)

 in above example the importabt parts are Hash simbol \# and normal brecket combination of sqare brackets and round brackets
 > [](#hedding  with hyphens and all in small case)

 **Note:-** We can use HTML inside markdown documents to give it rich formatting for and for the features not implemented yet in markdown

# A collapsible section containing markdown
<details>

  <summary>Click to expand!</summary>
  
  ## Heading

  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>

# A collapsible section containing code
<details>
  <summary>Click to expand!</summary>
  
  ```javascript
    function logSometing(something) {
      console.log(`Logging: ${something}`);
    }
  ```
</details>

# How to structure
```
# A collapsible section with markdown
<details>
  <summary>Click to expand!</summary>
  
  ## Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>
```
**Two important rules:**
1. Make sure you have an **empty line** after the closing `</summary>` tag, otherwise the markdown/code blocks won't show correctly.
2. Make sure you have an **empty line** after the closing `</details>` tag if you have multiple collapsible sections.
