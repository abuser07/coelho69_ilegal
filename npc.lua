
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")


local pedlist = {
    { ['x'] = 449.57, ['y'] = -752.95, ['z'] = 27.36, ['h'] = 271.40, ['hash'] = 0x69E8ABC3, ['hash2'] = "cs_tom" }, --INICIO RORA VENDA DROGAS
    { ['x'] = -98.24, ['y'] = -2374.36, ['z'] = 9.37, ['h'] = 95.92, ['hash'] = 0x14D7B4E0, ['hash2'] = "s_m_m_dockwork_01" }, -- INICIO ROTA VENDA DROGAS NAVIO
    { ['x'] = 1249.4, ['y'] = -3007.53, ['z'] = 9.32, ['h'] = 273.53, ['hash'] = 0x14D7B4E0, ['hash2'] = "s_m_m_dockwork_01" }, -- INICIO ROTA VENDA ARMAS
    { ['x'] = -207.27, ['y'] = -2363.94, ['z'] = 9.32, ['h'] = 107.08, ['hash'] = 0x14D7B4E0, ['hash2'] = "s_m_m_dockwork_01" }, -- INICIO ROTA VENDA MUNIÇÃO
   }
   
   CreateThread(function()
    for k,v in pairs(pedlist) do
     RequestModel(GetHashKey(v.hash2))
     while not HasModelLoaded(GetHashKey(v.hash2)) do Wait(100) end
     ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
     peds = ped
     FreezeEntityPosition(ped,true)
     SetEntityInvincible(ped,true)
     SetBlockingOfNonTemporaryEvents(ped,true)
    end
   end)