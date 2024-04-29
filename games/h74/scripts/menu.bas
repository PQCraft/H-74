' read config
menubg = cfgvar("H-74", "menubg", "menubg")

bg = -1

sub menu
    ' load map as background if enabled
    bgrc = loadresource(image, menubg)
    if bgrc >= 0
        scrsz = screensize()
        rcsz = resourceinfo(bgrc, size)
        mul = scrsz[0] / rcsz[0]
        bg = ui(create image, rc menubg, size int[](scrsz[0], rcsz[1] * mul), z -1
        del scrsz, rcsz, mul
        freeresource bgrc
    endif
end
