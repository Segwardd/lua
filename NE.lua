local NE = {}

function NE.random(range)
	return math.random(-range, range)/1000
end

function NE.SigmoidAll(output)
	local new = {}
	for i,v in pairs(output) do
		table.insert(new, 1 / (1 + math.exp(-v)))
	end
	return new
end

function NE.Dot(array1, array2)
	local x = {}
	for i,row in pairs(array1) do 
		local x2 = 0
		for i2 in pairs(row) do
			x2 = x2 + row[i2] * array2[i2] 
		end
		table.insert(x, x2)
	end
	return x
end

function NE.crossover(parentA, parentB)
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

function NE.Mutation(Weights, Rate)
	local Genes = {}
	for i,v in pairs(Weights) do
		local Gene = {}
		for i2,v2 in pairs(v) do
			if math.random(0,1000)/1000 < Rate then
				table.insert(Gene, NE.random(2000))
			else
				table.insert(Gene, v2)
			end
		end
		table.insert(Genes, Gene)
	end
	return Genes
end

function NE.NeuralNetwork(IN, HN, ON)
	local HW = {}
	local OW = {}
	for i = 1, HN do
		local N = {}
		for i2 = 1, IN do
			table.insert(N, NE.random(1000))
		end
		table.insert(HW,N)
	end
	for i = 1, ON do
		local N = {}
		for i2 = 1, HN do
			table.insert(N, NE.random(1000))
		end
		table.insert(OW,N)
	end
	return {HW, OW}
end

function NE.ANN(A, B)
	return NE.Dot(B, A)
end

return NE
