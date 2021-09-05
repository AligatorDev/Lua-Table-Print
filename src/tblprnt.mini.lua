function row(a,b)b=b or{}assert(b==nil or type(b)=="table","Config need be a object or nil")assert(type(a)=="table","Values need be a lua \"array\" ")local c=b.hidehead or false;local d=b.lastrow or false;local e=b.forcewidth or{}local f=b.hidefoot or false;local g="│   "local h="┌"local i=d and"\n└"or"\n├"for j,k in ipairs(a)do k=tostring(k)local l=RealCount(k)local m=e[j]and string.rep(" ",e[j]-l)or""local n=k..m.."   │"..(j==#a and""or"   ")local o=RealCount(n)g=g..n;if not c then h=h..string.rep("─",o-j-(j==#a and-(j-3)or 3-j))..(j==#a and""or"┬")end;if not f then i=i..string.rep("─",o-j-(j==#a and-(j-3)or 3-j))..(j==#a and""or(d and"┴"or"┼"))end end;if not c then h=h.."┐\n"end;i=i..(d and"┘"or"┤")return(not c and h or"")..g:sub(0,#g-6).."│"..(not f and i or"")end;function fmtstr(g)return g end;function have(p,q)for r,k in ipairs(p)do if k==q then return true end end end;function MakeTable(p)local s={{}}for j,k in ipairs(p)do for t,u in pairs(k)do if not have(s[1],t)then table.insert(s[1],t)end end end;table.sort(s[1],function(v,w)return v=="(index)"end)for j,k in ipairs(p)do local x={}for r,y in ipairs(s[1])do table.insert(x,k[y]or"  ")end;table.insert(s,x)end;local z={}for j,k in ipairs(s)do for t,u in ipairs(k)do u=tostring(u)if not z[t]then z[t]=0 end;if z[t]<#u then z[t]=#u end end end;local A={}for B,k in ipairs(s)do table.insert(A,row(k,{forcewidth=z,hidehead=B~=1,hidefoot=B~=#s and B~=1,lastrow=B==#s}))end;return table.concat(A,"\n")end;local C={reset=0,bright=1,dim=2,underline=4,blink=5,reverse=7,hidden=8,black=30,red=31,green=32,yellow=33,blue=34,magenta=35,cyan=36,white=37,blackbg=40,redbg=41,greenbg=42,yellowbg=43,bluebg=44,magentabg=45,cyanbg=46,whitebg=47}function getFakeLength(g)local D=0;local E=0;for B=1,#g do local F=g:byte(B)if F>127 then E=E+1 else E=0 end;if E==4 then D=D+2;E=0 end end;return D end;function RealCount(g)local G=getFakeLength(g)local g,H=string.gsub(g,"\27%[%d+m","")return#g-G end;colors=setmetatable({},{__index=function(x,I)if not C[I]then return end;return function(g)g=tostring(g)g=g:gsub("\27%[%d+m","")return('\27[%dm'):format(C[I])..g..('\27[%dm'):format(0)end end})function snt(J)local K=type(J)if K=="string"then J=print.colors.green("'"..J:gsub("\n","\\n"):gsub("\r","\\r").."'")elseif K=="number"then J=print.colors.yellow(math.floor(J*100)/100)end;return tostring(J)end;function snt2(J)local K=type(J)if K=="string"then J=J:gsub("\n","\\n"):gsub("\r","\\r")elseif K=="number"then J=print.colors.yellow(math.floor(J*100)/100)end;return tostring(J)end;local L={colors=colors,table=function(M,b)b=b or{}assert(type(M)=="table","You must send a table value!")local N=b.onlygen;local O=b.hideindex;local P=b.hidevalue;local Q={}for R,q in pairs(M)do local w={}if type(q)=="table"then for j,k in pairs(q)do if type(j)=="string"then w[snt2(j)]=snt(k)end end end;if not O then w["(index)"]=snt(R)end;if not P then w["value"]=snt(q)end;table.insert(Q,w)end;local c="\n"..MakeTable(Q)b.allcolor=b.allcolor or"green"local S=print.colors[b.allcolor]assert(S,"That color doesn't exists!")local T=S(""):gsub("\27%[0m","")c=T..c:gsub("\27%[0m","\27%[0m"..T).."\27[0m"if not N then print(c)else return c end end}local U=print;print=setmetatable({},{__call=function(r,...)U(...)end,__index=L})
