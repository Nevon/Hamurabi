City = Class{name="City", function(self, ...)
	self.year = arg[1] or 0
	self.population = arg[2] or 95
	self.starved = arg[3] or 0
	self.migrated = arg[4] or 5
	self.bushels = arg[5] or 2800
	self.acres = arg[6] or 1000
	self.yield = arg[7] or 3
	self.pests = arg[8] or 300
	self.tradeValue = arg[9] or 17+math.random(10)
	self.averageStarved = arg[10] or 0
	self.totalDied = arg[11] or 0
	self.fed = arg[12] or 0
	self.planted = arg[13] or 0
end}

function City:passYear()
	local messages = {}
	self.year = self.year+1
	
end
