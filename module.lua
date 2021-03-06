local module = {}
setmetatable(module,{
	__index = function(__table,index)
		local object = setmetatable({},{__index = self,
            __add = function(self, value)
                if type(value) == 'table' then
                    for i,v in pairs(value) do
                        table.insert(self, v)
                    end
                else
                    if not table.find(self,value) then
                        table.insert(self, value)
                    end
                end
		        return self
			end,
			__sub = function(self, value)
				local table_find = table.find(self, value)
				if table_find then
					table.remove(self, table_find)
					return self
				end
			end
        })
        object.index = 1
		object.add = function(self,_table)
			for i,v in ipairs(_table) do
				self[#object+1] = v
			end
		end
		object.rem = function(self,_table)
		   for i,v in pairs(_table) do
		      if table.find(self,v) then
		          table.remove(self, table.find(self,v))
		      end
		   end
        end
        object.ganp = function(Parent) -- ganp being game alive non players (returns all living instances within a table)
            local Return = {}
            for i,v in pairs(Parent) do
                if v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 then
                    if game.Players:FindFirstChild(v.Name) then
                    else
                        table.insert(Return,v)
                    end
                end
            end
            return Return
        end
        object.sortclass = function(table,class)
            local x = {}
            for i,v in pairs(table) do
                if type(v) == class then
                    x[#x+1] = v
                end
            end
            return x
        end
    object.sortname = function(table,name_table)
        local x = {}
		for i,v in pairs(name_table) do 
			for i2,v2 in pairs(table) do
				if string.lower(v2.Name):find(string.lower(v)) then
					x[#x+1] = v2
				end
			end 
        end
        return x
	end
	object.sortchild = function(table,child)
	    local x = {}
		for i,v in pairs(table) do
			if v:FindFirstChild(child) then
				x[#x+1] = v
			end
        end
        return x
	end
        object.tirc = function(condition, aftermath) -- tirc standing for table index return condition (returns the index of the table, with a condition to pass index up)
            if condition then
                local returning = object[object.index]
                if object.index >= #object then
                    object.index = 1
                end
                if aftermath ~= nil then
                    if aftermath == 'remove' then
                        table.remove(object,object.index)
                        return object[object.index]
                    end
                else
                object.index = object.index + 1
                end
            end
            return object[object.index]
        end
		return object
	end
})
return module
