
local module = {
    objects = function(self)
        metatable = setmetatable({}, {__index = self})
        self.table = {}
        self.index = 1
        self.index_object = nil
        self.add = function(arg1)
            table.insert(self.table,arg1)
            self.index_object = self.table[self.index]
        end
        self.rem = function(arg1)
            for i,v in pairs(self.table) do
                if type(v) == 'table' and type(arg1) == 'table' then
                    local checker = {}
                    for i in pairs(v) do
                        if v[i] == arg1[i] then
                            table.insert(checker,'true')
                        else
                            table.insert(checker,'false')
                        end
                    end
                    if table.find(checker,'false') then
                        warn('error matching up')
                    else
                        table.remove(self.table,table.find(self.table,v))
                    end 
                else
                    local x = table.find(self.table,arg1)
                     if x then
                        table.remove(self.table)
                    end 
                end
            end
        end
        self.listen = function()
            non_table = {}
            for i,v in pairs(self.table) do
                if type(v) == 'table' then
                    print('table',unpack(v))
                else
                    table.insert(non_table,v)
                end 
             end
             print(unpack(non_table))
        end
        self.loop_condition = function(condition,aftermath)
            function aftermath_()
                if aftermath == 'Next' then
                    self.index = self.index + 1
                    self.index_object = self.table[self.index]
                end
            end
            if condition[2] then 
                if condition[2] == 'Equals' then
                    if condition[1] == condition[3] then
                        aftermath_()
                    end
                elseif condition[2] == 'Under' then
                    if condition[1] <= condition[3] then
                        aftermath_()
                    end
                elseif condition[2] == 'Above' then
                    if condition[1] >= condition[3] then
                        aftermath_()
                    end
                elseif condition[2] == 'Unequals' then
                    if condition[1] ~= condition[3] then
                        aftermath_()
                    end
                end
            end
        end
        return metatable
    end
}
return module
