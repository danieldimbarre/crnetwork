local minZ, maxZ = nil, nil

local function handleInput(center)
  local rot = GetGameplayCamRot(2)
  center = handleArrowInput(center, rot.z)
  return center
end

function polyStart(name)
  local Coords = GetEntityCoords(PlayerPedId())
  createdZone = PolyZone:Create({vector2(Coords.x, Coords.y)}, {name = tostring(name), useGrid=false})
  Citizen.CreateThread(function()
    while createdZone do
      -- Have to convert the point to a vector3 prior to calling handleInput,
      -- then convert it back to vector2 afterwards
      lastPoint = createdZone.points[#createdZone.points]
      lastPoint = vec3(lastPoint.x, lastPoint.y, 0.0)
      lastPoint = handleInput(lastPoint)
      createdZone.points[#createdZone.points] = lastPoint.xy
      Wait(0)
    end
  end)
  minZ, maxZ = Coords.z, Coords.z
end

function polyFinish()
  TriggerServerEvent("polyzone:printPoly",
    {name=createdZone.name, points=createdZone.points, minZ=minZ, maxZ=maxZ})
end

RegisterNetEvent("polyzone:pzadd")
AddEventHandler("polyzone:pzadd", function()
  if createdZone == nil or createdZoneType ~= 'poly' then
    return
  end

  local Coords = GetEntityCoords(PlayerPedId())

  if (Coords.z > maxZ) then
    maxZ = Coords.z
  end

  if (Coords.z < minZ) then
    minZ = Coords.z
  end

  createdZone.points[#createdZone.points + 1] = vector2(Coords.x, Coords.y)
end)

RegisterNetEvent("polyzone:pzundo")
AddEventHandler("polyzone:pzundo", function()
  if createdZone == nil or createdZoneType ~= 'poly' then
    return
  end

  createdZone.points[#createdZone.points] = nil
  if #createdZone.points == 0 then
    TriggerEvent("polyzone:pzcancel")
  end
end)