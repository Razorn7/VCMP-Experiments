GUI.rawset("ReceiveColorFromPalette", function(colour) { return colour; });

_colorPalette <- {	
};

_colorPalette.struct <- {
	element = []
}

_colorPalette.variables <- {
	ticks = (Script.GetTicks() + 1000),
	
	pressedRight = false,
	pressedLeft = false,
	
	ID = -1
};

_colorPalette.functions <- {
	hookPaletteColorOnClick = function(element) {
		foreach (id, e in _colorPalette.struct.element) {
			foreach (i, e in _colorPalette.struct.element[id].Colors) {
				if (element == _colorPalette.struct.element[id].Colors[i]) {
					GUI.ReceiveColorFromPalette(element.Colour);
				}
			}
			if (element == _colorPalette.struct.element[id].ToLeft) {
				::_colorPalette.variables.ID = id;
				::_colorPalette.variables.pressedLeft = true;
			}
			if (element == _colorPalette.struct.element[id].ToRight) {
				::_colorPalette.variables.ID = id;
				::_colorPalette.variables.pressedRight = true;
			}
		}
	},
	
	hookPaletteColorOnRelease = function(element) {
		foreach (id, e in _colorPalette.struct.element) {
			foreach (i, e in _colorPalette.struct.element[id].Colors) {
				if (element == _colorPalette.struct.element[id].ToLeft) {
					::_colorPalette.variables.ID = -1;
					::_colorPalette.variables.pressedLeft = false;
				}
				if (element == _colorPalette.struct.element[id].ToRight) {
					::_colorPalette.variables.ID = -1;
					::_colorPalette.variables.pressedRight = false;
				}
			}
		}
	}
	
	updatePalette = function(id) {
		local bW = _colorPalette.struct.element[id].Canvas.Size.X, 
		bH = _colorPalette.struct.element[id].Canvas.Size.Y, 
		value = _colorPalette.struct.element[id].state, 
		c = Colour(_colorPalette.struct.element[id].rgb.R, _colorPalette.struct.element[id].rgb.G, _colorPalette.struct.element[id].rgb.B),
		e = ((_colorPalette.struct.element[id].state * (_colorPalette.struct.element[id].Canvas.Size.X * 0.0013)));
			
		_colorPalette.struct.element[id].Sprite.Size = VectorScreen(bW * 0.97, bH * 0.12);
		_colorPalette.struct.element[id].Sprite.Pos = VectorScreen(bW * 0.02, bH * 0.853);
		_colorPalette.struct.element[id].Selection.Size = VectorScreen(bW * 0.03, bH * 0.118);
		_colorPalette.struct.element[id].ToLeft.Size = VectorScreen(bW * 0.03, bH * 0.117);
		_colorPalette.struct.element[id].ToRight.Size = VectorScreen(bW * 0.03, bH * 0.117);
		_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Sprite);
		_colorPalette.struct.element[id].Sprite.Colour = Colour(255, 255, 255, 255);
		_colorPalette.struct.element[id].ToRight.Pos.X = _colorPalette.struct.element[id].Canvas.Size.X * 0.94;
		_colorPalette.struct.element[id].Selection.Pos.X = ((e * 2 / 4)) - _colorPalette.struct.element[id].Sprite.Size.X * 0.003;
		
			
		for (local i = 0, gradient = 14; i <= 14; i++) {
			if (_colorPalette.struct.element[id].Colors[i] == null) {
				_colorPalette.struct.element[id].Colors[i] = GUIButton(); 
				_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Colors[i]);
				_colorPalette.struct.element[id].Colors[i].RemoveFlags(GUI_FLAG_BORDER);
			}
			_colorPalette.struct.element[id].Colors[i].Pos = VectorScreen(bW * 0.02, bH * 0.023);
			_colorPalette.struct.element[id].Colors[i].Size = VectorScreen(bW * 0.0646, bH * 0.1);
			_colorPalette.struct.element[id].Colors[i].Colour = Colour(255, 255, 255);
			
			
			if (i > 0 && i <= 14) {
				_colorPalette.struct.element[id].Colors[i].Colour.R = 255 * gradient/15;
				_colorPalette.struct.element[id].Colors[i].Colour.G = 255 * gradient/15;
				_colorPalette.struct.element[id].Colors[i].Colour.B = 255 * gradient/15;
				_colorPalette.struct.element[id].Colors[i].Pos.X = _colorPalette.struct.element[id].Colors[i-1].Pos.X + bW * 0.0654;
				gradient --;
			}
		}
		for (local i = 15, gradient = 14; i <= (14 * 2 + 1); i++) {
			if (_colorPalette.struct.element[id].Colors[i] == null) {
				_colorPalette.struct.element[id].Colors[i] = GUIButton(); 
				_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Colors[i]);
				_colorPalette.struct.element[id].Colors[i].RemoveFlags(GUI_FLAG_BORDER);
			}
			_colorPalette.struct.element[id].Colors[i].Pos = VectorScreen(bW * 0.02, bH * 0.12);
			_colorPalette.struct.element[id].Colors[i].Size = VectorScreen(bW * 0.0646, bH * 0.1);
			_colorPalette.struct.element[id].Colors[i].Colour = Colour(255, 255, 255);
				
			if (i >= 15 && i <= (14 * 2 + 1)) {
				_colorPalette.struct.element[id].Colors[i].Colour.R = c.R * gradient/15;
				_colorPalette.struct.element[id].Colors[i].Colour.G = c.G * gradient/15;
				_colorPalette.struct.element[id].Colors[i].Colour.B = c.B * gradient/15;
				if (i > 15) _colorPalette.struct.element[id].Colors[i].Pos.X = _colorPalette.struct.element[id].Colors[i-1].Pos.X + bW * 0.0654;
				gradient --;
			}
			

		}
		for (local i = 30, gradient = 14; i <= (14 * 3 + 2); i++) {
			if (_colorPalette.struct.element[id].Colors[i] == null) {
				_colorPalette.struct.element[id].Colors[i] = GUIButton(); 
				_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Colors[i]);
				_colorPalette.struct.element[id].Colors[i].RemoveFlags(GUI_FLAG_BORDER);
			}
			_colorPalette.struct.element[id].Colors[i].Pos = VectorScreen(bW * 0.02, bH * 0.22);
			_colorPalette.struct.element[id].Colors[i].Size = VectorScreen(bW * 0.0646, bH * 0.1);
			_colorPalette.struct.element[id].Colors[i].Colour = Colour(255, 255, 255);
				
			if (i >= 30 && i <= (14 * 3 + 2)) {
				_colorPalette.struct.element[id].Colors[i].Colour.R = c.R * gradient/16;
				_colorPalette.struct.element[id].Colors[i].Colour.G = c.G * gradient/16;
				_colorPalette.struct.element[id].Colors[i].Colour.B = c.B * gradient/16;
				if (i > 30) _colorPalette.struct.element[id].Colors[i].Pos.X = _colorPalette.struct.element[id].Colors[i-1].Pos.X + bW * 0.0654;
				gradient --;
			}
		}
		for (local i = 45, gradient = 14; i <= (14 * 4 + 3); i++) {  
			if (_colorPalette.struct.element[id].Colors[i] == null) {
				_colorPalette.struct.element[id].Colors[i] = GUIButton(); 
				_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Colors[i]);
				_colorPalette.struct.element[id].Colors[i].RemoveFlags(GUI_FLAG_BORDER);
			}
			_colorPalette.struct.element[id].Colors[i].Pos = VectorScreen(bW * 0.02, bH * 0.32);
			_colorPalette.struct.element[id].Colors[i].Size = VectorScreen(bW * 0.0646, bH * 0.1);
			_colorPalette.struct.element[id].Colors[i].Colour = Colour(255, 255, 255);

			if (i >= 45 && i <= (14 * 4 + 3)) {
				_colorPalette.struct.element[id].Colors[i].Colour.R = c.R * gradient/17;
				_colorPalette.struct.element[id].Colors[i].Colour.G = c.G * gradient/17;
				_colorPalette.struct.element[id].Colors[i].Colour.B = c.B * gradient/17;
				if (i > 45) _colorPalette.struct.element[id].Colors[i].Pos.X = _colorPalette.struct.element[id].Colors[i-1].Pos.X + bW * 0.0654;
				gradient --;
			}	
		}
		for (local i = 60, gradient = 14; i <= (14 * 5 + 4); i++) {
			if (_colorPalette.struct.element[id].Colors[i] == null) {
				_colorPalette.struct.element[id].Colors[i] = GUIButton(); 
				_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Colors[i]);
				_colorPalette.struct.element[id].Colors[i].RemoveFlags(GUI_FLAG_BORDER);
			}
			_colorPalette.struct.element[id].Colors[i].Pos = VectorScreen(bW * 0.02, bH * 0.42);
			_colorPalette.struct.element[id].Colors[i].Size = VectorScreen(bW * 0.0646, bH * 0.1);
			_colorPalette.struct.element[id].Colors[i].Colour = Colour(255, 255, 255);
				
			if (i >= 60 && i <= (14 * 5 + 4)) {
				_colorPalette.struct.element[id].Colors[i].Colour.R = c.R * gradient/18;
				_colorPalette.struct.element[id].Colors[i].Colour.G = c.G * gradient/18;
				_colorPalette.struct.element[id].Colors[i].Colour.B = c.B * gradient/18;
				if (i > 60) _colorPalette.struct.element[id].Colors[i].Pos.X = _colorPalette.struct.element[id].Colors[i-1].Pos.X + bW * 0.0654;
				gradient --;
			}
		}
		for (local i = 75, gradient = 14; i <= (14 * 6 + 5); i++) {
			if (_colorPalette.struct.element[id].Colors[i] == null) {
				_colorPalette.struct.element[id].Colors[i] = GUIButton(); 
				_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Colors[i]);
				_colorPalette.struct.element[id].Colors[i].RemoveFlags(GUI_FLAG_BORDER);
			}
			_colorPalette.struct.element[id].Colors[i].Pos = VectorScreen(bW * 0.02, bH * 0.52);
			_colorPalette.struct.element[id].Colors[i].Size = VectorScreen(bW * 0.0646, bH * 0.1);
			_colorPalette.struct.element[id].Colors[i].Colour = Colour(255, 255, 255);
			
			if (i >= 75 && i <= (14 * 6 + 5)) {
				_colorPalette.struct.element[id].Colors[i].Colour.R = c.R * gradient/19;
				_colorPalette.struct.element[id].Colors[i].Colour.G = c.G * gradient/19;
				_colorPalette.struct.element[id].Colors[i].Colour.B = c.B * gradient/19;
				if (i > 75) _colorPalette.struct.element[id].Colors[i].Pos.X = _colorPalette.struct.element[id].Colors[i-1].Pos.X + bW * 0.0654;
				gradient --;
			}
		}
		for (local i = 90, gradient = 14; i <= (14 * 7 + 6); i++) {
			if (_colorPalette.struct.element[id].Colors[i] == null) {
				_colorPalette.struct.element[id].Colors[i] = GUIButton(); 
				_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Colors[i]);
				_colorPalette.struct.element[id].Colors[i].RemoveFlags(GUI_FLAG_BORDER);
			}
			_colorPalette.struct.element[id].Colors[i].Pos = VectorScreen(bW * 0.02, bH * 0.62);
			_colorPalette.struct.element[id].Colors[i].Size = VectorScreen(bW * 0.0646, bH * 0.1);
			_colorPalette.struct.element[id].Colors[i].Colour = Colour(255, 255, 255, 255);
				
			if (i >= 90 && i <= (14 * 7 + 6)) {
				_colorPalette.struct.element[id].Colors[i].Colour.R = c.R * gradient/20;
				_colorPalette.struct.element[id].Colors[i].Colour.G = c.G * gradient/20;
				_colorPalette.struct.element[id].Colors[i].Colour.B = c.B * gradient/20;
				if (i > 90) _colorPalette.struct.element[id].Colors[i].Pos.X = _colorPalette.struct.element[id].Colors[i-1].Pos.X + bW * 0.0654;
				gradient --;
			}
		}
		for (local i = 105, gradient = 14; i <= (14 * 8 + 7); i++) {
			if (_colorPalette.struct.element[id].Colors[i] == null) {
				_colorPalette.struct.element[id].Colors[i] = GUIButton(); 
				_colorPalette.struct.element[id].Canvas.AddChild(_colorPalette.struct.element[id].Colors[i]);
				_colorPalette.struct.element[id].Colors[i].RemoveFlags(GUI_FLAG_BORDER);
			}
			_colorPalette.struct.element[id].Colors[i].Pos = VectorScreen(bW * 0.02, bH * 0.72);
			_colorPalette.struct.element[id].Colors[i].Size = VectorScreen(bW * 0.0646, bH * 0.1);
			_colorPalette.struct.element[id].Colors[i].Colour = Colour(255, 255, 255);
				
			if (i >= 105 && i <= (14 * 8 + 7)) {
				_colorPalette.struct.element[id].Colors[i].Colour.R = c.R * gradient/21;
				_colorPalette.struct.element[id].Colors[i].Colour.G = c.G * gradient/21;
				_colorPalette.struct.element[id].Colors[i].Colour.B = c.B * gradient/21;
				if (i > 105) _colorPalette.struct.element[id].Colors[i].Pos.X = _colorPalette.struct.element[id].Colors[i-1].Pos.X + bW * 0.0654;
				gradient --;
			}
		}
	}

	returnRGBfromPalette = function(option, id) {
		local rgb,
		e = ((_colorPalette.struct.element[id].state * (_colorPalette.struct.element[id].Canvas.Size.X * 0.0013))),
		ammount = 1;
		
		switch (option) {
			case "+":
			if (_colorPalette.struct.element[id].r == 255 && _colorPalette.struct.element[id].b == 0) {
				::_colorPalette.struct.element[id].g+= ammount;
			}
			if (_colorPalette.struct.element[id].g == 255 && _colorPalette.struct.element[id].b == 0) {
				::_colorPalette.struct.element[id].r-= ammount;
			}
			if (_colorPalette.struct.element[id].r == 0 && _colorPalette.struct.element[id].g == 255) {
				::_colorPalette.struct.element[id].b+= ammount;
			}
			if (_colorPalette.struct.element[id].r == 0 && _colorPalette.struct.element[id].b == 255) {
				::_colorPalette.struct.element[id].g-= ammount;
			}
			if (_colorPalette.struct.element[id].b == 255 && _colorPalette.struct.element[id].g == 0) {
				::_colorPalette.struct.element[id].r+= ammount;
			}
			if (_colorPalette.struct.element[id].r == 255 && _colorPalette.struct.element[id].g == 0) {
				::_colorPalette.struct.element[id].b-= ammount;
			}
			::_colorPalette.struct.element[id].state += ammount;
			break;
			case "-":
			if (_colorPalette.struct.element[id].r == 255 && _colorPalette.struct.element[id].b == 0) {
				::_colorPalette.struct.element[id].g-= ammount;
			}
			if (_colorPalette.struct.element[id].g == 255 && _colorPalette.struct.element[id].b == 0) {
				::_colorPalette.struct.element[id].r+= ammount;
			}
			if (_colorPalette.struct.element[id].r == 0 && _colorPalette.struct.element[id].g == 255) {
				::_colorPalette.struct.element[id].b-= ammount;
			}
			if (_colorPalette.struct.element[id].r == 0 && _colorPalette.struct.element[id].b == 255) {
				::_colorPalette.struct.element[id].g+= ammount;
			}
			if (_colorPalette.struct.element[id].b == 255 && _colorPalette.struct.element[id].g == 0) {
				::_colorPalette.struct.element[id].r-= ammount;
			}
			if (_colorPalette.struct.element[id].r == 255 && _colorPalette.struct.element[id].g == 0) {
				::_colorPalette.struct.element[id].b+= ammount;
			}
			::_colorPalette.struct.element[id].state -= ammount;
			break;
		}
		
		rgb = Colour(_colorPalette.struct.element[id].r, _colorPalette.struct.element[id].g, _colorPalette.struct.element[id].b);
		_colorPalette.struct.element[id].Selection.Pos.X = ((e * 2 / 4)) - _colorPalette.struct.element[id].Sprite.Size.X * 0.003;

		return rgb;
	}

	move = function(side, id) {
		for (local i = 0; i <= 5; i++) {
			if (_colorPalette.struct.element[id].state <= 0 || _colorPalette.struct.element[id].state <= 49) {
				::_colorPalette.variables.pressedLeft = false;
				::_colorPalette.struct.element[id].state = 50;
			}
			else if (_colorPalette.struct.element[id].state >= 1410) {
				::_colorPalette.variables.pressedRight = false;
				::_colorPalette.struct.element[id].state = 1409;
			}
			else if (_colorPalette.struct.element[id].state >= 49 && _colorPalette.struct.element[id].state < 1410) {
				::_colorPalette.struct.element[id].rgb = this.returnRGBfromPalette(side, id); 
				this.updatePalette(id);
			}
		}
	}
	
	processPalette = function() {
		if (_colorPalette.struct.element.len() > 0) {
			if (_colorPalette.variables.pressedLeft == true) {
				local id = _colorPalette.variables.ID;
				this.move("-", id);
			}
			if (_colorPalette.variables.pressedRight == true) {
				local id = _colorPalette.variables.ID;
				this.move("+", id);
			}
			if (Script.GetTicks() > _colorPalette.variables.ticks) {
				foreach (id, e in _colorPalette.struct.element) {
					this.updatePalette(id);
				}
				
				::_colorPalette.variables.ticks = Script.GetTicks() + 1000;
			}
		}
	}
}

