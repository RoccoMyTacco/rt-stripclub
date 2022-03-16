local QBCore = exports['qb-core']:GetCoreObject()
local isLocked = false

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

Citizen.CreateThread(function()
    vanilla = AddBlipForCoord(117.11, -1294.44, 29.27)
    SetBlipSprite(vanilla, 121)
    SetBlipAsShortRange(vanilla, true)
    SetBlipScale(vanilla, 0.85)
    SetBlipColour(vanilla, 52)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Vanilla Unicorn")
    EndTextCommandSetBlipName(vanilla)
end)


Citizen.CreateThread(function()
    modelHash2 = GetHashKey("s_f_y_stripper_01")
    RequestModel(modelHash2)
    while not HasModelLoaded(modelHash2) do
        Wait(0)
    end
    createstipperpos1()
    createstipperpos2()
end)



local stripper = { x = 117.55, y = -1296.09, z = 28.27, h = 303.76 }
local stripper2 = { x = 115.87, y = -1286.8, z = 27.88, h = 303.76 }
local stripper3 = { x = 112.86, y = -1283.17, z = 27.88, h = 303.76 }

function createstipperpos1()
    urmom = CreatePed(0, modelHash2, stripper2.x, stripper2.y, stripper2.z, stripper2.h, false, true)
    FreezeEntityPosition(urmom, true)
    SetEntityInvincible(urmom, true)
    SetBlockingOfNonTemporaryEvents(urmom, true)
    loadAnimDict("mini@strip_club@private_dance@part1")
    TaskPlayAnim(urmom, "mini@strip_club@private_dance@part1", "priv_dance_p1", -1, -1, -1, 1, 1, 0, 0, 0)
end

function createstipperpos2()
    daddy = CreatePed(0, modelHash2, stripper3.x, stripper3.y, stripper3.z, stripper3.h, false, true)
    FreezeEntityPosition(daddy, true)
    SetEntityInvincible(daddy, true)
    SetBlockingOfNonTemporaryEvents(daddy, true)
    loadAnimDict("mini@strip_club@private_dance@part1")
    TaskPlayAnim(daddy, "mini@strip_club@private_dance@part1", "priv_dance_p1", -1, -1, -1, 1, 1, 0, 0, 0)
end

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


function poledance()
    dancetype = 0
	ClearPedSecondaryTask(PlayerPedId())

	loadAnimDict( "mini@strip_club@pole_dance@pole_dance1" )
	loadAnimDict( "mini@strip_club@pole_dance@pole_dance2" )
	loadAnimDict( "mini@strip_club@pole_dance@pole_dance3" )
    loadAnimDict( "mini@strip_club@pole_dance@pole_enter" ) 	  	

	TaskPlayAnim( PlayerPedId(), "mini@strip_club@pole_dance@pole_enter", "pd_enter", 1.0, -1.0, -1, 0, 1, 0, 0, 0) 
	length = GetAnimDuration("mini@strip_club@pole_dance@pole_enter", "pd_enter")
	Citizen.Wait(length) 

	TaskPlayAnim( PlayerPedId(), "mini@strip_club@pole_dance@pole_dance1", "pd_dance_01", 1.0, -1.0, -1, 0, 1, 0, 0, 0) 
	length = GetAnimDuration("mini@strip_club@pole_dance@pole_dance1", "pd_dance_01")
	Citizen.Wait(length)    

	TaskPlayAnim( PlayerPedId(), "mini@strip_club@pole_dance@pole_dance2", "pd_dance_02", 1.0, -1.0, -1, 0, 1, 0, 0, 0)
	length = GetAnimDuration("mini@strip_club@pole_dance@pole_dance2", "pd_dance_02")
	Citizen.Wait(length)  

	TaskPlayAnim( PlayerPedId(), "mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", 1.0, -1.0, -1, 0, 1, 0, 0, 0)
	length = GetAnimDuration("mini@strip_club@pole_dance@pole_dance3", "pd_dance_03")
	Citizen.Wait(length)  

end

