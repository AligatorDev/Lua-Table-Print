# Lua-Table-Print
Beautiful table print for lua
Tested on lua 5.1.5 on replit! it need support ansicolors!
Developed by aligoxtoso#8179

Its like console.table on js!
All the tables are embed on print!
Support Emojis!
Suppress line breaks!
```lua
print.colors[COLOR]
print.table
```

Colors    |
----------|
reset     |
bright    |
dim       |
underline |
blink     |
reverse   |
hidden    |
black     |
red       |
green     |
yellow    |
blue      |
magenta   |
cyan      |
white     |
blackbg   |
redbg     |
greenbg   |
yellowbg  |
bluebg    |
magentabg |
cyanbg    |
whitebg   |


All colors with sufix bg its to background of console!

Recommend Syntax:
```lua
local color = print.colors
print(color.red("Hello ")..color.underline("World ")..color.bright("I'm bright")..color.redbg(" Ugly"))
```
![image](https://user-images.githubusercontent.com/28674704/132116076-01382934-ef81-4898-9052-3cc442d74cd7.png)

Tables!

Simple use
```lua
print.table({
  "Hello World",
  50,
  "\nHELLO\n",
  {
    AnyKey = "I have it"  
  },
  {
    Exclusive = "Only me have that! LOSER"  
  },
})
```
 ![image](https://user-images.githubusercontent.com/28674704/132116318-48ce1f62-19a6-4ef8-ba52-c714ac724ce4.png)

If you dont like the color or want remove some colums like value or index i have a solution to you!
```lua
print.table({
  "Hello World",
  50,
  "\nHELLO\n",
  {
    AnyKey = "I have it"  
  },
  {
    Exclusive = "Only me have that! LOSER"  
  },
},{
  hideindex = true,
  hidevalue = false, -- you dont need specify if its false!!!
  allcolor = "red",
})
```

![image](https://user-images.githubusercontent.com/28674704/132116382-9d6aa204-d7ce-4f02-b1f3-279c23cb6dc7.png)

And that is it!

