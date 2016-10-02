EliteDMX Light and Effects Control
==================================

This program works with cheap and ubiquitous DMX512-compatible USB interfaces (Enttec, etc). It reads the new "player log" file created by Elite Dangerous v1.7/v2.2 and higher, and allows you to script various DMX effects for the events happening in the game. In the simplest form, it can be used to control one or more DMX-compatible RGB stage/studio lights (which can be found on Ebay for as little as $30, search for "LED PAR DMX").
In a more complete setup you might include laser effects, strobes, and even smoke machines.

[![EliteDMX v0.1 Damage events test](http://i.imgur.com/WFUpJfL.jpg)](http://www.youtube.com/watch?v=1qs1zQLBQjE "EliteDMX v0.1 Damage events test")

Installation
------------

Simply unzip the release into a directory of your choice, and run EliteDMX.exe
The software will auto-detect your USB-DMX interface as well as your game's log file directory.


Scripting
---------
EliteDMX comes preconfigured for a simple RGB light setup using DMX channel 11, 12 and 13. If you purchase a cheap ThinPAR RGB LED light, setting it to channel 11 is all you need to do. If you want to do more however, you can open effects.lua and script your own effects with the following LUA function call:

    Animation.StartAnimation(effectsequence, animationDmxChannel, animationType, startValue, endValue, stepValue, repeatCount, delay)

* animationDmxChannel is the channel ID of the effect you want to start. Use this to address different devices and/or functions of a device. For example, RGB lights typically use three channels for the three colors, a smoke machine has a channel that lets you switch smoke on (value 255) or off (value 0), etc.

* animationType is one of the following:

animation_type_fixedvalue = 0
animation_type_ramp_up = 1
animation_type_ramp_down = 2
animation_type_ramp_updown = 3
animation_type_randomize = 4
animation_type_flash = 5
animation_type_randomflash = 6

Currently, only fixedvalue, ramp_up, ramp_down and randomflash are implemented.

* startValue is the starting value for a ramping animations.

* endValue is the target value for a ramping animations, or the desired value for a fixedvalue animation type.

* stepValue defines the increment for ramping animations per time.

* repeatCount is 1 for a single shot animation, 0 for endless, or any value greater than 1 to loop that effect for that many times.

* delay is the time before the initial start of this animation. Use this to chain multiple effect animations after another.

* effectsequence is a numerical ID you can set yourself, which is used for the following call to stop a DMX effect (useful for looping/repeating effects):

    Animation.StopAnimation(effectsequence)

