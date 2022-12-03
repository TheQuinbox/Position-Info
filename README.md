# Position-Info

This is a simple Hammerspoon that lets you check your position in text fields and tables/lists.

## Instillation.

If you have Hammerspoon installed, simply open the .spoon file, and it should automatically go in the right spot.

To actually use the spoon, add the following two lines to your init.lua:

```lua
hs.loadSpoon("PositionInfo")
spoon.PositionInfo:start()
```

After this, control+shift+p will report your position when on a table or text field.

## Todo.

* Some apps, like the Finder, seem to report an extra row, for some reason. As such, when you're at the bottom of a finder list, and press control+shift+p, you aren't told you're at the bottom. I haven't figured out a cause for this yet.

## Credits.

* Mikolaj Holysz, for helping me with the code for getting your current position in a table.
