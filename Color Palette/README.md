## Color Palette resource for Vice City Multiplayer (VC:MP)
A feature that allows the user to create a color palette on the client side.

### Setup
1. Clone the [repository](https://github.com/Razorn7/Color-Palette-for-Vice-City-Multiplayer/)
2. Open the repository and copy the available folders such as `script/` and `sprites/` to your server `store/` folder.
3. Load and start the script using `dofile("colorPalette/main.nut")` in your main script file.
4. Add the hooks to the `GUI::ElementClick`, `GUI::ElementRelease` and `Script::ScriptProcess` events to be like that:
- ```squirrel
  function GUI::ElementClick(element, mouseX, mouseY) {
    _colorPalette.functions.hookPaletteColorOnClick(element);
  }
  
- ```squirrel
  function GUI::ElementRelease(element, mouseX, mouseY) {
    _colorPalette.functions.hookPaletteColorOnRelease(element);
  }

- ```squirrel
  function Script::ScriptProcess() {
    _colorPalette.functions.processPalette();
  }
5. Have fun!

### Functions
- `GUIColorPalette()` - Used to create an GUI Element instance
  - `GUIColorPalette(VectorScreen Position, VectorScreen Size)`
  - `GUIColorPalette(VectorScreen Position, VectorScreen Size, Colour/RGBA BackgroundColor)`

### Events
- `GUI::ReceiveColorFromPalette(Colour/RGBA colour)` - This event is called when the user selects some color.

### Note
- `GUIColorPalette()` will return a GUICanvas element, then it can be children of another element (like a GUIWindow).
- May contain bugs and problems when specifying some size.
- You can't manage vehicle colors with this resource due to VC:MP limitations.

### Screenshots
![Image 1](https://i.imgur.com/h9hd1Uk.png)

### Example of usage
```squirrel
myColorPalette <- GUIColorPalette();
myColorPalette.Pos = VectorScreen(500, 400);
myColorPalette.Colour = Colour(0, 0, 0, 100);
myColorPalette.Size = VectorScreen(200, 140);

GUI.SetMouseEnabled(true);

RGBtoHex <- function(r, g, b) { 
	return format("#%02x%02x%02x", r, g, b);
}

function GUI::ReceiveColorFromPalette(colour) {
	local color = "[" + RGBtoHex(colour.R, colour.G, colour.B) + "]";
	Console.Print(color + "\f - " + "RGB([#ffffff]" + colour.R + ", " + colour.G + ", " + colour.B + color + ")\n\f - HEX: [#ffffff]" + color.slice(1, 8));
}
```
