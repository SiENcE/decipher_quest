-- get table length
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- check if point is in rect bound
function rectbound(x,y, x1,y1, x2,y2)
  local inbound = false
  if x >= x1 and x <= x1+x2 and y >= y1 and y <= y1+y2 then
	inbound = true
  end
  return inbound
end

--function isCollidingWith(obj,obj2)
function isCollidingWith(box1,box2)
	local obj1 = { x=box1.x+15, y=box1.y-15, width=box1.width-15, height=box1.height-15}
	local obj2 = { x=box2.x+15, y=box2.y-15, width=box2.width-15, height=box2.height-15}
	
	local ox, oy=obj1.x-obj2.x, obj1.y-obj2.y -- let's pretent Cursor is at (0,0)
	if ox+obj1.width<0 or oy+obj1.height<0 or
		ox>obj2.width or oy>obj2.height then
		return false
	else
		return true
	end
end

function shuffleTable( t )
    local rand = math.random 
    assert( t, "shuffleTable() expected a table, got nil" )
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

-- Converts HSL to RGB. (input and output range: 0 - 255)
-- sample: love.graphics.setColor(HSL(150,100,200))
function HSL(h, s, l, a)
    if s<=0 then return l,l,l,a end
    h, s, l = h/256*6, s/255, l/255
    local c = (1-math.abs(2*l-1))*s
    local x = (1-math.abs(h%2-1))*c
    local m,r,g,b = (l-.5*c), 0,0,0
    if h < 1     then r,g,b = c,x,0
    elseif h < 2 then r,g,b = x,c,0
    elseif h < 3 then r,g,b = 0,c,x
    elseif h < 4 then r,g,b = 0,x,c
    elseif h < 5 then r,g,b = x,0,c
    else              r,g,b = c,0,x
    end return (r+m)*255,(g+m)*255,(b+m)*255,a
end

function HSV(h, s, v)
    if s <= 0 then return v,v,v end
    h, s, v = h/256*6, s/255, v/255
    local c = v*s
    local x = (1-math.abs((h%2)-1))*c
    local m,r,g,b = (v-c), 0,0,0
    if h < 1     then r,g,b = c,x,0
    elseif h < 2 then r,g,b = x,c,0
    elseif h < 3 then r,g,b = 0,c,x
    elseif h < 4 then r,g,b = 0,x,c
    elseif h < 5 then r,g,b = x,0,c
    else              r,g,b = c,0,x
    end return (r+m)*255,(g+m)*255,(b+m)*255
end

-- As a more advanced solution, we can write an iterator that traverses a table following the order of its keys.
-- An optional parameter f allows the specification of an alternative order. It first sorts the keys into an array,
-- and then iterates on the array. At each step, it returns the key and value from the original table:
function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end
