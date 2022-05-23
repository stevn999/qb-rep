local QBCore = exports['qb-core']:GetCoreObject()
dump = function(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
local function getTime()
   return os.time()
end

QBCore.Commands.Add('checkrep', 'Check the reputation of a player', {{name='Player ID',help='The person who you are checking'}},true, function(source, args)
   if args[1] == nil then
      args[1] = source
   end
   local otherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
   if not otherPlayer then
      TriggerClientEvent("QBCore:Notify",source, 'Player not found', 'error')
      return
   end
   otherRep = otherPlayer.PlayerData.metadata["playerrep"]
   if otherRep == nil then
      otherRep = 0
   end
   print(dump(otherPlayer.PlayerData.charinfo["firstname"]))
   playerName = otherPlayer.PlayerData.charinfo["firstname"].. " " .. otherPlayer.PlayerData.charinfo["lastname"]
   TriggerClientEvent("QBCore:Notify",source, playerName ..'\'s reputation: ' .. otherRep, 'success')
end,"user")


QBCore.Commands.Add('rep', 'Give reputation to a player', {{name='Player ID',help='The person who you are repping'}}, true, function(source, args)
   if args[1] == nil then
      return
   end
   local sourcePlayer = QBCore.Functions.GetPlayer(source)
   local lastRepped = sourcePlayer.PlayerData.metadata["lastrep"]
   local sourceRep = sourcePlayer.PlayerData.metadata["playerrep"]
   if sourceRep == nil then
      sourceRep = 0
      sourcePlayer.Functions.SetMetaData('playerrep', (sourceRep))
   end
   local timeSince = getTime()-lastRepped
   if lastRepped == nil then
      sourcePlayer.Functions.SetMetaData('lastrep', getTime())
      lastRepped = sourcePlayer.PlayerData.metadata["lastrep"]
   end
   if source == tonumber(args[1]) then
      TriggerClientEvent("QBCore:Notify",source, 'You cannot rep yourself', 'error')
      return
   end
   
   local otherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
   if not otherPlayer then
      TriggerClientEvent("QBCore:Notify",source, 'Player not found', 'error')
      return
   end
   if timeSince < Config.cooldown then
      TriggerClientEvent("QBCore:Notify",source, 'You must wait '..Config.timeBetweenReps..' seconds between reps', 'error')
      return
   else
      sourcePlayer.Functions.SetMetaData('lastrep', getTime())
      otherRep = otherPlayer.PlayerData.metadata["playerrep"]
      if otherRep == nil then
         otherRep = 0
      end
      if sourceRep >= otherRep and sourceRep >= 0 then
         otherPlayer.Functions.SetMetaData('playerrep', (otherRep + 1))
         sourcePlayer.Functions.SetMetaData('lastrep', getTime())
         TriggerClientEvent("QBCore:Notify",source, 'You have repped '..otherPlayer.PlayerData.name..'!', 'success')
         TriggerClientEvent("QBCore:Notify",tonumber(args[1]), 'You have been repped by '..sourcePlayer.PlayerData.name..'!', 'success')
      else
         TriggerClientEvent("QBCore:Notify",source, 'You cannot rep '..otherPlayer.PlayerData.name..'!', 'error')
      end   

   end
end, 'user')

QBCore.Commands.Add('diss', 'Give reputation to a player', {{name='Player ID',help='The person who you are repping'}}, true, function(source, args)
   local sourcePlayer = QBCore.Functions.GetPlayer(source)
   if args[1] == nil then
      return
   end
   local lastRepped = sourcePlayer.PlayerData.metadata["lastrep"]
   local sourceRep = sourcePlayer.PlayerData.metadata["playerrep"]
   if sourceRep == nil then
      sourceRep = 0
      sourcePlayer.Functions.SetMetaData('playerrep', (sourceRep))
   end
   local timeSince = getTime()-lastRepped
   if lastRepped == nil then
      sourcePlayer.Functions.SetMetaData('lastrep', getTime())
      lastRepped = sourcePlayer.PlayerData.metadata["lastrep"]
   end
   if source == tonumber(args[1]) then
      TriggerClientEvent("QBCore:Notify",source, 'You cannot diss yourself', 'error')
      return
   end
   
   local otherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
   if not otherPlayer then
      TriggerClientEvent("QBCore:Notify",source, 'Player not found', 'error')
      return
   end
   if timeSince < Config.cooldown then
      TriggerClientEvent("QBCore:Notify",source, 'You must wait '..Config.timeBetweenReps..' seconds between reps', 'error')
      return
   else
      sourcePlayer.Functions.SetMetaData('lastrep', getTime())
      otherRep = otherPlayer.PlayerData.metadata["playerrep"]
      if otherRep == nil then
         otherRep = 0
      end
      if sourceRep >= otherRep and sourceRep >= 0 then
         otherPlayer.Functions.SetMetaData('playerrep', (otherRep - 1))
         sourcePlayer.Functions.SetMetaData('lastrep', getTime())
         TriggerClientEvent("QBCore:Notify",source, 'You have repped '..otherPlayer.PlayerData.name..'!', 'success')
         TriggerClientEvent("QBCore:Notify",tonumber(args[1]), 'You have been dissed by '..sourcePlayer.PlayerData.name..'!', 'success')
      else
         TriggerClientEvent("QBCore:Notify",source, 'You cannot diss '..otherPlayer.PlayerData.name..'!', 'error')
      end   

   end
end, 'user')

