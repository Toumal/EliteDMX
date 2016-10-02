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
effect_sequence_repairall = 0
effect_sequence_refuelall = 1
effect_sequence_heatwarning = 2
effect_sequence_jetconeboost = 3
effect_sequence_hulldamage = 4
effect_sequence_miningrefined = 5
effect_sequence_ejectcargo = 6
effect_sequence_interdicted = 7


-- Main effect handling - this is where you put your desired effects for the DMX channels your lights/smoke/laser use!
-- You can define multiple effects for each channel for every game event.
-- In order to be able to stop multi-channel effects for one event, they are organized into "effectsequences"
-- So for example you could have the RefuelAll game event start three animations on three individual channels, 
-- but you give them all the same effectsequence value (first parameter). Then when you want to stop the refuel effect
-- across all used channels, just call StopAnimation(effectsequence-id)

function EffectsHandler ()
	local json = JSON:decode(gameEventJson)
	
	-- Syntax:
	-- Animation.StartAnimation(effectsequence, animationDmxChannel, animationType, startValue, endValue, stepValue, repeatCount, delay)
	
	if (json.event == "JetConeBoost") then
		Animation.StartAnimation(effect_sequence_jetconeboost, 13, animation_type_ramp_up, 0, 250, 30, 3, 0)
	end
	if (json.event == "RefuelAll") then
		Animation.StartAnimation(effect_sequence_refuelall, 11, animation_type_ramp_down, 250, 0, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_refuelall, 12, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "RepairAll") then
		Animation.StartAnimation(effect_sequence_repairall, 12, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "HeatWarning") then
		Animation.StopAnimation(effect_sequence_heatwarning);
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 10)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 20)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 30)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 40)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 50)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 60)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 70)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 80)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 90)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 100)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 110)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 120)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 130)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 140)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 150)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 160)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 170)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 255, 0, 0, 1, 180)
		Animation.StartAnimation(effect_sequence_heatwarning, 11, animation_type_fixedvalue, 0, 0, 0, 1, 190)
	end
	if (json.event == "EjectCargo") then
		Animation.StopAnimation(effect_sequence_ejectcargo);
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 255, 0, 0, 1, 0)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 0, 0, 0, 1, 10)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 255, 0, 0, 1, 20)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 0, 0, 0, 1, 30)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 255, 0, 0, 1, 40)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 0, 0, 0, 1, 50)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 255, 0, 0, 1, 60)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 0, 0, 0, 1, 70)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 255, 0, 0, 1, 80)
		Animation.StartAnimation(effect_sequence_ejectcargo, 13, animation_type_fixedvalue, 0, 0, 0, 1, 90)
	end
	if (json.event == "MiningRefined") then
		Animation.StopAnimation(effect_sequence_miningrefined);
		Animation.StartAnimation(effect_sequence_miningrefined, 13, animation_type_ramp_down, 250, 0, 10, 1, 0)
	end
	if (json.event == "HullDamage") then
		Animation.StopAnimation(effect_sequence_hulldamage);
		rand = math.random(200, 255);
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_randomflash, rand, 255, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_hulldamage, 12, animation_type_randomflash, rand, 255, 10, 1, 0)
		Animation.StartAnimation(effect_sequence_hulldamage, 13, animation_type_randomflash, rand, 255, 10, 1, 0)
		rand = math.random(180, 255);
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_randomflash, rand, 255, 10, 1, 3)
		Animation.StartAnimation(effect_sequence_hulldamage, 12, animation_type_randomflash, rand, 255, 10, 1, 3)
		Animation.StartAnimation(effect_sequence_hulldamage, 13, animation_type_randomflash, rand, 255, 10, 1, 3)
		rand = math.random(180, 255);
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_randomflash, rand, 255, 10, 1, 6)
		Animation.StartAnimation(effect_sequence_hulldamage, 12, animation_type_randomflash, rand, 255, 10, 1, 6)
		Animation.StartAnimation(effect_sequence_hulldamage, 13, animation_type_randomflash, rand, 255, 10, 1, 6)
		rand = math.random(180, 255);
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_randomflash, rand, 255, 10, 1, 9)
		Animation.StartAnimation(effect_sequence_hulldamage, 12, animation_type_randomflash, rand, 255, 10, 1, 9)
		Animation.StartAnimation(effect_sequence_hulldamage, 13, animation_type_randomflash, rand, 255, 10, 1, 9)
		rand = math.random(180, 255);
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_randomflash, rand, 255, 10, 1, 12)
		Animation.StartAnimation(effect_sequence_hulldamage, 12, animation_type_randomflash, rand, 255, 10, 1, 12)
		Animation.StartAnimation(effect_sequence_hulldamage, 13, animation_type_randomflash, rand, 255, 10, 1, 12)
		rand = math.random(180, 255);
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_randomflash, rand, 255, 10, 1, 15)
		Animation.StartAnimation(effect_sequence_hulldamage, 12, animation_type_randomflash, rand, 255, 10, 1, 15)
		Animation.StartAnimation(effect_sequence_hulldamage, 13, animation_type_randomflash, rand, 255, 10, 1, 15)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 20)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 40)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 60)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 80)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 100)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 120)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 140)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 160)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 180)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 200)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 220)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 240)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 260)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 280)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 300)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 320)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 340)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 360)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 255, 0, 0, 1, 380)
		Animation.StartAnimation(effect_sequence_hulldamage, 11, animation_type_fixedvalue, 0, 0, 0, 1, 400)
	end
	if (json.event == "Interdicted") then
		Animation.StopAnimation(effect_sequence_interdicted);
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 20)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 40)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 60)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 80)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 100)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 120)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 140)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 160)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 180)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 200)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 220)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 240)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 260)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 280)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 300)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 320)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 340)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 360)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 255, 0, 0, 1, 380)
		Animation.StartAnimation(effect_sequence_interdicted, 11, animation_type_fixedvalue, 0, 0, 0, 1, 400)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 20)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 40)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 60)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 80)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 100)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 120)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 140)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 160)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 180)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 200)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 220)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 240)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 260)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 280)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 300)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 320)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 340)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 360)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 255, 0, 0, 1, 380)
		Animation.StartAnimation(effect_sequence_interdicted, 12, animation_type_fixedvalue, 0, 0, 0, 1, 400)
	end

end


