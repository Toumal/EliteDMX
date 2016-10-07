animation_type_fixedvalue = 0
animation_type_ramp_up = 1
animation_type_ramp_down = 2
animation_type_ramp_updown = 3
animation_type_randomize = 4
animation_type_flash = 5
animation_type_randomflash = 6
animations = {}
math.randomseed(os.time())


-- You can defined your own constants here, these are just so you can stop a running effect if needed
effect_sequence_none = 0
effect_sequence_repairall = 1
effect_sequence_refuelall = 2
effect_sequence_heatwarning = 3
effect_sequence_hulldamage = 4
effect_sequence_miningrefined = 5
effect_sequence_ejectcargo = 6
effect_sequence_interdicted = 7
effect_sequence_docking = 8
effect_sequence_scan = 9
effect_sequence_launchfighter = 10
effect_sequence_launchsrv = 11


-- Main effect handling - this is where you put your desired effects for the DMX channels your lights/smoke/laser use!
-- You can define multiple effects for each channel for every game event.
-- In order to be able to stop multi-channel effects for one event, they are organized into "effectsequences"
-- So for example you could have the RefuelAll game event start three animations on three individual channels, 
-- but you give them all the same effectsequence value (first parameter). Then when you want to stop the refuel effect
-- across all used channels, just call StopAnimation(effectsequence-id)

smoke1 = 1; -- smoke machine on channel 1, used for hull damage effects

light1_r = 11; -- light group 1 on channel 11/12/13 for Red/Green/Blue, used for ship states, alarm flashes, etc. - best done with spots aimed at the walls
light1_g = 12;
light1_b = 13;

light2_r = 14; -- light group 2 on channel 14/15/16 for Red/Green/Blue, used for damage effects etc. - best done as one or more spots shining at/near players
light2_g = 15;
light2_b = 16;