RegisterNetEvent("attachtopole")
AddEventHandler("attachtopole", function()
		local ped = PlayerPedId()
		local chair = CreateObject( `prop_flagpole_1a`, 108.79, -1289.29, 29.0, true, false, false)
		SetEntityCollision(chair,false,false)
		SetEntityVisible(chair, false)
		Dancing = true
		AttachEntityToEntity(ped, chair, GetPedBoneIndex(ped, 6286), 0.10, 0.10, 0.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 1, false)
        poledance()
        DeleteObject(chair)

end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dad = Config.Locations.coords
        local inRange = false
        local dist = #(pos - dad)
        local dancing = false
        if dist < 5 then
            inRange = true
            if dist < 1.5 then
                DrawText3Ds(dad.x, dad.y, dad.z, "~g~E~w~ - Pole")
                if IsControlJustReleased(0, 38) then
                    TriggerEvent('attachtopole')
                end
            end  
        end
        if not inRange then
            Citizen.Wait(5000)
        end
        Citizen.Wait(3)
    end
end)

isLoggedIn = false
PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
    Citizen.CreateThread(function()
        while true do
            if GetClockHours() >= 7 and GetClockHours() <= 17 then
                if isLocked then
                    TriggerServerEvent('nui_doorlock:server:updateState', 1991, true, false, false, true)
                    TriggerServerEvent('nui_doorlock:server:updateState', 1992, true, false, false, true)
                    TriggerServerEvent('nui_doorlock:server:updateState', 1993, true, false, false, true)
                    isLocked = false
                end
            else
                if not isLocked then
                    TriggerServerEvent('nui_doorlock:server:updateState', 1991, false, false, false, true)
                    TriggerServerEvent('nui_doorlock:server:updateState', 1992, false, false, false, true)
                    TriggerServerEvent('nui_doorlock:server:updateState', 1993, false, false, false, true)
                    isLocked = true
                end
            end
            Wait(1000)
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    isLoggedIn = true 
    PlayerJob = JobInfo
end)

RegisterNetEvent('qb-stripclub:takerum')
AddEventHandler('qb-stripclub:takerum',function() 
    if PlayerJob.name == "unicorn" then 
        TakeRum()
    else 
        QBCore.Functions.Notify("You aren\'t a Vanilla Unicorn employee!", "error")
    end
end)

RegisterNetEvent('qb-stripclub:takepineapplejuice')
AddEventHandler('qb-stripclub:takepineapplejuice',function() 
    if PlayerJob.name == "unicorn" then 
        TakePineappleJuice()
    else 
        QBCore.Functions.Notify("You aren\'t a Vanilla Unicorn employee!", "error")
    end
end)

RegisterNetEvent('qb-stripclub:takeschnapps')
AddEventHandler('qb-stripclub:takeschnapps',function() 
    if PlayerJob.name == "unicorn" then 
        TakeSchnapps()
    else 
        QBCore.Functions.Notify("You aren\'t a Vanilla Unicorn employee!", "error")
    end
end)

RegisterNetEvent('qb-stripclub:takeirishcream')
AddEventHandler('qb-stripclub:takeirishcream',function() 
    if PlayerJob.name == "unicorn" then 
        TakeIrishCream()
    else 
        QBCore.Functions.Notify("You aren\'t a Vanilla Unicorn employee!", "error")
    end
end)

RegisterNetEvent('qb-stripclub:MixBlueHawaiian')
AddEventHandler('qb-stripclub:MixBlueHawaiian',function() 
    if PlayerJob.name == "unicorn" then 
        QBCore.Functions.TriggerCallback("qb-stripclub:getbluehawaiian",function(data) 
            if data then 
                MakeHawaiian()
            else 
                QBCore.Functions.Notify("You don\'t have all ingredients!", "error")
            end 
        end)
    else 
        QBCore.Functions.Notify("You aren\'t a Vanilla Unicorn employee!", "error")
    end
end)

RegisterNetEvent('qb-stripclub:MixButteryNipple')
AddEventHandler('qb-stripclub:MixButteryNipple',function() 
    if PlayerJob.name == "unicorn" then 
        QBCore.Functions.TriggerCallback("qb-stripclub:getbutterynipple",function(cb) 
            if cb == true then 
                MakeButteryNipple()
            else 
                QBCore.Functions.Notify("You don\'t have all ingredients!", "error")
            end 
        end)
    else 
        QBCore.Functions.Notify("You aren\'t a Vanilla Unicorn employee!", "error")
    end
end)


