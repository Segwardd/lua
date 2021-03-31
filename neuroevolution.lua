
local MaxPop = 50
local MutationRate = 0.005

function random_weight()
	return math.random(-1000,1000)/1000
end

local weights_hidden_A = 
	{
		{random_weight(),random_weight(),random_weight(),random_weight()},
		{random_weight(),random_weight(),random_weight(),random_weight()},
		{random_weight(),random_weight(),random_weight(),random_weight()},
		{random_weight(),random_weight(),random_weight(),random_weight()}
	}

local weights_hidden_B = 
	{
		{random_weight(),random_weight(),random_weight(),random_weight()},
		{random_weight(),random_weight(),random_weight(),random_weight()},
		{random_weight(),random_weight(),random_weight(),random_weight()},
		{random_weight(),random_weight(),random_weight(),random_weight()}
	}


local weights_output_A = 
	{
		{random_weight(),random_weight(),random_weight(),random_weight()},
		{random_weight(),random_weight(),random_weight(),random_weight()}
	}

local weights_output_B = 
	{
		{random_weight(),random_weight(),random_weight(),random_weight()},
		{random_weight(),random_weight(),random_weight(),random_weight()}
	}

local parentA = {weights_hidden_A, weights_output_A}
local parentB = {weights_hidden_B, weights_output_B}


function crossover(parentA, parentB)
	
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

function mutation(DNA)
	
	local mutated_DNA = {}
	
	for i,v in pairs(DNA) do 
		
		local weights = {}
		
		for i2,v2 in pairs(v) do
			
			local connections = {}
			
			for i3,v3 in pairs(v2) do
				
				local mutation_attemt = math.random(0,1000)/1000
				
				local connection = v3
				
				if mutation_attemt < MutationRate then
					
					connection = random_weight()
					
				end
				
				table.insert(connections, connection)
				
			end
			
			table.insert(weights, connections)
			
		end
		
		table.insert(mutated_DNA, weights)
		
	end
	
	return mutated_DNA
	
end

function PoolSelectionIndex(population)
	
	local pool = {}
	local sum = 0
	
	for i,v in pairs(population) do
		sum = sum + v
	end
	
	for i,v in pairs(population) do
		
		local percentage_of_agent = v / sum
		
		table.insert(pool, percentage_of_agent)
		
	end
	
	local index = 0
	local random = math.random(0,1000)/1000
	
	while random > 0 do
		index = index + 1
		random = random - pool[index]
	end
	
	return index
	
end

function DNA(parentA, parentB)
	
	local offspring = crossover(parentA, parentB)
	local mutationattemt = mutation(offspring)
	
	return mutationattemt
	
end

function population(parentA, parentB)
	
	local population = {}
	
	for i = 1, MaxPop do
		
		local DNA = DNA(parentA, parentB)
		local agent = Instance.new('Part')
		agent.CFrame = CFrame.new(workspace.Start.Position)
		agent.Parent = workspace
		agent.CanCollide = false
		
		local Bodyvelocity = Instance.new('BodyVelocity', agent)
		Bodyvelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		
		table.insert(population, {agent, DNA})
		
	end
	
	return population
	
end

function dot(array1, array2)
	
	local output = {}
	
	for i,row in pairs(array1) do 
		
		local output2 = 0
		
		for i2 in pairs(row) do
			
			output2 = output2 + row[i2] * array2[i2] 
			
		end
		
		table.insert(output, output2)
		
	end
	
	return output
	
end

function ann(agent)

	local inputs = {
		agent[1].Position.X,
		agent[1].Position.Z,
		workspace.Goal.Position.X,
		workspace.Goal.Position.Z
		
	}
	
	local hidden = dot(agent[2][1], inputs)
	local output = dot(agent[2][2], hidden)
	
	agent[1].BodyVelocity.Velocity = Vector3.new(output[1],0,output[2])
	
	
end

function fitness(population)
	
	local scores = {}
	
	for i,v in pairs(population) do
		
		local magnitude = (v[1].Position - workspace.Goal.Position).magnitude
		
		table.insert(scores, (1 / magnitude * 100))
		
	end
	
	return scores
	
end


local gen = 1

while true do
	
	print(gen)
	
	local population = population(parentA, parentB)
	
	local round = 0

	repeat wait()

		for i,v in pairs(population) do

			ann(v)

		end

		round = round + 1

	until round >= 100
	
	local scores = fitness(population)
	
	indexA = PoolSelectionIndex(scores)
	indexB = PoolSelectionIndex(scores)
	
	parentA = population[indexA][2]
	parentB = population[indexB][2]
	
	for i,v in pairs(population) do
		v[1]:Destroy()
	end
	
	gen = gen + 1
	
	if gen >= 50 then
		workspace.Goal.CFrame = CFrame.new(math.random(-100,100),0.5,math.random(-100,100))
		gen = 1
	end
	
end

