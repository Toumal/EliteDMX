EliteDMX Light and Effects Control
==================================

What is it?
-----------

This is a small program that allows you to define light effects via a USB to DMX interface, which are triggered by events in the game Elite Dangerous. You can control RGB lights, smoke machines, even laser effects - any stage or studio effect device compatible with the DMX protocol works.

[![EliteDMX v0.1 Damage events test](http://i.imgur.com/WFUpJfL.jpg)](http://www.youtube.com/watch?v=1qs1zQLBQjE "EliteDMX v0.1 Damage events test")


What do I need to use this?
---------------------------

This is using OpenDMX and should run with any DMX512-compatible USB-to-DMX interface. If you don't have one yet, searching ebay for "USB DMX512" usually gets you one for under 20 USD. You'll also need one or more DMX-controlled stage effects. A cheap DMX-compatible RGB LED light can be found on ebay or amazon for 30 USD these days. You also need a DMX cable (three pin connector), and if you have a lot of DMX devices chained together, a DMX terminator.
But the smallest setup is just a USB interface and a LED light. In a more complete setup you might include laser effects, strobes, and even smoke machines.

If you have a Velleman VM116 DMX interface, this program should work too as long as you have their DMX test software running in the background.

Oh and you need Elite Dangerous 2.2 or higher. The non-Horizons version (>=1.7) works too.


Installation
------------

Simply unzip the release into a directory of your choice, and run EliteDMX.exe
The software will auto-detect your USB-DMX interface as well as your game's log file directory.


How do I use this?
------------------

Set your RGB light to channel 11. Start EliteDMX. Start Elite Dangerous. Play the game and try flying close to a star until heat rises above 100%, or get into a fight and suffer more than 20% hull damage.


Scripting
---------
Check effects.lua for all your scripting needs. The default script comes with some game events configured for one or more RGB lights set to DMX channel 11/12/13 for the R/G/B values respectively. On most RGB lights, setting the device to channel 11 will do the trick since the first configured channel is usually the red value. You can use as many devices on the same channel(s) as you like, and they'll all behave the same.

The supplied effects.lua is set up to use one set of lights on channels 11/12/13 for ship status and alerts, another set of lights on channels 14/15/16 for damage effects, flashes, etc - and if you're adventurous, there's hull damage effects configured to enable channel 1 for a short time which can be used for smoke machines or even pyrotechnics.

The effect of various commands on various channels, and how many channels a device uses, depends on the device itself. Check the manual of your DMX device for more information on this.
If you want to test your stuff you can directly send values to any DMX channel using the program's UI.

To script light animations use the following command:

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



Any known issues?
-----------------

Since this is an alpha release not all effect transition types are implemented yet - ATM setting a fixed value, ramp-up, ramp-down and randomizeflash are supported. Some usage examples can be found in the effects.lua file.


I have opinions!
----------------

That's great! You can send them to toumaltheorca@gmail.com



