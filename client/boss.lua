
local MoneyAmbulance = nil
---------------- FONCTIONS ------------------
function BossAmbulance()
	local BAmbulance = RageUI.CreateMenu("E.M.S", "Action(s) du patron")
	local Choose = RageUI.CreateSubMenu(BAmbulance, "E.M.S", "Action(s) du patron")
	local SubSudAmbulance = RageUI.CreateSubMenu(Choose, "E.M.S", "Action(s) Sud du patron")
	local SubNordAmbulance = RageUI.CreateSubMenu(Choose, "E.M.S", "Action(s) Nord du patron")
	BAmbulance:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)
	Choose:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)
	SubSudAmbulance:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)
	SubNordAmbulance:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)

    RageUI.Visible(BAmbulance, not RageUI.Visible(BAmbulance))

            while BAmbulance do
                Citizen.Wait(0)
                    RageUI.IsVisible(BAmbulance, true, true, true, function()

					RageUI.Separator("")

					if MoneyAmbulance ~= nil then
						RageUI.Separator("~b~Argent de société : ~s~"..MoneyAmbulance.."$")
					end

					RageUI.Separator("")

                    RageUI.ButtonWithStyle("Retirer de l'argent",nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
								RageUI.Popup({message = "<C>~b~[~b~Entreprise ~s~: ~r~L.S.M.S~b~]\n~r~Montant invalide"})
                            else
                                TriggerServerEvent("eAmbulance:retraitentreprise", amount)
                                RefreshAmbulanceMoney()
								coolcoolmec(3500)
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Déposer de l'argent",nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
								RageUI.Popup({message = "<C>~b~[~b~Entreprise ~s~: ~r~L.S.M.S~b~]\n~r~Montant invalide"})
                            else
                                TriggerServerEvent("eAmbulance:depotentreprise", amount)
                                RefreshAmbulanceMoney()
								coolcoolmec(3500)
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Recruter", nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
						if (Selected) then   
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('eAmbulance:recruter', GetPlayerServerId(closestPlayer))
							else
								RageUI.Popup({message = "<C>~b~[~b~Entreprise ~s~: ~r~L.S.M.S~b~]\n~r~Aucun joueur à proximité"})
							end 
							coolcoolmec(3500)
						end
					end)

						RageUI.ButtonWithStyle("Promouvoir", nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
						if (Selected) then   
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('eAmbulance:promouvoir', GetPlayerServerId(closestPlayer))
							else
								RageUI.Popup({message = "<C>~b~[~b~Entreprise ~s~: ~r~L.S.M.S~b~]\n~r~Aucun joueur à proximité"})
							end 
							coolcoolmec(3500)
						end
					end)

						RageUI.ButtonWithStyle("Rétrograder", nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
						if (Selected) then   
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('eAmbulance:descendre', GetPlayerServerId(closestPlayer))
							else
								RageUI.Popup({message = "<C>~b~[~b~Entreprise ~s~: ~r~L.S.M.S~b~]\n~r~Aucun joueur à proximité"})
							end 
							coolcoolmec(3500)
						end
					end)

						RageUI.ButtonWithStyle("Virer", nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
						if (Selected) then   
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('eAmbulance:virer', GetPlayerServerId(closestPlayer))
							else
								RageUI.Popup({message = "<C>~b~[~b~Entreprise ~s~: ~r~L.S.M.S~b~]\n~r~Aucun joueur à proximité"})
							end 
							coolcoolmec(3500)
						end
					end)

					RageUI.ButtonWithStyle("Achat de société", nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
					end, Choose)
                        
			end, function()
			end)

			RageUI.IsVisible(Choose, true, true, true, function()

				RageUI.ButtonWithStyle("Achat de société - Sud ", nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
				end, SubSudAmbulance)
				RageUI.ButtonWithStyle("Achat de société - Nord", nil, Config.RightLab, not cooldown, function(Hovered, Active, Selected)
				end, SubNordAmbulance)

			end, function()
			end)

			RageUI.IsVisible(SubSudAmbulance, true, true, true, function()
				RageUI.Separator("")
				if MoneyAmbulance ~= nil then
					RageUI.Separator("~b~Argent de société : ~s~"..MoneyAmbulance.."$")
				end
				RageUI.Separator("")

				RageUI.Separator("~b~Véhicule(s)")

				for k,v in pairs(Config.Garage.voiture) do
					if v.category == nil then 
						RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~"..v.restockprice.."$~s~ (+1)"}, not cooldown, function(Hovered, Active, Selected)
							if Selected then
								ESX.TriggerServerCallback('eAmbulance:getMoneySociety', function(ifGood)
									if ifGood then
										TriggerServerEvent("eAmbulance:addVehInGarage", GetHashKey(v.model))
								        RageUI.Popup({message = "<C>".. v.label .. "\n-"..v.restockprice.."$\nAjouté dans le garage "..Config.PrefixName})
										RefreshAmbulanceMoney()
										coolcoolmec(1500)
									else
										RageUI.Popup({message = "<C>".. v.label .. "\n-"..v.restockprice.."$\nPas assez d'argent chez les "..Config.PrefixName})
									end
								end, v.restockprice)			
							end
						end)
					end
				end

				RageUI.Separator("~b~Helico(s)")

				for k,v in pairs(Config.Garage.helico) do
					if v.category == nil then 
						RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~"..v.restockprice.."$~s~ (+1)"}, not cooldown, function(Hovered, Active, Selected)
							if Selected then
								ESX.TriggerServerCallback('eAmbulance:getMoneySociety', function(ifGood)
									if ifGood then
										TriggerServerEvent("eAmbulance:addVehInGarage", GetHashKey(v.model))
								        RageUI.Popup({message = "<C>".. v.label .. "\n-"..v.restockprice.."$\nAjouté dans le garage "..Config.PrefixName})
										RefreshAmbulanceMoney()
										coolcoolmec(1500)
									else
										RageUI.Popup({message = "<C>".. v.label .. "\n-"..v.restockprice.."$\nPas assez d'argent chez les "..Config.PrefixName})
									end
								end, v.restockprice)			
							end
						end)
					end
				end

				RageUI.Separator("~b~Bateau(x)")

				for k,v in pairs(Config.Garage.bato) do
					if v.category == nil then 
						RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~"..v.restockprice.."$~s~ (+1)"}, not cooldown, function(Hovered, Active, Selected)
							if Selected then
								ESX.TriggerServerCallback('eAmbulance:getMoneySociety', function(ifGood)
									if ifGood then
										TriggerServerEvent("eAmbulance:addVehInGarage", GetHashKey(v.model))
								        RageUI.Popup({message = "<C>".. v.label .. "\n-"..v.restockprice.."$\nAjouté dans le garage "..Config.PrefixName})
										RefreshAmbulanceMoney()
										coolcoolmec(1500)
									else
										RageUI.Popup({message = "<C>".. v.label .. "\n-"..v.restockprice.."$\nPas assez d'argent chez les "..Config.PrefixName})
									end
								end, v.restockprice)			
							end
						end)
					end
				end

			end, function()
            end)

			RageUI.IsVisible(SubNordAmbulance, true, true, true, function()

				RageUI.Separator("")
				if MoneyAmbulance ~= nil then
					RageUI.Separator("~b~Argent de société : ~s~"..MoneyAmbulance.."$")
				end
				RageUI.Separator("")

				RageUI.Separator("~b~Véhicule(s)")

				for k,v in pairs(Config.Garage.voiture) do
					if v.category == nil then 
						RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~"..v.restockprice.."$~s~ (+1)"}, not cooldown, function(Hovered, Active, Selected)
							if Selected then
								ESX.TriggerServerCallback('eAmbulance:getMoneySociety', function(ifGood)
									if ifGood then
										TriggerServerEvent("eAmbulance:addVehInGarageN", GetHashKey(v.model))
								        RageUI.Popup({message = "<C>".. v.label .. "\n-"..v.restockprice.."$\nAjouté dans le garage "..Config.PrefixName})
										RefreshAmbulanceMoney()
										coolcoolmec(1500)
									else
										RageUI.Popup({message = "<C>".. v.label .. "\n-"..v.restockprice.."$\nPas assez d'argent chez les "..Config.PrefixName})
									end
								end, v.restockprice)			
							end
						end)
					end
				end

			end, function()
            end)



            if not RageUI.Visible(BAmbulance) and not RageUI.Visible(SubSudAmbulance) and not RageUI.Visible(SubNordAmbulance) and not RageUI.Visible(Choose) then
            BAmbulance = RMenu:DeleteType("BAmbulance", true)
        end
    end
end   

--------------------------------------------

function RefreshAmbulanceMoney()
	ESX.TriggerServerCallback('eAmbulance:getSocietyMoney', function(money)
		UpdateAmbulanceMoney(money)
	end)
end

function UpdateAmbulanceMoney(money)
    MoneyAmbulance = ESX.Math.GroupDigits(money)
end