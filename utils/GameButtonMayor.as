﻿package earthscope.utils{			import flash.display.Sprite;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.StyleSheet;	import flash.events.MouseEvent;	import flash.text.TextFieldAutoSize;	import flash.display.Shape;	import flash.filters.DropShadowFilter;	import flash.geom.ColorTransform;	import earthscope.text.GameText;	import flash.text.Font;	import flash.text.AntiAliasType;	import earthscope.utils.DisplayGraphicsFiles;			public class GameButtonMayor extends Sprite{								var _button:Sprite = new Sprite();		var _label:TextField = new TextField();		var _box:Shape = new Shape();		var format:TextFormat = new TextFormat();		var _disabled:Boolean = false;		var myFont:Font = new cancan();		var _back:DisplayGraphicsFiles;				public function GameButtonMayor(x:int = 0, y:int = 0, width:int = 100, height:int = 50, label:String = "Label"){									  						trace("Creating new GameButton");									_label.text = label;			formatText(x, y, width, height, label, _label, GameText.WHITE);									 with (_button.graphics) {                               beginFill(0x7653AC, 0.0);                drawRect(x,  y, width, height );                endFill();            }										_button.buttonMode = true;			_button.useHandCursor = true;			_button.mouseChildren = false;						addChild(_button);			_button.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);			_button.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);			_label.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);			_label.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);						_button.addChild(_label);									//_label.embedFonts = true;								}				public function set disabled(val:Boolean):void{						_disabled = val;						if(_disabled){								onDisabled();			}			else{								onEnabled();			}		}				public function get disabled():Boolean{						return _disabled ;		}					public function set label(val:String):void{						_label.text = val;		}				protected function formatText(x:int, y:int, width:int, height:int, value:String, textf:TextField, color:Object, hover:Boolean = false){						format = new TextFormat();			format.font = myFont.fontName;			format.size = 50;			format.color = GameText.WHITE;			format.leading = 5;			textf.x = x;			textf.y = y;			textf.autoSize = TextFieldAutoSize.LEFT;			textf.selectable = false;			textf.defaultTextFormat = format;				textf.text = value;			textf.embedFonts = true;			textf.antiAliasType = AntiAliasType.ADVANCED;			//textf.border = true;						textf.filters = null;			textf.text = value;												}				private function onDisabled(){						if(_disabled){				 format.color = GameText.TAN;				_label.setTextFormat(format);					_label.filters = null;			}							}				private function onEnabled():void{						format.color = GameText.WHITE;			_label.setTextFormat(format);				_label.filters = null;								}				public function onMouseOver(MouseEvent):void{						if(_disabled){								return;			}						trace("onMouseOver");							var drop:DropShadowFilter = new DropShadowFilter();			var _filters:Array = [drop];			drop.color = 0x000000;			_label.filters = _filters;							 format.color = 0x993300;			_label.setTextFormat(format);						}				public function onMouseOut(MouseEvent):void{						if(_disabled){								return;			}						trace("onMouseOut");			format.color = GameText.WHITE;			_label.setTextFormat(format);				//_label.x -= 1;			//_label.y -= 1;						_label.filters = null;					}						   									}							}