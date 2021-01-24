

local module = {
    BodyPosition = function(self,Body,Position,Strength)
        local setsimulation = setsimulationradius or set_simulation_radius
        setsimulation(1e308, 1/0)
        object = setmetatable({}, {__index = self})
        self.Status = true
        self.Body = Body
        self.Position = Position
        self.Strength = Strength
        while true do
        if self.Body.Parent:FindFirstChild('Humanoid') then
            self.Body.Parent.Humanoid:ChangeState(11)
        end
        self.Body.CFrame = self.Body.CFrame + (self.Position - self.Body.Position) * self.Strength*0.001
        wait()
        end
        return object
    end
}
return module
