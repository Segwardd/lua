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
                table.insert(self, value)
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
                if v:FindFirstChild('Humanoid') then
                    if game.Players:FindFirstChild(v.Name) then
                    else
                        table.insert(Return,v)
                    end
                end
            end
            return Return
        end
        object.sortclass = function(table,class)
            local Return = {}
            for i,v in pairs(table) do
                if type(v) == class then
                        table.insert(Return,v)
                end
            end
            return Return
        end
	object.sortname = function(table,name)
		local Return = {}
		for i,v in pairs(table) do
			if v.Name == name then
				table.insert(Return,v)
			end
		end
		return Return
	end
	object.sortchild = function(table,child)
		local Return = {}
		for i,v in pairs(table) do
			if v:FindFirstChild(child) then
				table.insert(Return,v)
			end
		end
		return Return
	end
        object.tirc = function(condition) -- tirc standing for table index return condition (returns the index of the table, with a condition to pass index up)
            if condition then
                local returning = object[object.index]
                if object.index >= #object then
                    return false
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
