local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-stripclub:server:pausesong')
AddEventHandler('qb-stripclub:server:pausesong', function(Songurl)
    TriggerClientEvent('qb-stripclub:client:pausesong', -1, "name")
end)

RegisterServerEvent('qb-stripclub:server:playsong')
AddEventHandler('qb-stripclub:server:playsong', function(Songurl)
    TriggerClientEvent('qb-stripclub:client:playsong', -1, "name")
end)

RegisterServerEvent('qb-stripclub:server:skipsong')
AddEventHandler('qb-stripclub:server:skipsong', function()
    TriggerClientEvent('qb-stripclub:client:skipsong', -1)
end)

RegisterServerEvent('qb-stripclub:server:Volume')
AddEventHandler('qb-stripclub:server:Volume', function(Volume)
    volume = Volume / 100
    TriggerClientEvent('qb-stripclub:client:volume', -1, volume)
end)

QBCore.Commands.Add('setvolume', 'Sets Volume for VU (God Only)', {{name = 'volume', help = '0 to 100'}}, true, function(source, args)
    local src = source
    volume = args[1] / 100
    TriggerClientEvent('qb-stripclub:client:volume', -1, volume)
end, 'god')

QBCore.Commands.Add('setmusicdistance', 'Sets Music distance for VU (God Only)', {{name = 'distance', help = 'default is 27'}}, true, function(source, args)
    local src = source
    distance = args[1]
    TriggerClientEvent('qb-stripclub:client:distance', -1, distance)
end, 'god')

QBCore.Functions.CreateUseableItem("bluehawaiian", function(source, item) TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name) end)
QBCore.Functions.CreateUseableItem("butterynipple", function(source, item) TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name) end)

RegisterServerEvent('qb-stripclub:givebluehawaiian')
AddEventHandler('qb-stripclub:givebluehawaiian', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['rums'], "remove") 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['pinejuice'], "remove") 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['bluehawaiian'], "add") 
    Player.Functions.RemoveItem('rums', 1)
    Player.Functions.RemoveItem('pinejuice', 1)
    Player.Functions.AddItem('bluehawaiian', 1) 
end)

RegisterServerEvent('qb-stripclub:givebutterynipple')
AddEventHandler('qb-stripclub:givebutterynipple', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['irishcream'], "remove") 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['schnapps'], "remove") 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['butterynipple'], "add") 
    Player.Functions.RemoveItem('irishcream', 1)
    Player.Functions.RemoveItem('schnapps', 1)
    Player.Functions.AddItem('butterynipple', 1) 
end)

QBCore.Functions.CreateCallback('qb-stripclub:getbluehawaiian', function(source, cb)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local rum = Player.Functions.GetItemByName('rums')
    local pinejuice = Player.Functions.GetItemByName('pinejuice')
    if rum ~= nil and pinejuice ~= nil then 
        cb(true)
    else 
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-stripclub:getbutterynipple', function(source, cb)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local schnapps = Player.Functions.GetItemByName('schnapps')
    local irishcream = Player.Functions.GetItemByName('irishcream')
    if schnapps ~= nil and irishcream ~= nil then 
        cb(true)
    else 
        cb(false)
    end
end)

RegisterServerEvent('qb-stripclub:TakeRum')
AddEventHandler('qb-stripclub:TakeRum', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['rums'], "add") 
    Player.Functions.AddItem('rums', 1) 
end)

RegisterServerEvent('qb-stripclub:TakePineappleJuice')
AddEventHandler('qb-stripclub:TakePineappleJuice', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['pinejuice'], "add") 
    Player.Functions.AddItem('pinejuice', 1) 
end)

RegisterServerEvent('qb-stripclub:TakeSchnapps')
AddEventHandler('qb-stripclub:TakeSchnapps', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['schnapps'], "add") 
    Player.Functions.AddItem('schnapps', 1) 
end)

RegisterServerEvent('qb-stripclub:TakeIrishCream')
AddEventHandler('qb-stripclub:TakeIrishCream', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['irishcream'], "add") 
    Player.Functions.AddItem('irishcream', 1) 
end)

-- // Register \\ 

RegisterServerEvent('qb-stripclub:server:add:register')
AddEventHandler('qb-stripclub:server:add:register', function(Price, Note)
    local RandomID = math.random(1111,9999)
    Config.ActivePayments[RandomID] = {['Price'] = Price, ['Note'] = Note}
    TriggerClientEvent('qb-stripclub:client:sync:register', -1, Config.ActivePayments)
end)

RegisterServerEvent('qb-stripclub:server:addsong')
AddEventHandler('qb-stripclub:server:addsong', function(Songurl)
    local RandomID = math.random(1111,9999)
    local songurl = Songurl
    Config.ActiveSongs[RandomID] = {['Songurl'] = Songurl}
    TriggerClientEvent('qb-stripclub:client:sync:songs', -1, Config.ActiveSongs)
end)

RegisterServerEvent('qb-stripclub:server:removesong')
AddEventHandler('qb-stripclub:server:removesong', function(Id)
    if Config.ActiveSongs[tonumber(Id)] ~= nil then
        Config.ActiveSongs[tonumber(Id)] = nil
        TriggerClientEvent('qb-stripclub:client:sync:songs', -1, Config.ActiveSongs)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Error..', 'error')
    end
end)


RegisterServerEvent('qb-stripclub:server:pay:receipt')
AddEventHandler('qb-stripclub:server:pay:receipt', function(Price, Note, Id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('cash', Price) then
        if Config.ActivePayments[tonumber(Id)] ~= nil then
            Config.ActivePayments[tonumber(Id)] = nil
            local test = Price / 2
            TriggerEvent('qb-banking:society:server:DepositMoney', src, test, 'unicorn')
            TriggerClientEvent('qb-stripclub:client:sync:register', -1, Config.ActivePayments)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Error..', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have enough cash..', 'error')
    end
end)

