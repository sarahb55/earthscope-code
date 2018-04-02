﻿package earthscope.utils {        //Imports    import flash.display.Shape;    import flash.display.Sprite;    import flash.geom.Rectangle;    import flash.events.MouseEvent;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;    import flash.text.TextFormat;	import flash.ui.Mouse;	import flash.filters.BevelFilter;	import flash.filters.BitmapFilterQuality;	import flash.filters.BitmapFilterType;	import flash.net.URLRequest;        //Class    public class AlertBox extends Sprite {                //Vars        protected var _box:Shape;        protected var _yesBtn:Sprite;		protected var _noBtn:Sprite;		protected var _cancelBtn:Sprite;		protected var _textMessage:TextField;		protected var _textYes:TextField;		protected var _textNo:TextField;		protected var _textCancel:TextField;		protected var _padding:Number;		protected var _btnHeight:Number;		protected var _btnWidth:Number;		protected var _clickedYes:Boolean = false;		protected var _clickedNo:Boolean = false;		protected var _clickedCancel:Boolean = false;		protected var _clicked = false;				                //Constructor        public function AlertBox(rect:Rectangle, message:String="Message", textYes:String="Yes", textNo:String="No", textCancel:String="Cancel", padding:Number=4):void {                        //Initialise            _box = new Shape();            _yesBtn = new Sprite();						configureButton(_yesBtn);			_noBtn = new Sprite();			_cancelBtn = new Sprite();						_textYes = new TextField();			_textNo = new TextField();			_textCancel = new TextField();			_textMessage = new TextField();								_padding = padding;			_btnHeight = rect.height/12;			_btnWidth = rect.width/3 - 2*_padding;			            //Render			var y:Number = rect.height + rect.y  - _btnHeight - _padding;            with (_box.graphics) {                lineStyle(2, 0x7653AC);                beginFill(0xAA55AA, 1);                drawRect(rect.x, rect.y, rect.width, rect.height);                endFill();            }                        with (_yesBtn.graphics) {                lineStyle(1, 0x7653AC);                beginFill(0x7653AC, 1.0);                drawRect(_padding + rect.x,  y, _btnWidth, _btnHeight );                endFill();            }												with (_noBtn.graphics) {                lineStyle(1, 0x6D28D7);                beginFill(0x6D28D7, 1.0);                drawRect(rect.x + _btnWidth + 3*_padding,  y , _btnWidth, _btnHeight );                endFill();            }						with (_cancelBtn.graphics) {                lineStyle(1, 0x3181CE);                beginFill(0x3181CE, 1.0);                drawRect(rect.x + 2*rect.width/3 + _padding,  y, _btnWidth, _btnHeight );                endFill();            }									formatText(_padding + rect.x,  y + _btnHeight/8, _btnWidth, _btnHeight, textYes, _textYes);			formatText(rect.x + _btnWidth + 3*_padding, y + _btnHeight/8, _btnWidth, _btnHeight, textNo, _textNo);			formatText(rect.x + 2*rect.width/3 + _padding,  y + _btnHeight/8, _btnWidth, _btnHeight, textCancel, _textCancel);			formatText(rect.x + _padding, rect.y + _padding, rect.width - _padding, rect.height - _padding, message, _textMessage);						configureButton(_yesBtn);			configureButton(_noBtn);			configureButton(_cancelBtn);					addChild(_textNo);			addChild(_textYes);			addChild(_textCancel);			addChild(_textMessage);			            addChild(_box);            addChild(_yesBtn);			addChild(_noBtn);			addChild(_cancelBtn);												_noBtn.addChild(_textNo);			_yesBtn.addChild(_textYes);			_cancelBtn.addChild(_textCancel);			addChild(_textMessage);						             //Events            _yesBtn.addEventListener(MouseEvent.CLICK, yesClickHandler);			_textYes.addEventListener(MouseEvent.CLICK, yesClickHandler);            _yesBtn.addEventListener(MouseEvent.MOUSE_OVER, yesOverHandler);			_noBtn.addEventListener(MouseEvent.CLICK, noClickHandler, false, 0, true);            _noBtn.addEventListener(MouseEvent.MOUSE_OVER, noOverHandler, false, 0, true);			_textNo.addEventListener(MouseEvent.CLICK, noClickHandler, false, 0, true);			_cancelBtn.addEventListener(MouseEvent.CLICK, cancelClickHandler, false, 0, true);			_textCancel.addEventListener(MouseEvent.CLICK, cancelClickHandler, false, 0, true);            _cancelBtn.addEventListener(MouseEvent.MOUSE_OVER, cancelOverHandler, false, 0, true);            		}				protected function formatText(x:Number, y:Number, width:Number, height:Number, value:String, textf:TextField)		{			textf.x = x;			textf.y = y;			textf.width = width;			textf.height = height;			textf.autoSize = TextFieldAutoSize.CENTER;			textf.selectable = false;									var format:TextFormat = new TextFormat();			format.align = TextFieldAutoSize.CENTER;			format.font = "Verdana";            format.color = 0xF8FCFE;            format.size = 12;					textf.defaultTextFormat = format;				textf.text = value;								}				protected function configureButton(button:Sprite):void{						button.buttonMode = true;			button.useHandCursor = true;			button.mouseChildren = false;						// Create the bevel filter and set filter properties.		var bevel:BevelFilter = new BevelFilter();				bevel.distance = 2;		bevel.angle = 45;		bevel.highlightColor = 0xFFFF00;		bevel.highlightAlpha = 0.8;		bevel.shadowColor = 0x666666;		bevel.shadowAlpha = 0.8;		bevel.blurX = 1;		bevel.blurY = 1;		bevel.strength = 1;		bevel.quality = BitmapFilterQuality.HIGH;		bevel.type = BitmapFilterType.INNER;		bevel.knockout = false;				// Apply filter to the image.		button.filters = [bevel];		}		        protected function onClick(){						_clicked = true;					}        //Handlers        protected function yesClickHandler($):void		{trace("yes");_clickedYes = true;onClick(); }        protected function yesOverHandler($):void {trace("yes over"); }		protected function noClickHandler($):void {trace("no");_clickedNo= true; onClick();}        protected function noOverHandler($):void {trace("no over"); }		protected function cancelClickHandler($):void {trace("cancel");_clickedCancel= true;onClick(); }        protected function cancelOverHandler($):void {trace("cancel over");}				public function clickedYes():Boolean{						return _clickedYes;					}				public function clickedNo():Boolean{						return _clickedNo;					}				public function clickedCancel():Boolean{						return _clickedCancel;					}				public function clicked():Boolean{						return _clicked;					}				    }}