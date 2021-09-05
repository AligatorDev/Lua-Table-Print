function row(values,config)
    config = config or {}
    assert(config==nil or type(config) == "table","Config need be a object or nil")
    assert(type(values) =="table","Values need be a lua \"array\" ")
    local h= config.hidehead or false
    local last = config.lastrow or false
    local forcewidth = config.forcewidth or {}
    local div = config.hidefoot or false
    
    local str ="│   "
    local head = "┌"
    local foot = last and "\n└" or "\n├"
    for k,v in ipairs(values) do
       v = tostring(v)
       local vl = RealCount(v)
       local st = (( forcewidth[k]) and string.rep(" ",(forcewidth[k]-vl)) or "")
       local ckh = v..st .."   │"..(k==#values and "" or "   ")
       local ckhl=RealCount(ckh)
       str = str ..ckh
       if(not h) then
         head = head..string.rep("─",  ((ckhl-k)-(k==#values and -(k-3) or 3-k)) )..((k==#values) and "" or "┬")
       end
       if(not div) then
       foot = foot..string.rep("─", (ckhl-k)-(k==#values and -(k-3) or 3-k))..((k==#values) and "" or (last and "┴" or "┼"))
       end
    end
    if(not h) then head = head.."┐\n" end
     foot=foot.. (last and "┘" or "┤")
    return (not h and head or "")..str:sub(0,#str-6).."│"..(not div and foot or "")
 end
 function fmtstr(str)
   return str
 end
 function have(tbl,value)
     for _,v in ipairs(tbl) do
         if v == value then
             return true
         end
     end
 end
  
 
 
 
 
 function MakeTable(tbl)
       local c ={{}}
       for k,v in ipairs(tbl) do
           for k2,v2 in pairs(v) do
               if not have(c[1],k2) then
                   table.insert(c[1],k2)
               end
           end 
       end
       table.sort(c[1],function(a,b) 
           return a == "(index)"
       end)
       for k,v in ipairs(tbl) do
           local t = {}   
           for _,name in ipairs(c[1]) do
               table.insert(t,v[name]or"  ")
           end
           table.insert(c,t)
       end
      local forcew = {}
      for k,v in ipairs(c) do
           
           for k2,v2 in ipairs(v) do
               v2 = tostring(v2)
               if not forcew[k2] then forcew[k2]  = 0 end
               if forcew[k2] < #v2 then
                   forcew[k2] = #v2
               end
           end
       end
       local c2 = {}
     for i,v in ipairs(c) do
         
         table.insert(c2,row(v,{
           forcewidth=forcew,
           hidehead = i~=1,
           hidefoot = (i ~= #c and i ~= 1),
           lastrow = (i==#c)
         }))
     end
 
     return table.concat(c2,"\n")
 end
 
 
 
 
 local keys = { -- Some parts of   https://github.com/kikito/ansicolors.lua/blob/master/ansicolors.lua
   reset =      0,
   bright     = 1,
   dim        = 2,
   underline  = 4,
   blink      = 5,
   reverse    = 7,
   hidden     = 8,
   black     = 30,
   red       = 31,
   green     = 32,
   yellow    = 33,
   blue      = 34,
   magenta   = 35,
   cyan      = 36,
   white     = 37,
   blackbg   = 40,
   redbg     = 41,
   greenbg   = 42,
   yellowbg  = 43,
   bluebg    = 44,
   magentabg = 45,
   cyanbg    = 46,
   whitebg   = 47
 }
 function getFakeLength(str)
   local fake = 0
   local sequence = 0
   for i=1,#str do 
      local byte = str:byte(i)
      if byte > 127 then
         sequence = sequence + 1
       else 
         sequence=0
      end     
      if sequence == 4 then
         fake = fake + 2
         sequence=0
      end
   end
   return fake 
 end
 function RealCount(str)
     local offset = (getFakeLength(str))
     
 
 
     local str,d = string.gsub(str,"\27%[%d+m","") 
     return #str - offset
 end
 
 
 
 colors = setmetatable({},{__index=function(t,cor) 
     if not keys[cor] then return end
     return function(str) 
         str = tostring(str)
         str = str:gsub("\27%[%d+m","") 
         return ('\27[%dm'):format(keys[cor])..str..('\27[%dm'):format(0)
     end
 end})
 
 
 function snt(ob) 
     local tipo = type(ob)
     if tipo == "string" then
       ob = print.colors.green("'"..ob:gsub("\n","\\n"):gsub("\r","\\r").."'")
     elseif tipo == "number" then
       ob = print.colors.yellow( math.floor(ob*100)/100)
     end
     return tostring(ob)
 end
 function snt2(ob) -- lol
     local tipo = type(ob)
     if tipo == "string" then
       ob = ob:gsub("\n","\\n"):gsub("\r","\\r")
     elseif tipo == "number" then
       ob = print.colors.yellow( math.floor(ob*100)/100)
     end
     return tostring(ob)
 end
 local inxtbl = {
   colors = colors,
   table = function(tabl,config)
       config = config or {}
       assert(type(tabl) == "table" ,"You must send a table value!")
       local onlygen = config.onlygen
       local hideindex = config.hideindex
       local hidevalue = config.hidevalue
 
 
       local m = {}
       for index,value in pairs(tabl) do
           local b = {}
 
           if type(value) == "table" then
               for k,v in pairs(value) do
                   if type(k) == "string" then
                     b[snt2(k)] = snt(v)
                   end
               end
           end
           if not hideindex then
             b["(index)"] = snt(index)
           end
           if not hidevalue then
             b["value"] = snt(value)
           end
   
           table.insert(m,b)
       end

       local h = "\n"..MakeTable(m)
       config.allcolor = config.allcolor or "green"
       local corf = print.colors[config.allcolor] 
       assert(corf,"That color doesn't exists!")
       local preset = corf(""):gsub("\27%[0m","") 
       h=preset..h:gsub("\27%[0m","\27[0m"..preset).."\27[0m"
       
       if not onlygen then
         print(h)
       else
         return h
       end
   end
 }
 local prtr=print
 print = setmetatable({},{__call=function(_,...)prtr(...)end,__index=inxtbl})
 
 
 
 
 
 


