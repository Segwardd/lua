print('module extention made by segward, Segward#7539')
local module = {
    objects = function(self)
        metatable = setmetatable({}, {__index = self})
        self.table = {}
        self.add = function(arg1)
            table.insert(self.table,arg1)
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
            print(unpack(self.table))
        end
        return metatable
    end
}
return module