function EffectsHandler ()
	local json = JSON:decode(gameEventJson)
	
	-- Syntax:
	-- Animation.StartAnimation(effectsequence, animationDmxChannel, animationType, startValue, endValue, stepValue, repeatCount, delay)
	
	if (json.event == "JetConeBoost") then
	    -- light1 turning on blue to show boost enabled status
		Animation.StartAnimation(effect_sequence_none, light1_b, animation_type_ramp_up, 0, 255, 30, 1, 0)
	end
	if (json.event == "DockingGranted") then
		-- light1 blinking green
		for i=0,8000,80 do
			Animation.StartAnimation(effect_sequence_docking, light1_g, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_docking, light1_g, animation_type_fixedvalue, 0, 0, 0, 1, i+40)
		end
	end
	if (json.event == "Docked") then
		Animation.StopAnimation(effect_sequence_docking)
		-- light1 and 2 turning on full white when docked
		Animation.StartAnimation(effect_sequence_none, light1_r, animation_type_ramp_up, 0, 255, 30, 1, 0)
		Animation.StartAnimation(effect_sequence_none, light1_g, animation_type_ramp_up, 0, 255, 30, 1, 0)
		Animation.StartAnimation(effect_sequence_none, light1_b, animation_type_ramp_up, 0, 255, 30, 1, 0)
		Animation.StartAnimation(effect_sequence_none, light2_r, animation_type_ramp_up, 0, 255, 30, 1, 0)
		Animation.StartAnimation(effect_sequence_none, light2_g, animation_type_ramp_up, 0, 255, 30, 1, 0)
		Animation.StartAnimation(effect_sequence_none, light2_b, animation_type_ramp_up, 0, 255, 30, 1, 0)
	end
	if (json.event == "Undocked") then
		-- light1 white fadeout
		Animation.StartAnimation(effect_sequence_refuelall, light1_r, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light1_g, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light1_b, animation_type_ramp_down, 250, 0, 10, 1, 0)
		-- light2 white fadeout
		Animation.StartAnimation(effect_sequence_refuelall, light2_r, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light2_g, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light2_b, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "DockingTimeout") then
		Animation.StopAnimation(effect_sequence_docking)
	end
	if (json.event == "DockingDenied") then
		Animation.StopAnimation(effect_sequence_docking)
	end
	if (json.event == "DockingCancelled") then
		Animation.StopAnimation(effect_sequence_docking)
	end
	if (json.event == "Died") then
		Animation.StopAnimation(effect_sequence_heatwarning)
		Animation.StopAnimation(effect_sequence_hulldamage)
		-- light1 white fadeout
		Animation.StartAnimation(effect_sequence_refuelall, light1_r, animation_type_ramp_down, 255, 0, 1, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light1_g, animation_type_ramp_down, 255, 0, 1, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light1_b, animation_type_ramp_down, 255, 0, 1, 1, 0)
		-- light2 white fadeout
		Animation.StartAnimation(effect_sequence_refuelall, light2_r, animation_type_ramp_down, 255, 0, 1, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light2_g, animation_type_ramp_down, 255, 0, 1, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light2_b, animation_type_ramp_down, 255, 0, 1, 1, 0)
	end
	if (json.event == "Scan") then
		Animation.StopAnimation(effect_sequence_heatwarning)
		Animation.StopAnimation(effect_sequence_hulldamage)
		-- light1 blue fadeout
		Animation.StartAnimation(effect_sequence_scan, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light1_g, animation_type_fixedvalue, 0, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light1_b, animation_type_ramp_down, 255, 0, 1, 1, 0)
		-- light2 purple fadeout
		Animation.StartAnimation(effect_sequence_scan, light2_r, animation_type_ramp_down, 255, 0, 1, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light2_g, animation_type_fixedvalue, 0, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light2_b, animation_type_ramp_down, 255, 0, 1, 1, 0)
	end
	if (json.event == "FSDJump") then
		-- Hopefully we will be able to get the star type from the game event, and make this color match the star!
		star_r = 255
		star_g = 200
		star_b = 40
		Animation.StartAnimation(effect_sequence_scan, light1_r, animation_type_fixedvalue, star_r, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light1_g, animation_type_fixedvalue, star_g, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light1_b, animation_type_fixedvalue, star_b, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light2_r, animation_type_fixedvalue, star_r, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light2_g, animation_type_fixedvalue, star_g, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_scan, light2_b, animation_type_fixedvalue, star_b, 0, 0, 1, 0)
		-- light1 fadeout
		Animation.StartAnimation(effect_sequence_refuelall, light1_r, animation_type_ramp_down, star_r, 0, 1, 1, 200)
		Animation.StartAnimation(effect_sequence_refuelall, light1_g, animation_type_ramp_down, star_g, 0, 1, 1, 200)
		Animation.StartAnimation(effect_sequence_refuelall, light1_b, animation_type_ramp_down, star_b, 0, 1, 1, 200)
		-- light2 fadeout
		Animation.StartAnimation(effect_sequence_refuelall, light2_r, animation_type_ramp_down, star_r, 0, 1, 1, 200)
		Animation.StartAnimation(effect_sequence_refuelall, light2_g, animation_type_ramp_down, star_g, 0, 1, 1, 200)
		Animation.StartAnimation(effect_sequence_refuelall, light2_b, animation_type_ramp_down, star_b, 0, 1, 1, 200)
	end
	if (json.event == "RefuelAll") then
		-- light1 yellow pulse on refueling
		Animation.StartAnimation(effect_sequence_refuelall, light1_r, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, light1_g, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "RepairAll") then
		-- light1 green pulse on repair
		Animation.StartAnimation(effect_sequence_repairall, light1_g, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "HeatWarning") then
		Animation.StopAnimation(effect_sequence_heatwarning)
		-- light1 blinking red
		for i=0,200,20 do
			Animation.StartAnimation(effect_sequence_hulldamage, light1_r, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_hulldamage, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, i+10)
		end
	end
	if (json.event == "LaunchFighter" or json.event == "DockFighter") then
		-- light1 blinking yellow
		for i=0,400,40 do
			Animation.StartAnimation(effect_sequence_launchfighter, light1_r, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_launchfighter, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, i+20)
			Animation.StartAnimation(effect_sequence_launchfighter, light1_g, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_launchfighter, light1_g, animation_type_fixedvalue, 0, 0, 0, 1, i+20)
		end
		-- light2 blinking yellow with offset
		for i=0,400,40 do
			Animation.StartAnimation(effect_sequence_launchfighter, light2_r, animation_type_fixedvalue, 255, 0, 0, 1, i+4)
			Animation.StartAnimation(effect_sequence_launchfighter, light2_r, animation_type_fixedvalue, 0, 0, 0, 1, i+24)
			Animation.StartAnimation(effect_sequence_launchfighter, light2_g, animation_type_fixedvalue, 255, 0, 0, 1, i+4)
			Animation.StartAnimation(effect_sequence_launchfighter, light2_g, animation_type_fixedvalue, 0, 0, 0, 1, i+24)
		end
		Animation.StartAnimation(effect_sequence_launchsrv, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, 500)
		Animation.StartAnimation(effect_sequence_launchsrv, light1_g, animation_type_fixedvalue, 0, 0, 0, 1, 500)
		Animation.StartAnimation(effect_sequence_launchsrv, light2_r, animation_type_fixedvalue, 0, 0, 0, 1, 500)
		Animation.StartAnimation(effect_sequence_launchsrv, light2_g, animation_type_fixedvalue, 0, 0, 0, 1, 500)
	end
	if (json.event == "LaunchSRV" or json.event == "DockSRV") then
		-- light1 blinking yellow
		for i=0,400,40 do
			Animation.StartAnimation(effect_sequence_launchsrv, light1_r, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_launchsrv, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, i+20)
			Animation.StartAnimation(effect_sequence_launchsrv, light1_g, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_launchsrv, light1_g, animation_type_fixedvalue, 0, 0, 0, 1, i+20)
		end
		-- light2 blinking yellow with offset
		for i=0,400,40 do
			Animation.StartAnimation(effect_sequence_launchsrv, light2_r, animation_type_fixedvalue, 255, 0, 0, 1, i+4)
			Animation.StartAnimation(effect_sequence_launchsrv, light2_r, animation_type_fixedvalue, 0, 0, 0, 1, i+24)
			Animation.StartAnimation(effect_sequence_launchsrv, light2_g, animation_type_fixedvalue, 255, 0, 0, 1, i+4)
			Animation.StartAnimation(effect_sequence_launchsrv, light2_g, animation_type_fixedvalue, 0, 0, 0, 1, i+24)
		end
		Animation.StartAnimation(effect_sequence_launchsrv, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, 500)
		Animation.StartAnimation(effect_sequence_launchsrv, light1_g, animation_type_fixedvalue, 0, 0, 0, 1, 500)
		Animation.StartAnimation(effect_sequence_launchsrv, light2_r, animation_type_fixedvalue, 0, 0, 0, 1, 500)
		Animation.StartAnimation(effect_sequence_launchsrv, light2_g, animation_type_fixedvalue, 0, 0, 0, 1, 500)
	end
	if (json.event == "EjectCargo") then
		Animation.StopAnimation(effect_sequence_ejectcargo)
		-- light1 blinking blue quickly
		for i=0,100,20 do
			Animation.StartAnimation(effect_sequence_hulldamage, light1_r, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_hulldamage, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, i+10)
		end
	end
	if (json.event == "MiningRefined") then
		Animation.StopAnimation(effect_sequence_miningrefined)
		Animation.StartAnimation(effect_sequence_miningrefined, light1_b, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "MaterialCollected") then
		Animation.StartAnimation(effect_sequence_none, light1_b, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "SupercruiseEntry" or json.event == "SupercruiseExit") then
		Animation.StartAnimation(effect_sequence_none, light1_r, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_none, light1_b, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_none, light2_r, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_none, light2_b, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "HullDamage") then
		Animation.StopAnimation(effect_sequence_hulldamage)
		-- light2 flashing randomly for a bit
		for i=0,80,3 do
			rand = math.random(200, 255);
			Animation.StartAnimation(effect_sequence_hulldamage, light2_r, animation_type_randomflash, rand, 255, 10, 1, i)
			Animation.StartAnimation(effect_sequence_hulldamage, light2_g, animation_type_randomflash, rand, 255, 10, 1, i)
			Animation.StartAnimation(effect_sequence_hulldamage, light2_b, animation_type_randomflash, rand, 255, 10, 1, i)
		end
		-- light1 blinking red
		for i=0,1600,40 do
			Animation.StartAnimation(effect_sequence_hulldamage, light1_r, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_hulldamage, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, i+20)
		end
		-- smoke1 enable
		Animation.StartAnimation(effect_sequence_hulldamage, smoke1, animation_type_fixedvalue, 255, 0, 0, 1, 0) -- smoke on
		Animation.StartAnimation(effect_sequence_hulldamage, smoke1, animation_type_fixedvalue, 0, 0, 0, 1, 200) -- smoke off
		Animation.StartAnimation(effect_sequence_hulldamage, smoke1, animation_type_fixedvalue, 0, 0, 0, 1, 250) -- repeat to ensure smoke off (sometimes DMX commmands are skipped for some reason)
		Animation.StartAnimation(effect_sequence_hulldamage, smoke1, animation_type_fixedvalue, 0, 0, 0, 1, 300) -- repeat to ensure smoke off (sometimes DMX commmands are skipped for some reason)
	end
	if (json.event == "Interdicted") then
		Animation.StopAnimation(effect_sequence_interdicted)
		--light1 blinking yellow
		for i=0,400,40 do
			Animation.StartAnimation(effect_sequence_hulldamage, light1_r, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_hulldamage, light1_r, animation_type_fixedvalue, 0, 0, 0, 1, i+20)
			Animation.StartAnimation(effect_sequence_hulldamage, light1_g, animation_type_fixedvalue, 255, 0, 0, 1, i)
			Animation.StartAnimation(effect_sequence_hulldamage, light1_g, animation_type_fixedvalue, 0, 0, 0, 1, i+20)
		end
	end

end


