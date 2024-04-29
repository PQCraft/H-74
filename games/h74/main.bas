if !module(server)
    ' set up action controls
    sub void setactioncontrols str name, str keys
        cfgset "actions", name, keys, false, true
    end
    if !platform(dreamcast)
        if !platform(emscr)
            gosub setactioncontrols "menu", "k,esc;g,b,start"
        else
            gosub setactioncontrols "menu", "k,backspace;g,b,start"
        end
        gosub setactioncontrols "fullscreen", "k,f11"
        gosub setactioncontrols "screenshot", "k,f2"
        gosub setactioncontrols "move_forwards", "k,w;g,a,-lefty"
        gosub setactioncontrols "move_backwards", "k,s;g,a,+lefty"
        gosub setactioncontrols "move_left", "k,a;g,a,-leftx"
        gosub setactioncontrols "move_right", "k,d;g,a,+leftx"
        gosub setactioncontrols "look_up", "m,m,+y;k,up;g,a,-righty"
        gosub setactioncontrols "look_down", "m,m,-y;k,down;g,a,+righty"
        gosub setactioncontrols "look_left", "m,m,-x;k,left;g,a,-rightx"
        gosub setactioncontrols "look_right", "m,m,+x;k,right;g,a,+rightx"
        gosub setactioncontrols "walk", "k,lctrl"
        gosub setactioncontrols "run", ""
        gosub setactioncontrols "jump", "k,space;g,b,a"
        gosub setactioncontrols "crouch", "k,lshift;g,b,leftstick"
        gosub setactioncontrols "fire", "m,b,l;g,a,+righttrigger"
        gosub setactioncontrols "altfire", "m,b,r;g,a,+lefttrigger"
        gosub setactioncontrols "use", "k,e;g,b,x"
        gosub setactioncontrols "chat", "k,t"
        gosub setactioncontrols "teamchat", "k,y"
        gosub setactioncontrols "inventory", "k,i;g,b,y"
        gosub setactioncontrols "scores", "k,f1"
        gosub setactioncontrols "fly", "k,l"
    else
        gosub setactioncontrols "menu", "g,b,start"
        gosub setactioncontrols "move_forwards", "g,b,y"
        gosub setactioncontrols "move_backwards", "g,b,a"
        gosub setactioncontrols "move_left", "g,b,x"
        gosub setactioncontrols "move_right", "g,b,b"
        gosub setactioncontrols "look_up", "g,a,-lefty"
        gosub setactioncontrols "look_down", "g,a,+lefty"
        gosub setactioncontrols "look_left", "g,a,-leftx"
        gosub setactioncontrols "look_right", "g,a,+leftx"
        gosub setactioncontrols "jump", "g,b,dpup"
        gosub setactioncontrols "crouch", "g,b,dpdown"
        gosub setactioncontrols "fire", "g,a,+righttrigger"
        gosub setactioncontrols "altfire", "g,a,+lefttrigger"
        gosub setactioncontrols "use", "g,b,dpleft"
        gosub setactioncontrols "hotbar", "g,b,dpleft"
    end
    delsub setactioncontrols
end

' set up actions
if module(server)
    sub void setaction str id, str name, str act
        setaction(id, name, act)
    end
else
    sub void setaction str id, str name, str act
        dim keys as local str
        keys = cfgget("Actions", id)
        setaction(id, name, act, keys)
    end
end
data str[][3] actions
    {"menu",            "Open Menu",            "menu"          },
    {"fullscreen",      "Toggle fullscreen",    "fullscreen"    },
    {"screenshot",      "Take screenshot",      "screenshot"    },
    {"move_forwards",   "Move forwards",        "move:+z"       },
    {"move_backwards",  "Move backwards",       "move:-z"       },
    {"move_left",       "Strafe left",          "move:-x"       },
    {"move_right",      "Strafe right",         "move:+x"       },
    {"look_up",         "Look up",              "look:+x"       },
    {"look_down",       "Look down",            "look:-x"       },
    {"look_left",       "Turn left",            "look:-y"       },
    {"look_right",      "Turn right",           "look:+y"       },
    {"walk",            "Walk",                 "walk"          },
    {"run",             "Run",                  "run"           },
    {"jump",            "Jump",                 "jump"          },
    {"crouch",          "Crouch",               "crouch"        },
    {"use",             "Use",                  "use"           },
    {"chat",            "Open chat",            "chat"          },
    {"teamchat",        "Open team chat",       "teamchat"      },
    {"voicechat",       "Voice chat",           "voicechat"     },
    {"teamvoicechat",   "Team voice chat",      "teamvoicechat" },
    {"inventory",       "Open inventory",       "custom:inv"    },
    {"scores",          "Show scores",          "custom:scores" },
    {"fly",             "Toggle fly",           "custom:fly"    },
    {"hotbar",          "Hotbar",               "custom:hotbar" }
end
al = len(actions)
for i = 0 until al
    gosub setaction actions[i][0], actions[i][1], actions[i][2]
end
del al
delsub setaction

if module(server)

    l = files(script, "scripts/server")
    ll = len(l)
    for i = 0 until ll
        start l[i]
    end

else

    l = files(script, "scripts/client")
    ll = len(l)
    for i = 0 until ll
        start l[i]
    end

    if module(client)

        dim splash as local

        ' show splash
        sub void tmp
            uidelete splash
            del splash
            delsub tmp
        end
        on "ui:splash:end" gosub tmp
        splash = uicreate(splash, image "splash", duration 3, fade 1, event "splash")
        sleep -1

        ' show menu
        run "scripts/menu"

    end

end