GUIColorPalette <- function(pos = null, size = null, elementColour = null) {
	local id = _colorPalette.struct.element.len();
	if (pos == null) {
		pos = VectorScreen(0, 0);
		size = VectorScreen(0, 0);
		elementColour = Colour(0, 0, 0, 10);
	}
	else if (pos != null) {
		if (size == null) {
			throw "wrong number of parameters";
		}
		else {
			if (elementColour == null) elementColour = Colour(0, 0, 0, 10);
		}
	}
	
	_colorPalette.struct.element.push({
		rgb = null, 
		Canvas = null, 
		Sprite = null,
		Selection = null, 
		Colors = array((14 * 8 + 7) + 1, null), 
		ToLeft = null, 
		ToRight = null,
		r = 255,
		g = 0,
		b = 0,
		state = 0
	});
	
	_colorPalette.struct.element[id].Canvas = GUICanvas(); /* Background */
	_colorPalette.struct.element[id].Canvas.Colour = elementColour;
	_colorPalette.struct.element[id].Canvas.Size.X = size.X;
	_colorPalette.struct.element[id].Canvas.Size.Y = size.Y;
	_colorPalette.struct.element[id].Canvas.Pos.X = pos.X;
	_colorPalette.struct.element[id].Canvas.Pos.Y = pos.Y;
	
	_colorPalette.struct.element[id].Sprite = GUISprite(); /* Gradient Sprite */
	_colorPalette.struct.element[id].Sprite.SetTexture("colorPalette/gradient.png");
	_colorPalette.struct.element[id].Sprite.Colour = Colour(255, 255, 255, 255);
	
	_colorPalette.struct.element[id].Selection = GUICanvas(); /* Color level indicator */
	_colorPalette.struct.element[id].Selection.Colour = Colour(255, 255, 255, 255);
	
	_colorPalette.struct.element[id].Sprite.AddFlags(GUI_FLAG_MOUSECTRL);
	_colorPalette.struct.element[id].Sprite.AddChild(_colorPalette.struct.element[id].Selection);
	
	_colorPalette.struct.element[id].Sprite.Size.X = _colorPalette.struct.element[id].Canvas.Size.X * 0.1245;
	_colorPalette.struct.element[id].Sprite.Size.Y = _colorPalette.struct.element[id].Canvas.Size.Y * 0.02;
	_colorPalette.struct.element[id].Sprite.Pos.X = _colorPalette.struct.element[id].Canvas.Size.Y * 0.0029;
	_colorPalette.struct.element[id].Sprite.Pos.Y = _colorPalette.struct.element[id].Canvas.Size.X * 0.13;
	
	_colorPalette.struct.element[id].Selection.Size.X = _colorPalette.struct.element[id].Canvas.Size.X * 0.003;
	_colorPalette.struct.element[id].Selection.Size.Y =_colorPalette.struct.element[id].Canvas.Size.Y * 0.02;
	
	_colorPalette.struct.element[id].ToLeft = GUIButton(); /* Decrease level (left button) */
	_colorPalette.struct.element[id].ToLeft.Colour = Colour(200, 200, 200, 100);
	_colorPalette.struct.element[id].ToLeft.Pos.Y = _colorPalette.struct.element[id].Canvas.Size.Y * 0;
	_colorPalette.struct.element[id].ToLeft.Pos.X = _colorPalette.struct.element[id].Canvas.Size.X * 0;
	_colorPalette.struct.element[id].ToLeft.Size.X = _colorPalette.struct.element[id].Canvas.Size.X * 0.5;
	_colorPalette.struct.element[id].ToLeft.Size.Y = _colorPalette.struct.element[id].Canvas.Size.Y * 0.23;
	
	_colorPalette.struct.element[id].ToRight = GUIButton(); /* Increase level (right button) */
	_colorPalette.struct.element[id].ToRight.Colour = Colour(200, 200, 200, 100);
	_colorPalette.struct.element[id].ToRight.Pos.Y = _colorPalette.struct.element[id].Canvas.Size.Y * 0;
	_colorPalette.struct.element[id].ToRight.Pos.X = _colorPalette.struct.element[id].Canvas.Size.X * 0.94;
	_colorPalette.struct.element[id].ToRight.Size.X = _colorPalette.struct.element[id].Canvas.Size.X * 0.5;
	_colorPalette.struct.element[id].ToRight.Size.Y = _colorPalette.struct.element[id].Canvas.Size.Y * 0.23;
	
	_colorPalette.struct.element[id].Sprite.AddChild(_colorPalette.struct.element[id].ToRight);
	_colorPalette.struct.element[id].Sprite.AddChild(_colorPalette.struct.element[id].ToLeft);
	
    ::_colorPalette.struct.element[id].rgb == _colorPalette.functions.returnRGBfromPalette("+", id);
	_colorPalette.functions.move("+", id);
	
	return _colorPalette.struct.element[id].Canvas;
}
