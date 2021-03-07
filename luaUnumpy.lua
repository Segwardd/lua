local numpy = {}

metatable = {
    __sub = function(array, value)
        output = {}
        for i = 1, #array do
            output[i] = array[i] - value
        end
        return output
    end,
    __add = function (array, value)
        output = {}
        for i = 1, #array do
            output[i] = array[i] + value
        end
        return output
    end
}

function numpy.array(list)
    return setmetatable(list, metatable)
end

function numpy.dot(array1, array2)
    out = {}
    for i,row in pairs(array1) do 
        out_ = 0
        for i2 in pairs(row) do
            out_ = out_ + row[i2] * array2[i2] 
        end
        table.insert(out, out_)
    end
    return out
end

return numpy
