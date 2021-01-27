local module = {}

setmetatable(module,{
	__index = function(__table,index)
		local object = setmetatable({},{__index = self,
		    __add = function(self, value)
		        table.insert(self, value)
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
		return object
	end
})

return module
