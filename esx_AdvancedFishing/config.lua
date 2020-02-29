Config = {}
	---------------------------------------------------------------
	--=====How long should it take for player to catch a fish=======--
	---------------------------------------------------------------
	--Time in miliseconds
	Config.FishTime = {a = 20000, b = 44000}

	--------------------------------------------------------
	--=====Locations where players can sell stuff========--
	--------------------------------------------------------

	Config.Sell = {
		{
			pos = vec3(-3251.2, 991.5, 11.49), 
			type = "fish",
			sellText = "Fish Dealer",
			blip = 356,
			colour = 17
		},
		{
			pos = vec3(3804.0, 4443.3, 3.0), 
			type = "turtle",
			sellText = "Sea Turtle Dealer",
			blip = 68,
			colour = 49
		},
		{
			pos = vec3(2517.6 , 4218.0, 38.8), 
			type = "shark",
			sellText = "Shark Dealer",
			blip = 68,
			colour = 49
		}
	}

	--------------------------------------------------------
	--=====Locations where players can rent boats========--
	--------------------------------------------------------
Config.MarkerZones = { 
	{
		Marker = vec3(-3426.7,	955.66, 7.35), -- Rental Marker
		Spawn = vec3(-3426.2, 942.4, 1.1), -- Boat Spawn Point
		SpawnHeading = 90.0, -- Boat Heading
		Return = vec3(-3420.2, 996.51, -0.2) -- Boat Return Point
	},
	{
		Marker = vec3(-732.9, -1309.7, 4.0),
		Spawn = vec3(-725.7, -1351.5, 0.5),
		SpawnHeading = 135.0,
		Return = vec3(-712.78, -1338.49, 0.0)
	},  
	{
		Marker = vec3(-281.25,	6632.1, 6.4),
		Spawn = vec3(-330.22, 6660.0, 1.0),
		SpawnHeading = 45.0,
		Return = vec3(-268.4, 6697.04, -0.2)
	},
	{
		Marker = vec3(3855.0, 4463.7, 1.6),
		Spawn = vec3(3885.2, 4507.2, 1.0),
		SpawnHeading = 300.0,
		Return = vec3(3862.1, 4440.4, -0.2)
	},
	{
		Marker = vec3(1330.8, 4226.6, 32.9),
		Spawn = vec3(1343.44, 4190.42, 30.0),
		SpawnSpawnHeading = 200.0,
		Return = vec3(1295.0, 4198.43, 30.0)
	},
}

Config.RentalBoats = {
	-- Fee and Deposit is 50% of the price, you get the deposit returned
	-- Add more boats if you want
	{model = "tug", price = 8750},
}