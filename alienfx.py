#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk
import subprocess
import math

User = os.environ["USER"]

PWD = "/home/"+User+"/alienfx/"
Bash = PWD+"alienfx.sh"

def str2bool(v):
  return v.lower() in ("yes", "true", "t", "1")

def LoadConfig(Name):
   FileConf = os.popen(Bash+" get "+str(Name))
   Conf = FileConf.read().strip()
   FileConf.close()
   Values = Conf.split(",")
   Values.pop(0)
   return Values

def LoadBrightness(Name):
   FileConf = os.popen(Bash+" get "+str(Name))
   Conf = FileConf.read().strip()
   FileConf.close()
   Value = Conf.split(" ")
   return Value[1]

Config = {"alien":[],
          "steam":[],
          "brightness":""}

Config["alien"] = LoadConfig("alien")
Config["steam"] = LoadConfig("steam")
Config["brightness"] = LoadBrightness("brightness")

alien_red = float(Config["alien"][0])
alien_green = float(Config["alien"][1])
alien_blue = float(Config["alien"][2])
#alien_pulse = Config["alien"][3]

steam_red = float(Config["steam"][0])
steam_green = float(Config["steam"][1])
steam_blue = float(Config["steam"][2])
#steam_pulse = Config["steam"][3]

brightness = float(Config["brightness"])

class Handler:
    def apply_settings(self, button):
      AlienConf = "alien,"+str(int(alien_red))+","+str(int(alien_green))+","+str(int(alien_blue))+","+str(False)
      SteamConf = "steam,"+str(int(steam_red))+","+str(int(steam_green))+","+str(int(steam_blue))+","+str(False)
      BrightnessConf = "brightness,"+str(int(brightness))
      os.system(Bash+" set "+AlienConf+" "+SteamConf+" "+BrightnessConf)
      os.system(Bash+" begin")

    def alien_color_cb(self, button):
      color = button.get_rgba()

      global alien_red
      alien_red = round(color.red*15)
      #print(str(alien_red)+" red")

      global alien_green
      alien_green = round(color.green*15)
      #print(str(alien_green)+" green")

      global alien_blue
      alien_blue = round(color.blue*15)
      #print(str(alien_blue)+" blue")

    def steam_color_cb(self, button):
      color = button.get_rgba()

      global steam_red
      steam_red = round(color.red*15)
      #print(str(steam_red)+" red")

      global steam_green
      steam_green = int(round(color.green*15))
      #print(str(steam_green)+" green")

      global steam_blue
      steam_blue = round(color.blue*15)
      #print(str(steam_blue)+" blue")

    def steam_pulse_toggled_cb(self, button):
      global steam_pulse
      steam_pulse = button.get_active()
      #print("pulse steam "+str(steam_pulse))
    def alien_pulse_toggled_cb(self, button):
      global alien_pulse
      alien_pulse = button.get_active()
      #print("pulse alien "+str(alien_pulse))

    def brightness_cb(self, button, brightness_adj):
      global brightness
      brightness = button.get_value()
      #print("brightness "+str(brightness))

builder = Gtk.Builder()
builder.add_from_file(PWD+"AlienwareFX(custom).glade")
builder.connect_signals(Handler())

window_m = builder.get_object("window1")

alien = builder.get_object("alien_color")
alien.set_rgba(Gdk.RGBA(alien_red/15,alien_green/15,alien_blue/15))

steam = builder.get_object("steam_color")
steam.set_rgba(Gdk.RGBA(steam_red/15,steam_green/15,steam_blue/15))

brightness_slide = builder.get_object("brightness_slide")
brightness_slide.set_value(brightness)

#steam_p = builder.get_object("steam_pulse")
#steam_p.set_active(str2bool(steam_pulse))

#alien_p = builder.get_object("alien_pulse")
#alien_p.set_active(str2bool(alien_pulse))

window_m.connect("destroy", Gtk.main_quit)

#window_m.override_background_color(Gtk.StateType.NORMAL, Gdk.RGBA(0,0,0))

window_m.show_all()
Gtk.main()
