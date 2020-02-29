ESX = nil
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if ESX ~= nil then
		else
			ESX = nil
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	end
end)

local Keys = {
	["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["E"] = 38, ["X"] = 73
}

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local veh = nil
local bait = "none"
local SellWait = false

for _, v in ipairs(Config.Sell) do
	local blip = AddBlipForCoord(v.pos)
	SetBlipSprite (blip, v.blip)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, v.colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(v.sellText)
	EndTextCommandSetBlipName(blip)
end
			
for _, info in pairs(Config.MarkerZones) do
	info.blip = AddBlipForCoord(info.Marker)
	SetBlipSprite(info.blip, 455)
	SetBlipDisplay(info.blip, 4)
	SetBlipScale(info.blip, 0.8)
	SetBlipColour(info.blip, 20)
	SetBlipAsShortRange(info.blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Boat rental")
	EndTextCommandSetBlipName(info.blip)
end
	
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		-- Rental Markers
		for k, v in pairs(Config.MarkerZones) do
			if #(pedCoords - v.Marker) < 100.0 then
				DrawMarker(1, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 255, 255, 0, 100, 0, 0, 0, 0)	
			end
			if #(pedCoords - v.Return) < 100.0 and IsPedInAnyVehicle(ped) then
				DrawMarker(1, v.Return, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if #(pedCoords - v.Return) < 5.0 then
					if DoesEntityExist(veh) and GetVehiclePedIsIn(ped) == veh then
						DisplayHelpText('Press ~INPUT_CONTEXT~ to return the boat')
						if IsControlJustReleased(0, Keys['E']) then
							for _, q in pairs(Config.RentalBoats) do
								if GetEntityModel(veh) == GetHashKey(q.model) then
									local deposit = math.floor(q.price / 2)
									TriggerServerEvent('fishing:returnDeposit', GetHashKey(q.model))
									ESX.ShowNotification("You have been returned your deposit of ~g~$" .. deposit)
								end
							end
							SetEntityAsMissionEntity(veh)
							DeleteEntity(veh)
							TriggerServerEvent("deleteThisEntity", NetworkGetNetworkIdFromEntity(veh))
							SetEntityCoords(ped, v.Marker)
						end
					else
						DisplayHelpText('This is not a rented vehicle')
					end
				end
			end
		end

		-- Sell markers
		for k, v in ipairs(Config.Sell) do
			if #(pedCoords - v.pos) < 100.0 then
				DrawMarker(1, v.pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
			end
			if #(pedCoords - v.pos) < 3.0 and not SellWait then
				DrawMarker(1, v.pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
				TriggerServerEvent('fishing:startSelling', v.type)
				SellWait = true
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if SellWait then
			Citizen.Wait(4000)
			SellWait = false
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
		Wait(1200)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if fishing then
			for i = 1, 8 do
				if IsControlJustReleased(0, Keys[tostring(i)]) then
					input = i
			   	end
			end

			-- Stops the player from cancelling the task by getting out a weapon
			if IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING") then
				BlockWeaponWheelThisFrame()
			end
			
			if IsControlJustReleased(0, Keys['X']) then
				fishing = false
				ESX.ShowNotification("~r~Stopped fishing")
				TriggerEvent("fishing:break")
			end

			if fishing then
				playerPed = PlayerPedId()
				local pos = GetEntityCoords(playerPed)
				if pos.y >= 7700.0 or pos.y <= -4000.0 or pos.x <= -3700.0 or pos.x >= 4300.0 or IsPedInAnyVehicle(playerPed) then
					-- Nothing
				else
					fishing = false
					ESX.ShowNotification("~r~Stopped fishing")
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					ESX.ShowNotification("~r~Stopped fishing")
				end
			end
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('fishing:catch', bait)
				else
					ESX.ShowNotification("~r~Fish got free")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
		Citizen.Wait(wait)
		if fishing then
			pause = true
			correct = math.random(1,8)
			ESX.ShowNotification("Fish is taking the bait\nPress ~y~" .. correct .. "~s~ to catch it")
			input = 0
			pausetimer = 0
		end	
	end
end)

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()
	RequestTheModel("A_C_SharkTiger")
	local pos = GetEntityCoords(PlayerPedId())
	local ped = CreatePed(29, `A_C_SharkTiger`, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
	DecorSetInt(ped, "propHack", 74)
	SetModelAsNoLongerNeeded(`A_C_SharkTiger`)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	playerPed = PlayerPedId()
	local pos = GetEntityCoords(PlayerPedId())
	if IsPedInAnyVehicle(playerPed) then
		ESX.ShowNotification("~r~You can not fish from a vehicle")
	else
		if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 then
			ESX.ShowNotification("Fishing started\nPress ~y~X~s~ to stop fishing")
			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
			print("fishing has started")
		else
			ESX.ShowNotification("You need to go further away from the shore")
		end
	end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(Config.MarkerZones) do
        	local ped = PlayerPedId()
			local pedc = GetEntityCoords(ped, false)
            local distance = #(pedc - v.Marker)
            if distance <= 1.40 then
				DisplayHelpText('Press ~INPUT_CONTEXT~ to rent a boat')
				
				if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
					OpenBoatsMenu(v.Spawn, v.SpawnHeading)
				end 
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
        end
    end
end)

function OpenBoatsMenu(xyz, h)
	local ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	local elements = {}

	for k, v in ipairs(Config.RentalBoats) do
		table.insert(elements, {
			label = ('%s - ~HUD_COLOUR_RED~$%s~s~'):format(GetLabelText(GetDisplayNameFromVehicleModel(v.model)), ESX.Math.GroupDigits(v.price)),
			value = v.model
		})
	end
	
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = 'Rent a boat',
		align    = 'bottom-right',
		elements = elements,
    },
	
	function(data, menu)

	for k, v in ipairs(Config.RentalBoats) do
		if data.current.value == v.model then
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent("fishing:lowmoney", GetHashKey(v.model))
			RequestTheModel(v.model)
			veh = CreateVehicle(v.model, xyz, h, true, false)
			SetPedIntoVehicle(ped, veh, -1)
			TriggerEvent("ls:newVehicle", GetVehicleNumberPlateText(veh), veh, 0)
			DecorSetInt(veh, "ControlCar", 1)
			local deposit = math.floor(v.price / 2)
			ESX.ShowNotification("You have paid a ~r~$" .. deposit .. "~s~ rental fee and a ~r~$" .. deposit .. "~s~ deposit.")
			ESX.ShowNotification("Return the ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(v.model)) .. "~s~ to get your ~r~deposit~s~ back")
            SetModelAsNoLongerNeeded(v.model)
		end
	end
	
	ESX.UI.Menu.CloseAll()

    end,
	function(data, menu)
		menu.close()
		end
	)
end

function RequestTheModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end