RegisterNetEvent('qb-stripclub:stash')
AddEventHandler('qb-stripclub:stash',function() 
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Shelf")
    TriggerEvent("inventory:client:SetCurrentStash", "Shelf")
end)

RegisterNetEvent('qb-stripclub:sell')
AddEventHandler('qb-stripclub:sell',function() 
            Order() 
end)

-- // Drink Functions \\

function MakeHawaiian()
    QBCore.Functions.Progressbar('mixing_drink', 'Making a Blue Hawaiian', 8000, false, false, {
        disableMovement = true, --
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@prison_heiststation@cop_reactions",
        anim = "cop_b_idle",
        flags = 8,
    }, {}, {}, function()  
        TriggerServerEvent('qb-stripclub:givebluehawaiian') 
        QBCore.Functions.Notify("You\'ve made a Blue Hawaiian", "success")
    end, function() -- Cancel
        TriggerEvent('inventory:client:busy:status', false)
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end

function MakeButteryNipple()
    QBCore.Functions.Progressbar('mixing_drink', 'Making a Buttery Nipple', 8000, false, false, {
        disableMovement = true, --
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@prison_heiststation@cop_reactions",
        anim = "cop_b_idle",
        flags = 8,
    }, {}, {}, function()  
        TriggerServerEvent('qb-stripclub:givebutterynipple') 
        QBCore.Functions.Notify("You\'ve made a Buttery Nipple", "success")
    end, function() -- Cancel
        TriggerEvent('inventory:client:busy:status', false)
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end

function TakeRum()
    QBCore.Functions.Progressbar('taking_rum', 'Taking Rum', 6000, false, false, {
        disableMovement = true, --
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@prison_heiststation@cop_reactions",
        anim = "cop_b_idle",
        flag = 8,
    }, {}, {}, function() 
        TriggerServerEvent('qb-stripclub:TakeRum')
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        TriggerEvent('inventory:client:busy:status', false)
        QBCore.Functions.Notify("Cancelled..", "error") 
    end)
end

function TakePineappleJuice()
    QBCore.Functions.Progressbar('taking_pineapplejuice', 'Taking Juice', 6000, false, false, {
        disableMovement = true, --
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@prison_heiststation@cop_reactions",
        anim = "cop_b_idle",
        flag = 8,
    }, {}, {}, function() 
        TriggerServerEvent('qb-stripclub:TakePineappleJuice')
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        TriggerEvent('inventory:client:busy:status', false)
        QBCore.Functions.Notify("Cancelled..", "error") 
    end)
end

function TakeSchnapps()
    QBCore.Functions.Progressbar('taking_schnapps', 'Taking Butterscotch Schnapps', 6000, false, false, {
        disableMovement = true, --
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@prison_heiststation@cop_reactions",
        anim = "cop_b_idle",
        flag = 8,
    }, {}, {}, function() 
        TriggerServerEvent('qb-stripclub:TakeSchnapps')
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        TriggerEvent('inventory:client:busy:status', false)
        QBCore.Functions.Notify("Cancelled..", "error") 
    end)
end

function TakeIrishCream()
    QBCore.Functions.Progressbar('taking_schnapps', 'Taking Irish Cream', 6000, false, false, {
        disableMovement = true, --
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@prison_heiststation@cop_reactions",
        anim = "cop_b_idle",
        flag = 8,
    }, {}, {}, function() 
        TriggerServerEvent('qb-stripclub:TakeIrishCream')
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        TriggerEvent('inventory:client:busy:status', false)
        QBCore.Functions.Notify("Cancelled..", "error") 
    end)
end

function Order()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "PickupOrder_")
    TriggerEvent("inventory:client:SetCurrentStash", "PickupOrder_")
end

-- // Utilities \\ 

RegisterNetEvent('stripclub-ui:openOrder', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Blue Hawaiian",
            txt = "1 Blue Hawaiian | 8s  ",
            params = {
                event = "qb-stripclub:MixBlueHawaiian",
                args = {
                    number = 1,
                    id = 1
                }
            }
        },
        {
            id = 2,
            header = "Buttery Nipple",
            txt = "1 ButteryNipple | 8s  ",
            params = {
                event = "qb-stripclub:MixButteryNipple",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('stripclub-ui:SongMenu', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Song Selection",
            txt = "Song Selection Screen",
            params = {
                event = "qb-stripclub:client:open:songs",
                args = {
                    number = 1,
                    id = 1
                }
            }
        },
    })
end)

