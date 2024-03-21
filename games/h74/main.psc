if (true && false); then
elif false; then
else
end

on ui:click
    fire "ui:click:$1"
end
ui.create box pos=0,0 size=0.5,0.5 color=blue | set BOX
ui.create button pos=0.25,0.25 size=0.2,0.1 text=Close | set CLOSE
on "ui:click:$CLOSE"
    ui.delete "$BOX" "$CLOSE"
    exit
end
sleep -inf
