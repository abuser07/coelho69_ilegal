local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Drog = {}
Tunnel.bindInterface("coelho69_ilegal",Drog)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookvendadrogas = "https://discord.com/api/webhooks/1166111514881695754/FB_KsOl7W3WZia84QnJRrVNg0V3_QXzMVpHtTb57qMsY0YtXqBgp714QAJZwjWscJzWs"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pagamento = {}
local total = 0

local quantidade = {}

function Drog.Quantidade()
	local source = source

	if quantidade[source] == nil then
	   quantidade[source] = math.random(1,3)	
	end

	TriggerClientEvent("quantidade-drogas",source,parseInt(quantidade[source]))
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function Drog.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if user_id then
		if vRP.getInventoryItemAmount(user_id, 'AMMO_ASSAULTRIFLE_MK2') <= 0 and vRP.getInventoryItemAmount(user_id, 'AMMO_SPECIALCARBINE_MK2') <= 0 and vRP.getInventoryItemAmount(user_id, 'AMMO_MACHINEPISTOL') <= 0 and vRP.getInventoryItemAmount(user_id, 'AMMO_ASSAULTSMG')  <= 0 and vRP.getInventoryItemAmount(user_id, 'AMMO_COMBATPISTOL')  <= 0 and vRP.getInventoryItemAmount(user_id, 'AMMO_PISTOL_MK2') <= 0 then
			TriggerClientEvent("Notify",source,"negado","Número insuficiente de Muni.")
		else
			local policia = vRP.getUsersByPermission("policia.permissao")
			local valorDroga = math.random(700,1500) 
				if #policia < 2 then 
					valorDroga = math.random(1450,1220) 
				elseif #policia >= 2 then
					valorDroga = math.random(1620,1730) 
				elseif #policia >= 4 then
					valorDroga = math.random(1730,1850) 
				elseif #policia >= 6 then
					valorDroga = math.random(1850,1950)
				elseif #policia >= 8 then
					valorDroga = math.random(1950,2500)
				end 

			local totalPagamento = 0
			if vRP.getInventoryItemAmount(user_id, 'AMMO_ASSAULTRIFLE_MK2') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"AMMO_ASSAULTRIFLE_MK2",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total * 1.50
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end
			if vRP.getInventoryItemAmount(user_id, 'AMMO_SPECIALCARBINE_MK2') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"AMMO_SPECIALCARBINE_MK2",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total * 1.50
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end
			
			if vRP.getInventoryItemAmount(user_id, 'AMMO_MACHINEPISTOL') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"AMMO_MACHINEPISTOL",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total * 1.25
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end

			if vRP.getInventoryItemAmount(user_id, 'AMMO_ASSAULTSMG') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"AMMO_ASSAULTSMG",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total * 1.25
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end

			if vRP.getInventoryItemAmount(user_id, 'AMMO_COMBATPISTOL') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"AMMO_COMBATPISTOL",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end

			if vRP.getInventoryItemAmount(user_id, 'AMMO_PISTOL_MK2') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"AMMO_PISTOL_MK2",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end
	
			if totalPagamento > 0 then
				vRP.giveInventoryItem(user_id, "dinheiro-sujo", totalPagamento)
				quantidade[source] = math.random(4,7)
				TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..totalPagamento.."dinheiro-sujo.")
						PerformHttpRequest(webhookvendamunicao, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 
									title = "REGISTRO - municao:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
									thumbnail = {
									url = "https://i..com/q99CLfp.png"
									}, 
									fields = {
										{ 
											name = "**Registro do usuário:**", 
											value = "` "..identity.name.." "..identity.firstname.." ` "
										},
										{ 
											name = "**Nº do ID:**", 
											value = "` "..user_id.." ` "
										},
										{ 
											name = "**Vendeu:**", 
											value = "` "..quantidade[source].." municao ` "
										},
										{ 
											name = "**Ganhou:**", 
											value = "` "..totalPagamento.." Dinheiro sujo ` "
										},
									}, 
									footer = { 
										text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
										icon_url = "https://i.imgur.com/q99CLfp.png" 
									},
									color = 16753920 
								}
							}
						}), { ['Content-Type'] = 'application/json' })
				return true
			end			
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
function Drog.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent("NotifyPush",player,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 71, title = "Denúncia de venda de municao em andamento", x = x, y = y, z = z, rgba = {0,0,0} })
				end)
			end
		end
		
	end
end