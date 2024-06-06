' H-74 Bootstrap Script

#if module != module_server
    ' set up action controls
    sub void actcontrols str name, str keys
        cfgset "actions", name, keys, false, true
    end
    #if platform != plat_dreamcast
        #if platform != plat_emscr
            gosub actcontrols "menu", "k,esc;g,b,start"
        #else
            gosub actcontrols "menu", "k,backspace;g,b,start"
        #end
        gosub actcontrols "fullscreen", "k,f11"
        gosub actcontrols "screenshot", "k,f2"
        gosub actcontrols "move_forwards", "k,w;g,a,-lefty"
        gosub actcontrols "move_backwards", "k,s;g,a,+lefty"
        gosub actcontrols "move_left", "k,a;g,a,-leftx"
        gosub actcontrols "move_right", "k,d;g,a,+leftx"
        gosub actcontrols "look_up", "m,m,+y;k,up;g,a,-righty"
        gosub actcontrols "look_down", "m,m,-y;k,down;g,a,+righty"
        gosub actcontrols "look_left", "m,m,-x;k,left;g,a,-rightx"
        gosub actcontrols "look_right", "m,m,+x;k,right;g,a,+rightx"
        gosub actcontrols "walk", "k,lctrl"
        gosub actcontrols "run", ""
        gosub actcontrols "jump", "k,space;g,b,a"
        gosub actcontrols "crouch", "k,lshift;g,b,leftstick"
        gosub actcontrols "fire", "m,b,l;g,a,+righttrigger"
        gosub actcontrols "altfire", "m,b,r;g,a,+lefttrigger"
        gosub actcontrols "use", "k,e;g,b,x"
        gosub actcontrols "chat", "k,t"
        gosub actcontrols "teamchat", "k,y"
        gosub actcontrols "inventory", "k,i;g,b,y"
        gosub actcontrols "scores", "k,f1"
        gosub actcontrols "fly", "k,l"
    #else
        gosub actcontrols "menu", "g,b,start"
        gosub actcontrols "move_forwards", "g,b,y"
        gosub actcontrols "move_backwards", "g,b,a"
        gosub actcontrols "move_left", "g,b,x"
        gosub actcontrols "move_right", "g,b,b"
        gosub actcontrols "look_up", "g,a,-lefty"
        gosub actcontrols "look_down", "g,a,+lefty"
        gosub actcontrols "look_left", "g,a,-leftx"
        gosub actcontrols "look_right", "g,a,+leftx"
        gosub actcontrols "jump", "g,b,dpup"
        gosub actcontrols "crouch", "g,b,dpdown"
        gosub actcontrols "fire", "g,a,+righttrigger"
        gosub actcontrols "altfire", "g,a,+lefttrigger"
        gosub actcontrols "use", "g,b,dpleft"
        gosub actcontrols "hotbar", "g,b,dpleft"
    #end
    delsub actcontrols
#end

' set up actions
#if module == module_server
    sub void setaction str id, str name, str act
        setaction(id, name, act)
    end
#else
    sub void setaction str id, str name, str act
        dim keys as local str
        keys = cfgget("Actions", id)
        setaction(id, name, act, keys)
    end
#end
data str[][3] actions \
    {"menu",            "Open Menu",            "menu"          },\
    {"fullscreen",      "Toggle fullscreen",    "fullscreen"    },\
    {"screenshot",      "Take screenshot",      "screenshot"    },\
    {"move_forwards",   "Move forwards",        "move:+z"       },\
    {"move_backwards"   "Move backwards",       "move:-z"       },\
    {"move_left",       "Strafe left",          "move:-x"       },\
    {"move_right",      "Strafe right",         "move:+x"       },\
    {"look_up",         "Look up",              "look:+x"       },\
    {"look_down",       "Look down",            "look:-x"       },\
    {"look_left",       "Turn left",            "look:-y"       },\
    {"look_right",      "Turn right",           "look:+y"       },\
    {"walk",            "Walk",                 "walk"          },\
    {"run",             "Run",                  "run"           },\
    {"jump",            "Jump",                 "jump"          },\
    {"crouch",          "Crouch",               "crouch"        },\
    {"use",             "Use",                  "use"           },\
    {"chat",            "Open chat",            "chat"          },\
    {"teamchat",        "Open team chat",       "teamchat"      },\
    {"voicechat",       "Voice chat",           "voicechat"     },\
    {"teamvoicechat",   "Team voice chat",      "teamvoicechat" },\
    {"inventory",       "Open inventory",       "custom:inv"    },\
    {"scores",          "Show scores",          "custom:scores" },\
    {"fly",             "Toggle fly",           "custom:fly"    },\
    {"hotbar",          "Hotbar",               "custom:hotbar" }
al = len(actions)
for i = 0 until al
    gosub setaction actions[i][0], actions[i][1], actions[i][2]
end
del al
delsub setaction

#if module == module_server

    l = files(script, "scripts/server/")
    ll = len(l)
    for i = 0 until ll
        start l[i]
    end

#else

    #if module == module_client
        splash = ui(create image image "splash", width "100%", height "100%")
    #end

    l = files(script, "scripts/client/")
    ll = len(l)
    for i = 0 until ll
        start l[i]
    end

    #if module == module_client
        ui delete splash
        del splash
        start "scripts/menu"
    #end

#end
