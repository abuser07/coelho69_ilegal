local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
Drog = Tunnel.getInterface("drogas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local entregando = false
local selecionado = 0
local quantidade = 0

local pontos = {
	{118.83, -1950.47, 20.75}, --BARRAGEM AREA1 CHECADO
	{1317.45, -710.65, 65.34} , -- HELIPA AREA 2 CHECADO
	--{1305.74, -2565.37, 46.4}, -- PETROLIO AREA 3 CHECADO
	{1836.72, -1037.37, 79.23}, --FBI AREA 7 CHECADO
	{-2428.36, 2830.68, 3.969}, --ZANCUDO AREA 6 CHECADO
--	{-3060.41, 1713.22, 36.292},--PRAIA AREA 6 CHECADO
	{-2518.65, 1870.86, 172.02} --FRANÇA AREA 5 CHECADO
}

local locs = {
    [1] = {['x'] = 126.57, ['y'] = -108.18, ['z'] = 60.72},
    [2] = {['x'] = 289.86, ['y'] = 269.2, ['z'] = 105.66},
    [3] = {['x'] = -1125.57, ['y'] = -1061.11, ['z'] = 2.16},
    [4] = {['x'] = -1084.48, ['y'] = -1558.95, ['z'] = 4.78},
    [5] = {['x'] = -690.82, ['y'] = -1155.77, ['z'] = 10.82},
    [6] = {['x'] = 809.23, ['y'] = -163.98, ['z'] = 75.88},
    [7] = {['x'] = 808.51, ['y'] = -163.45, ['z'] = 75.88},
    [8] = {['x'] = 723.95, ['y'] = -697.72, ['z'] = 28.54},
    [9] = {['x'] = 845.14, ['y'] = -903.11, ['z'] = 25.26},
    [10] = {['x'] = 918.47, ['y'] = -648.39, ['z'] = 58.25},
    [11] = {['x'] = 988.07, ['y'] = -433.83, ['z'] = 63.9},
    [12] = {['x'] = 1300.95, ['y'] = -573.78, ['z'] = 71.74},
    [13] = {['x'] = 1381.89, ['y'] = -1544.72, ['z'] = 57.11},
    [14] = {['x'] = 876.35, ['y'] = -2328.27, ['z'] = 30.35},
    [15] = {['x'] = 414.67, ['y'] = -2052.35, ['z'] = 22.21},
    [16] = {['x'] = 345.02, ['y'] = -1849.8, ['z'] = 27.31},
    [17] = {['x'] = 7.08, ['y'] = -1817.0, ['z'] = 25.36},
    [18] = {['x'] = -434.52, ['y'] = -2170.44, ['z'] = 11.34},
    [19] = {['x'] = -434.52, ['y'] = -2170.44, ['z'] = 11.34},
    [20] = {['x'] = -1069.88, ['y'] = -2083.27, ['z'] = 14.38},
    [21] = {['x'] = -1093.02, ['y'] = -1532.83, ['z'] = 4.61},
    [22] = {['x'] = -1308.44, ['y'] = -1227.49, ['z'] = 4.9},
    [23] = {['x'] = -1370.88, ['y'] = -1001.62, ['z'] = 8.31},
    [24] = {['x'] = -1268.11, ['y'] = -812.47, ['z'] = 17.11},
    [25] = {['x'] = -1770.78, ['y'] = -677.02, ['z'] = 10.37},
    [26] = {['x'] = -1995.59, ['y'] = 590.67, ['z'] = 117.91},
    [27] = {['x'] = -1118.48, ['y'] = 762.28, ['z'] = 164.29},
    [28] = {['x'] = -850.75, ['y'] = 522.28, ['z'] = 90.63}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timedistance = 300
		for _,mark in pairs(pontos) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 5 then
				timedistance = 4
				if not entregando then
					if distance <= 1.2 then
						DrawText3D(x,y,z, "~g~E~w~ PARA INICIAR AS ~g~ENTREGAS DE DROGAS")
						if IsControlJustPressed(0,38) then
							entregando = true
							selecionado = math.random(#locs)
							CriandoBlipDroga(locs,selecionado)
							Drog.Quantidade()
						end
					end
				end
			end
		end
		Citizen.Wait(timedistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ STATUS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("quantidade-drogas")
AddEventHandler("quantidade-drogas",function(status)
    quantidade = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timedistance = 300
		if entregando then
			timedistance = 4
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 10.0 then
				DrawMarker(0,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,255,255,100,1,1,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						droga = CreateObject(GetHashKey("prop_weed_block_01"),locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1,true,true,true)
						if Drog.checkPayment() then
						
							local random = math.random(100)
							if random >= 60 then
								Drog.MarcarOcorrencia()
							end
							RemoveBlip(blips)
							backentrega = selecionado
							
							while true do
								if backentrega == selecionado then
									selecionado = math.random(#locs)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlipDroga(locs,selecionado)
							Drog.Quantidade()
						end
					end
				end
			end

			if entregando then
				drawTxt("PRESSIONE ~g~F7 ~w~PARA FINALIZAR A ROTA",4,0.260,0.905,0.5,255,255,255,200)
				drawTxt("VÁ ATÉ O DESTINO ENTREGUE ~g~"..quantidade.."x~w~ DROGAS",4,0.260,0.929,0.5,255,255,255,200)
			  end
			  
			if IsControlJustPressed(0,168) then
				entregando = false
				RemoveBlip(blips)
			end
		end
		Citizen.Wait(timedistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
	local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 50)
end

function CriandoBlipDroga(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,162)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de drogas")
	EndTextCommandSetBlipName(blips)
end



