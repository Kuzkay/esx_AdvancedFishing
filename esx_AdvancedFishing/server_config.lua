Server_Config = {}
	-------------------------------------------
	--=====Prices of the items players can sell==========--
	--------------------------------------------------------
	--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
	Server_Config.FishPrice = {a = 125, b = 440} -- Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
	Server_Config.TurtlePrice = {a = 560, b = 810} -- Will get dirty money
	Server_Config.SharkPrice = {a = 2500, b = 5000} -- Will get dirty money

	Server_Config.RentalBoats = {
		-- Fee and Deposit is 50% of the price, you get the deposit returned
		-- Add more boats if you want
		{model = "smallboat", price = 2500},
	}