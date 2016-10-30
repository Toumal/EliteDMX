
----------------------------------
EliteDMX v0.3 for Elite Dangerous
(c)2016 Playspoon
----------------------------------


What is it?
===========

This is a small program that allows you to define light effects via a USB to DMX interface, which are triggered by events in the game Elite Dangerous. You can control RGB lights, smoke machines, even laser effects - any stage or studio effect device compatible with the DMX protocol works.


What do I need to use this?
===========================

This is using OpenDMX and should run with any DMX512-compatible USB-to-DMX interface. If you don't have one yet, searching ebay for "USB DMX512" usually gets you one for under 20 USD. You'll also need one or more DMX-controlled stage effects. A cheap DMX-compatible RGB LED light can be found on ebay or amazon for 30 USD these days. You also need a DMX cable (three pin connector), and if you have a lot of DMX devices chained together, a DMX terminator.
But the smallest setup is just a USB interface and a LED light.

If you have a Velleman VM116 DMX interface, this program should work too as long as you have their DMX test software running in the background.

Oh and you need Elite Dangerous 2.2 or higher. The non-Horizons version (>=1.7) works too.


How do I use this?
============================

Set your RGB light to channel 11. Start EliteDMX. Start Elite Dangerous. Play the game and try flying close to a star until heat rises above 100%, or get into a fight and suffer more than 20% hull damage.


How do I configure my stuff?
============================

Check effects.lua for all your scripting needs. The default script comes with some game events configured for one or more RGB lights set to DMX channel 11/12/13 for the R/G/B values respectively. On most RGB lights, setting the device to channel 11 will do the trick since the first configured channel is usually the red value. You can use as many devices on the same channel(s) as you like, and they'll all behave the same.
The supplied effects.lua is set up to use one set of lights on channels 11/12/13 for ship status and alerts, another set of lights on channels 14/15/16 for damage effects, flashes, etc - and if you're adventurous, there's hull damage effects configured to enable channel 1 for a short time which can be used for smoke machines or even pyrotechnics.

The effect of various commands on various channels, and how many channels a device uses, depends on the device itself. Check the manual of your DMX device for more information on this.

If you want to test your stuff you can directly send values to any DMX channel using the program's UI.


Any known issues?
=================

Since this is an alpha release not all effect transition types are implemented yet - ATM setting a fixed value, ramp-up, ramp-down and randomizeflash are supported. Some usage examples can be found in the effects.lua file.


I have opinions!
================

That's great! You can send them to toumaltheorca@gmail.com



