# Azure Training Day 2 Notes

## Linux vs Windows

In Microsoft Windows, files are stored in folders on different data drives like C: D: E:

But, in Linux, files are ordered in a tree structure starting with the root directory.
This root directory can be considered as the start of the file system, and it further branches out various other subdirectories. The root is denoted with a forward slash '/'.

A general tree file system on your UNIX may look like this.
  
![Linux file system Layout](https://www.guru99.com/images/FolderStructure.png "Linux file system Layout")
## Topic: Basic_Linux_commands
```Bash
- whoami
- hostname
- PWD ( Print workig Directory)
- $ represents normal user
- ~ (Tilda)is the home directory of teh logged in user
- ls ( get-childitem)
- CD.. is one directory back or parent directory
- ls or LL - list files 
        > ls -a ( shows hidden files)
        > ls -l ( shows list of files)
- in Linux anyfile name starting with a (.) is hidden file or Directory
- LL -a (Long List) shows hidden files as well
- Man CD ( provides help about the command)
- rm ( Remove File) or ( Directory) we can use -f switch for force deletion
- ls - al
- chown 
- cat < path to the file > reads files in terminal.
[]()

```
### Important points ( using Redhat)

1. **~** is used to depict home directory
2.
3.
## Linux FileSystem

- Everything is a file or a directory ( Windows -File or Folder)
- there are 3 types of users in Linux

    - Super or Admin user --> Root (/Root Directory)
    - Normal or regular or standard User --> Vibhu (/home/vibhu)
    - System or service User --> Based of Software Pakage
    - Child account
    - Guest account

## Shortcuts

* ctrl+L ( Clear the screen).
* Ctrl+C ( Abnormal Termination)
* 
* 
* 

## Creation of File or Directory
* cat :- creates a file, append data,
* cat <Filename.txt> Reads the file.

# Day 3
## File Permissions
 - Read (r)     its value is = 4
 - Write (w)    its value is = 2
 - Execute (x)  its value is = 1

Note:- in order to give permissions we need to add above values
* *CHMOD* is used to give or change permissions
   
    > Chmod 777
* UMASK - is default permissions given to a file or directory
## There are 3 types of users
- Owner (U)
- group (g)
- others (o)

Note- With each user a group is also created