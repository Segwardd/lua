
local setsimulation = setsimulationradius or set_simulation_radius
setsimulation(1e308, 1/0)
local module = {
    BodyPosition = function(self,Body,Position,Strength)
        object = setmetatable({}, {__index = self})
        self.Status = true
        self.Body = Body
        self.Position = Position
        self.Strength = Strength
        self.Body.CFrame = self.Body.CFrame + (self.Position - self.Body.Position) * self.Strength*0.001
        return object
    end
}
return module
