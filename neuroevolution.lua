local NeuralNetwork = {}

function NeuralNetwork.Random(range)
    return math.random(-range, range)/1000
end

function NeuralNetwork.Sigmoid(x)
    return 1 / (1 + math.exp(-x))
end

function NeuralNetwork.KE(mass, speed)
    return (1/2*mass) * math.pow(speed,2)
end

function NeuralNetwork.Dot(A, B)
    local out1 = {}
	for i,row in pairs(A) do 
		local out2 = 0
		for i2 in pairs(row) do
			out2 = out2 + row[i2] * B[i2] 
		end
		table.insert(out1, out2)
	end
	return out1
end

function NeuralNetwork.Crossover(parentA, parentB)
	local offspring = {}
	for i,v in pairs(parentA) do
		local weights = {}
		for i2,v2 in pairs(v) do
			local connections = {}
			local Crossover_Point = math.random(1,#v2)
			for i3,v3 in pairs(v2) do
				if i3 < Crossover_Point then
					table.insert(connections, parentA[i][i2][i3])
				else
					table.insert(connections, parentB[i][i2][i3])
				end
			end
			table.insert(weights, connections)
		end
		table.insert(offspring, weights)
	end
	return offspring
end

function NeuralNetwork.Mutation(Weights, Rate)
	local Genes = {}
	for i,v in pairs(Weights) do
		local Gene = {}
		for i2,v2 in pairs(v) do
			if math.random(0,1000)/1000 < Rate then
				table.insert(Gene, NeuralNetwork.random(2000))
			else
				table.insert(Gene, v2)
			end
		end
		table.insert(Genes, Gene)
	end
	return Genes
end

function NeuralNetwork.NeuralNetwork(IN, HN, ON)
	local HW = {}
	local OW = {}
	for i = 1, HN do
		local N = {}
		for i2 = 1, IN do
			table.insert(N, NeuralNetwork.random(1000))
		end
		table.insert(HW,N)
	end
	for i = 1, ON do
		local N = {}
		for i2 = 1, HN do
			table.insert(N, NeuralNetwork.random(1000))
		end
		table.insert(OW,N)
	end
	return {HW, OW}
end

function NeuralNetwork.ANN(A, B)
	return NeuralNetwork.Dot(B, A)
end

function NeuralNetwork.InputOutput(A, B)
    local layer = NeuralNetwork.ANN(A, B[1])
    for i,v in pairs(B) do
        if i ~= 1 then
            layer = NeuralNetwork.ANN(layer, v)
        end
    end
    return layer
end

return NeuralNetwork
