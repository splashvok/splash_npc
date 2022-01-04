ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local pedkordi = {
    {240.31,-760.6,29.83,"Fegyverbolt",-10.0,0x2799EFD8,"a_f_y_business_01","Nálam vásárolhatsz fegyvereket"},
    {242.3,-761.47, 29.82,"Ruhabolt",-10.0,0x2799EFD8,"a_f_y_business_01","Nálam vásárolhatsz ruhákat"},
    {244.26,-762.06,29.81,"Bolt",-10.0,0x2799EFD8,"a_f_y_business_01","Nálam vásárolhatsz tárgyakat"},
    {246.13,-762.81,29.78,"Tároló",-10.0,0x2799EFD8,"a_f_y_business_01","Nálam tudod tárolni a tárgyaidat"},
    {248.35, -763.57, 29.79,"Bank",-10.0,0x2799EFD8,"a_f_y_business_01","Nálam tudod tárolni pénzedet"},
}

Citizen.CreateThread(function()

    for _,v in pairs(pedkordi) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"idle_storeclerk","missclothing", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        Citizen.Wait(0)
        for _,v in pairs(pedkordi) do
            x = v[1]
            y = v[2]
            z = v[3]
            if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 20.0)then
                DrawText3D(x,y,z+2.10, "~y~"..v[4], 1.2, 4)
                DrawText3D(x,y,z+1.95, "~w~"..v[8], 1.0, 4)
            end
        end
    end
end)

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end