ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('turtlebait', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "turtle")
		xPlayer.removeInventoryItem('turtlebait', 1)
		TriggerClientEvent('fishing:message', _source, "You attach the ~y~turtle bait~s~ onto your fishing rod")
	else
		TriggerClientEvent('fishing:message', _source, "~r~You don't have a fishing rod")
	end
end)

ESX.RegisterUsableItem('fishbait', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "fish")
		xPlayer.removeInventoryItem('fishbait', 1)
		TriggerClientEvent('fishing:message', _source, "You attach the ~y~fish bait~s~ onto your fishing rod")
	else
		TriggerClientEvent('fishing:message', _source, "~r~You don't have a fishing rod")
	end
end)

ESX.RegisterUsableItem('turtle', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "shark")
		xPlayer.removeInventoryItem('turtle', 1)
		TriggerClientEvent('fishing:message', _source, "You attach the ~y~turtle meat~s~ onto the fishing rod")
	else
		TriggerClientEvent('fishing:message', _source, "~r~You don't have a fishing rod")
	end
end)

ESX.RegisterUsableItem('fishingrod', function(source)
	local _source = source
	TriggerClientEvent('fishing:fishstart', _source)
end)
				
RegisterNetEvent('fishing:catch')
AddEventHandler('fishing:catch', function(bait)
	local _source = source
	local weight = 2
	local rnd = math.random(1,100)
	local xPlayer = ESX.GetPlayerFromId(_source)
	if bait == "turtle" then
		if rnd >= 78 then
			if rnd >= 94 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('fishing:message', _source, "It was huge and it broke your ~y~fishing rod!")
				TriggerClientEvent('fishing:break', _source)
				xPlayer.removeInventoryItem('fishingrod', 1)
			else
				TriggerClientEvent('fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('turtle').count > 4 then
					TriggerClientEvent('fishing:message', _source, "~r~You cant hold more turtles")
				else
					TriggerClientEvent('fishing:message', _source, "You caught a ~y~turtle~s~\nThese are endangered species and are ~r~illegal~s~ to possess")
					xPlayer.addInventoryItem('turtle', 1)
				end
			end
		else
			if rnd >= 75 then
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
				else
					weight = math.random(4,9)
					TriggerClientEvent('fishing:message', _source, "You caught a ~y~fish~s~: ~g~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
				else
					weight = math.random(2,6)
					TriggerClientEvent('fishing:message', _source, "You caught a ~y~fish~s~: ~g~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
	else
		if bait == "fish" then
			if rnd >= 75 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
				else
					weight = math.random(4,11)
					TriggerClientEvent('fishing:message', _source, "You caught a ~y~fish~s~: ~g~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
				else
					weight = math.random(1,6)
					TriggerClientEvent('fishing:message', _source, "You caught a ~y~fish~s~: ~g~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
		if bait == "none" then
			if rnd >= 70 then
			TriggerClientEvent('fishing:message', _source, "You are currently fishing without any equipped bait")
			if  xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
				else
					weight = math.random(2,4)
					TriggerClientEvent('fishing:message', _source, "You caught a ~y~fish~s~: ~g~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			else
			TriggerClientEvent('fishing:message', _source, "You are currently fishing without any equipped bait")
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
				else
					weight = math.random(1,2)
					TriggerClientEvent('fishing:message', _source, "You caught a ~y~fish~s~: ~g~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
		if bait == "shark" then
			if rnd >= 82 then
				if rnd >= 91 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('fishing:message', _source, "~r~It was huge and it broke your fishing rod!")
					TriggerClientEvent('fishing:break', _source)
					xPlayer.removeInventoryItem('fishingrod', 1)
				else
					if xPlayer.getInventoryItem('shark').count > 0  then
						TriggerClientEvent('fishing:setbait', _source, "none")
						TriggerClientEvent('fishing:message', _source, "~r~You cant hold more sharks")
					else
						TriggerClientEvent('fishing:message', _source, "You caught a ~y~shark!~s~\nThese are endangered species and are ~r~illegal~s~ to possess")
						TriggerClientEvent('fishing:spawnPed', _source)
						xPlayer.addInventoryItem('shark', 1)
					end
				end	
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
				else
					weight = math.random(4,8)
					TriggerClientEvent('fishing:message', _source, "You caught a ~y~fish: ~g~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
	end
end)

RegisterServerEvent("fishing:lowmoney")
AddEventHandler("fishing:lowmoney", function(model)
    local _source = source	
	local myModel = model
	local xPlayer = ESX.GetPlayerFromId(_source)
	for k, v in ipairs(Server_Config.RentalBoats) do
		if GetHashKey(v.model) == myModel then
			xPlayer.removeMoney(v.price)
		end
	end
end)

RegisterServerEvent("fishing:returnDeposit")
AddEventHandler("fishing:returnDeposit", function(model)
	local _source = source
	local myModel = model
	local xPlayer = ESX.GetPlayerFromId(_source)
	for k, v in ipairs(Server_Config.RentalBoats) do
		if GetHashKey(v.model) == myModel then
			xPlayer.addMoney(v.price / 2)
		end
	end
end)

RegisterServerEvent('fishing:startSelling')
AddEventHandler('fishing:startSelling', function(yaItem)
	local _source = source
	local item = yaItem
	local xPlayer  = ESX.GetPlayerFromId(_source)
	if item == "fish" then
		local FishQuantity = xPlayer.getInventoryItem('fish').count
			if FishQuantity <= 4 then
			TriggerClientEvent('esx:showNotification', source, 'You dont have enough~y~ fish')			
		else   
			xPlayer.removeInventoryItem('fish', 5)
			local payment = Server_Config.FishPrice.a
			payment = math.random(Server_Config.FishPrice.a, Server_Config.FishPrice.b) 
			xPlayer.addMoney(payment)		
		end	
	end
	if item == "turtle" then
		local FishQuantity = xPlayer.getInventoryItem('turtle').count
		if FishQuantity <= 0 then
			TriggerClientEvent('esx:showNotification', source, 'You dont have enough~y~ turtles')			
		else   
			xPlayer.removeInventoryItem('turtle', 1)
			local payment = Server_Config.TurtlePrice.a
			payment = math.random(Server_Config.TurtlePrice.a, Server_Config.TurtlePrice.b) 
			xPlayer.addAccountMoney('black_money', payment)
		end
	end
	if item == "shark" then
		local FishQuantity = xPlayer.getInventoryItem('shark').count
		if FishQuantity <= 0 then
			TriggerClientEvent('esx:showNotification', source, 'You dont have enough~y~ sharks')			
		else   
			xPlayer.removeInventoryItem('shark', 1)
			local payment = Server_Config.SharkPrice.a
			payment = math.random(Server_Config.SharkPrice.a, Server_Config.SharkPrice.b)
			xPlayer.addAccountMoney('black_money', payment)
		end
	end
end)