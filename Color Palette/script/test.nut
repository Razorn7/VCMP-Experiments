dofile("colorPalette/main.nut");

myColorPalette <- GUIColorPalette();
myColorPalette.Pos = VectorScreen(500, 400);
myColorPalette.Colour = Colour(0, 0, 0, 100);
myColorPalette.Size = VectorScreen(200, 140);

GUI.SetMouseEnabled(true);

RGBtoHex <- function(r, g, b) { 
	return format("#%02x%02x%02x", r, g, b);
}

function Script::ScriptProcess() {
	_colorPalette.functions.processPalette();
}

function GUI::ElementClick(element, mouseX, mouseY) {
	_colorPalette.functions.hookPaletteColorOnClick(element);
}

function GUI::ElementRelease(element, mouseX, mouseY) {
	_colorPalette.functions.hookPaletteColorOnRelease(element);
}

function GUI::ReceiveColorFromPalette(colour) {
	local color = "[" + RGBtoHex(colour.R, colour.G, colour.B) + "]";
	Console.Print(color + "\f - " + "RGB([#ffffff]" + colour.R + ", " + colour.G + ", " + colour.B + color + ")\n\f - HEX: [#ffffff]" + color.slice(1, 8));
}
