  
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
		object.tween_ = function(object_,vec,lookvec)
            local Time = (object_.Position - vec).magnitude/vec.magnitude * 0.5
			game:GetService('TweenService'):Create(object_,TweenInfo.new(Time, Enum.EasingStyle.Linear),{CFrame = CFrame.new(vec,lookvec)}):Play()
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
