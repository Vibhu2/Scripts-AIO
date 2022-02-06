# Pwsh
My personal Pwsh website

this is my website first article which will be used as a reference guide for GIT and GitHub

# Some Basic Commands GIT


Git clone https://github.com/Vibhu2/Pwsh.git

**PWD** - Print working directory

**LS/ls** - shot of List tells you what files and folders are in your current directory basically is unix equqavelent of dir or Get-childitem

**CD** - Change Directory to a new defined Directory
    
    - . (One Period): Your Current Directory
    - ..(Two Periods): up one Directory or onr Directory Back
    - ~ (Tilda): this is Home Directory which us C:\Users\%username%


**MKDIR** - Make Directory  


# Some Git Concepts

There are 4 stages in git life cycle  
  1. **Unstaged**: - it means we made changes to local file modefied deleted or added a file.  
  2. **Staged**: - It means we made a local change that we want to commit to save to git.  
    > Git add
  3. **Comitted**:- means we have saved changes to file in Git each commit has a description to help us remember what this change is all about.  
    > Git Commit
  4. **Pushed**:- it means we have pushed the file to remote repository ie git server.  
    > Git Push 

## When you use these stages.
* **Unstaged**.  You’ve made additions and changes that you aren’t sure you want to keep.  
* **Staged**.  You’re pretty sure you want to keep the changes.
* **Committed**.  You definitely want to keep the changes.
* **Pushed**. You want to share the changes with others.

# Git Commands
* git status – Provides useful information
* git add – Moves one or more files from unstaged to staged
* git commit – Commits any staged files (-m) is used to write message to the file.
* git push – Uploads committed files to GitHub
_____
* mv - is git move command and it renames the file as well eg. mv temp.md temporary.md will rename temp to temporary and will delete the original temp file  

* use (Q) to exit out of the command when terminal stucks
* git log --oneline this command displays summary of all the commits

## Reverting files in Git to a previous version

* use git log --oneline to get the details of the file snapshots. copy the unique id from the list the latest one is at the top. 
![image file](https://raw.githubusercontent.com/Vibhu2/Pwsh/main/GItNotes.PNG) 

    >  git checkout -b 60e275b
 
---
# What are Tags in Git hub

- Sometimes you want to label a commit as special
  - This is called a tag
- For example: you could tag a commit that corresponds to the files that are part of a release
 - A tag is just a label applied to a commit to make it easier to find
- Tags have a name and a description
- Tags are applied locally. Use git push to upload it to GitHub

# Most commonly used Git command's

- **git init** - this is to inetialise the repository
- **git clone** - this is to clone an online repository
- **git remote** - 
- **git status** - to check if there are any unsaved changes in current folder if if changes needs to be added or committed or pushed to remote repository. if we use 

> **git status** -s  


  this will show all the files that have been changed.

- **git commit**  - is to save changes to local repo with some meaningfull comment
- **git checkout** -b is used to create a branch 
- **git merge**
- **git diff** - tells you the difference in the file from last commit to current eddition.
- **git whatchange** - to find out what exctly has changes in the repo.
- **git remote**
- **git add remote**- is to add a remote repository to which you can sync local code.
- **git log**
- **git revert** < enter the Hash of the commit you want to revert to>
**git reset** --soft to revert changes 
**git reset** <Name of the file> is used to unstage the file.
- **git Merge**
- **git rebase**
- **git Checkout**
- **git fetch**
___

# Git Conflicts


_______________


* git hub
* git lab
* bit bucket