RegisterNetEvent('stripclub-ui:drink', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Rum",
            txt = "1 Rum | 6s  ",
            params = {
                event = "qb-stripclub:takerum",
                args = {
                    number = 1,
                    id = 1
                }
            }
        },
        {
            id = 2,
            header = "Pineapple Juice",
            txt = "1 Pineapple Juice | 5s  ",
            params = {
                event = "qb-stripclub:takepineapplejuice",
                args = {
                    number = 1,
                    id = 2
                }
            }            
        },
        {
            id = 3,
            header = "Irish Cream",
            txt = "1 Irish Cream | 5s  ",
            params = {
                event = "qb-stripclub:takeirishcream",
                args = {
                    number = 1,
                    id = 3
                }
            }            
        },
        {
            id = 4,
            header = "Butterscotch Schnapps",
            txt = "1 Butterscotch Schnapps | 5s  ",
            params = {
                event = "qb-stripclub:takeschnapps",
                args = {
                    number = 1,
                    id = 4
                }
            }            
        },
    })
end)

RegisterNetEvent('qb-stripclub:client:IsPlaying')
AddEventHandler('qb-stripclub:client:IsPlaying', function()
    xSound = exports.xsound
    local pos = vector3(118.22, -1286.09, 31.9)
    Songinfor = {}
    SoundExist = xSound:soundExists("name")
    if SoundExist ~= true then
        for k, v in pairs(Config.ActiveSongs) do
            local songies = v.Songurl
            if songies ~= nil then
                local Id = k
                xSound:PlayUrlPos("name",songies,1,pos)
                xSound:Distance("name",28)
                xSound:setVolume("name", 0.25)
                TriggerServerEvent('qb-stripclub:server:removesong', Id)
                    xSound:onPlayEnd("name", function()
                        TriggerEvent('qb-stripclub:client:IsPlaying')
                    end)
            else
                QBCore.Functions.Notify("Out Of Songs", "error")
            end
        end
    end
end)

RegisterNetEvent('qb-stripclub:client:pausesong')
AddEventHandler('qb-stripclub:client:pausesong', function()
    xSound = exports.xsound
    xSound:Pause("name")
end)

RegisterNetEvent('qb-stripclub:client:skipsong')
AddEventHandler('qb-stripclub:client:skipsong', function()
    xSound = exports.xsound
    xSound:Destroy("name")
    TriggerEvent('qb-stripclub:client:IsPlaying')
end)

RegisterNetEvent('qb-stripclub:client:playsong')
AddEventHandler('qb-stripclub:client:playsong', function()
    xSound = exports.xsound
    xSound:Resume("name")
    TriggerEvent('qb-stripclub:client:IsPlaying')
end)

RegisterNetEvent('qb-stripclub:client:volume')
AddEventHandler('qb-stripclub:client:volume', function(volume)
    xSound = exports.xsound
    xSound:setVolume("name", volume)
end)

RegisterNetEvent('qb-stripclub:client:distance')
AddEventHandler('qb-stripclub:client:distance', function(distance)
    xSound = exports.xsound
    xSound:Distance("name", distance)
end)

RegisterNetEvent('qb-stripclub:client:open:payment')
AddEventHandler('qb-stripclub:client:open:payment', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'OpenPayment', payments = Config.ActivePayments})
end)

RegisterNetEvent('qb-stripclub:client:open:register')
AddEventHandler('qb-stripclub:client:open:register', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'OpenRegister'})
end)

RegisterNetEvent('qb-stripclub:client:open:songs')
AddEventHandler('qb-stripclub:client:open:songs', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'OpenSong', activesongs = Config.ActiveSongs})
end)

RegisterNetEvent('qb-stripclub:client:open:queue')
AddEventHandler('qb-stripclub:client:open:queue', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'OpenQueue', activesongs = Config.ActiveSongs})
end)

RegisterNetEvent('qb-stripclub:client:sync:register')
AddEventHandler('qb-stripclub:client:sync:register', function(RegisterConfig)
    Config.ActivePayments = RegisterConfig
end)

