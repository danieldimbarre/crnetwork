RegisterCommand("pzcreate",function(source,Message)
  local zoneType = Message[1]
  if not zoneType then
    return
  end
  if zoneType ~= 'poly' and zoneType ~= 'circle' and zoneType ~= 'box' then
    return
  end
  local name = nil
  if #Message >= 2 then name = Message[2]
  else name = GetUserInput("Enter name of zone:") end
  if not name or name == "" then
    return
  end
  TriggerEvent("polyzone:pzcreate", zoneType, name, Message)
end)

RegisterCommand("pzadd",function()
  TriggerEvent("polyzone:pzadd")
end)

RegisterCommand("pzundo",function()
  TriggerEvent("polyzone:pzundo")
end)

RegisterCommand("pzfinish",function()
  TriggerEvent("polyzone:pzfinish")
end)

RegisterCommand("pzlast",function()
  TriggerEvent("polyzone:pzlast")
end)

RegisterCommand("pzcancel",function()
  TriggerEvent("polyzone:pzcancel")
end)

RegisterCommand("pzcomboinfo",function()
    TriggerEvent("polyzone:pzcomboinfo")
end)

Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/pzcreate', 'Starts creation of a zone for PolyZone of one of the available types: circle, box, poly', {
    {name="zoneType", help="Zone Type (required)"},
  })

  TriggerEvent('chat:addSuggestion', '/pzadd', 'Adds point to zone.', {})
  TriggerEvent('chat:addSuggestion', '/pzundo', 'Undoes the last point added.', {})
  TriggerEvent('chat:addSuggestion', '/pzfinish', 'Finishes and prints zone.', {})
  TriggerEvent('chat:addSuggestion', '/pzlast', 'Starts creation of the last zone you finished (only works on BoxZone and CircleZone)', {})
  TriggerEvent('chat:addSuggestion', '/pzcancel', 'Cancel zone creation.', {})
  TriggerEvent('chat:addSuggestion', '/pzcomboinfo', 'Prints some useful info for all created ComboZones', {})
end)