RegisterNetEvent('qb-stripclub:client:sync:songs')
AddEventHandler('qb-stripclub:client:sync:songs', function(SongsConfig)
    Config.ActiveSongs = SongsConfig
    TriggerEvent('qb-stripclub:client:IsPlaying')

end)

function GetActiveRegister()
    return Config.ActivePayments
end

function GetActiveSongs()
    return Config.ActiveSongs
end

RegisterNUICallback('Click', function()
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
end)

RegisterNUICallback('ErrorClick', function()
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
end)

RegisterNUICallback('AddPrice', function(data)
    TriggerServerEvent('qb-stripclub:server:add:register', data.Price, data.Note)
end)

RegisterNUICallback('AddSong', function(data)
    TriggerServerEvent('qb-stripclub:server:addsong', data.Songurl)
end)
RegisterNUICallback('PauseSong', function()
    TriggerServerEvent('qb-stripclub:server:pausesong')
end)
RegisterNUICallback('PlaySong', function()
    TriggerServerEvent('qb-stripclub:server:playsong')
end)

RegisterNUICallback('SetVolume', function(data)
    TriggerServerEvent('qb-stripclub:server:Volume', data.Volume)
end)

RegisterNUICallback('PayReceipt', function(data)
    TriggerServerEvent('qb-stripclub:server:pay:receipt', data.Price, data.Note, data.Id)
end)
RegisterNUICallback('RemoveSong', function(data)
    TriggerServerEvent('qb-stripclub:server:removesong', data.Id)
end)
RegisterNUICallback('SkipSong', function(data)
    TriggerServerEvent('qb-stripclub:server:skipsong', data.Id)
end)

RegisterNUICallback('CloseNui', function()
    SetNuiFocus(false, false)
end)




Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("MakeDrinks", vector3(130.52, -1281.65, 29.35), 1.0, 1.3, {
        name = "MakeDrinks",
        heading = 210.0,
        debugPoly = false,
        minZ = 28.42,
        maxZ = 29.72
        }, {
        options = {
            {
                event = "stripclub-ui:openOrder",
                icon = "fas fa-sort-circle-up",
                label = "Drink Mixer",
                job = 'unicorn' 
            }
        },
        distance = 2.0
    })
    exports['qb-target']:AddBoxZone("GetIngredients", vector3(132.52, -1285.5, 28.96), 1.0, 1.3, {
        name = "GetIngredients",
        heading = 210.0,
        debugPoly = false,
        minZ = 28.12,
        maxZ = 28.92
        }, {
        options = {
            {
                event = "stripclub-ui:drink",
                icon = "fas fa-sort-circle-up",
                label = "Ingredients",
                job = 'unicorn' 
            }
        },
        distance = 2.0
    })
    exports['qb-target']:AddBoxZone("PayRegister", vector3(128.97, -1285.07, 29.37), 0.3, 0.5, {
        name = "PayRegister",
        heading = 210.0,
        debugPoly = false,
        minZ = 29.01,
        maxZ = 29.37
        }, {
        options = {
            {
                event = "qb-stripclub:client:open:payment",
                icon = "fas fa-sort-circle-up",
                label = "Pay",
            }
        },
        distance = 2.0
    })
    exports['qb-target']:AddBoxZone("DJ", vector3(120.04, -1281.72, 29.49), 0.3, 0.5, {
        name = "DJ",
        heading = 210.0,
        debugPoly = false,
        minZ = 29.01,
        maxZ = 29.51
        }, {
        options = {
            {
                event = "stripclub-ui:SongMenu",
                icon = "fas fa-sort-circle-up",
                label = "DJ",
                job = 'unicorn' 
            }
        },
        distance = 2.0
    })
    exports['qb-target']:AddBoxZone("Register", vector3(129.36, -1284.82, 29.3), 0.3, 0.5, {
        name = "Register",
        heading = 210.0,
        debugPoly = false,
        minZ = 29.2,
        maxZ = 29.4
        }, {
        options = {
            {
                event = "qb-stripclub:client:open:register",
                icon = "fas fa-sort-circle-up",
                label = "Register",
                job = 'unicorn' 
            }
        },
        distance = 2.0
    })

end)