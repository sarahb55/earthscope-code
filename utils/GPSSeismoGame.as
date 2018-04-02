﻿package earthscope.utils{		import flash.display.Sprite;	import earthscope.utils.DisplayGraphicsFiles;	import earthscope.utils.SoundPlayer;	import flash.events.TimerEvent;	import flash.events.KeyboardEvent;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.AntiAliasType;	import flash.text.Font;	import fl.video.*;	import flash.display.MovieClip;	import flash.display.DisplayObject;	import flash.ui.Mouse;	import flash.display.DisplayObject;    import flash.events.*;	import flash.text.TextFieldAutoSize;	import flash.utils.Timer;	import flash.display.Stage;	import earthscope.events.HelicopterGameOverEvent;	import earthscope.utils.GameButtonBamboo;				public class GPSSeismoGame extends Sprite{						private var _map:DisplayGraphicsFiles = new DisplayGraphicsFiles();				private var _ocean:Sprite = new Sprite();		private var _scoreBack:Sprite = new Sprite();		private var _backGround:Sprite = new Sprite();		private var _line:Sprite = new Sprite();		private var _width:Number = 1000;		private var _height:Number = 560;		private var _done:GameButtonBamboo = new GameButtonBamboo(_width/2 - 175, 2*_height/5, 100, 100, "done");		private var _start:GameButtonBamboo = new GameButtonBamboo(_width/2 - 175, 2*_height/5, 100, 100, "start");		private var _gpsReceivers:Array = new Array();		private var _seismo:Array = new Array();		private var _navBtns:Array = new Array();		private var _helicopter:MovieClip = new Helicopter();		private var _numGPS:int = 4;		private var _numSeismo:int = 4; 		private var _scoreTxt:TextField = new TextField();		private var _scoreVal:Number = 0;		private var _instructions:TextField = new TextField();		private var _drop:DisplayGraphicsFiles =  new DisplayGraphicsFiles();		private var _index:int = 0;		private var _gpsTargets = new Array();		private var _seismoTargets = new Array();		private var _scoreUp:Number = 50;		private var _font = new GillSans();		private var _format = new TextFormat();		private var _clouds:Array = new Array();		private var _timer:Timer = new Timer(100);		private var _targetHit:Array = new Array();		private var _bMouseDown:Boolean = false;		private var _xAdd:Number = 0;		private var _yAdd:Number = 0;		private var _addVal:Number = 20;		private var _windSpeed:Number = 10;		private var _stage:Stage;		private var _oldX:Number = 0;		private var _oldY:Number = 0;				private var UP:uint = 38;		private var DOWN:uint = 40;		private var LEFT:uint = 37;		private var RIGHT:uint = 39;		private var SPACE:uint = 32;				private var _doneGPS = false;		private var _sound:SoundPlayer = new SoundPlayer();		private var _goodDrop:SoundPlayer = new SoundPlayer();		private var _fail:SoundPlayer = new SoundPlayer();				public function GPSSeismoGame(s:Stage){							if(s == null){									}				_stage = s;				_stage.focus = this;				addChild(_start);				_start.addEventListener(MouseEvent.CLICK, clickStart);												_map.loadFile("helicopter/gameBack.png");				_sound.loadSound("helicopter/helicopter.mp3");				_goodDrop.loadSound("helicopter/good.mp3");				_fail.loadSound("helicopter/fail.mp3");				_sound.stop();				init();								trace(" _stage.width: " + _stage.width + " _stage.height: " +  _stage.height)							}						private function clickStart(e:MouseEvent):void{								onStart();							}									private function onStart():void{							removeChild(_start);									var yVal:Number = 10;			var xVal:Number = 10;			var width:Number = 70;			var pad:Number = 15;									for(var j:int = 0; j < _numSeismo; j++){								_seismo.push(new SeismoIcon());				_seismo[j].y = _height - 120;				_seismo[j].x = xVal;				addChild(_seismo[j]);				xVal += width + pad;								_seismoTargets.push(new DisplayGraphicsFiles());				_seismoTargets[j].loadFile("helicopter/seismoTarget.png");			}						xVal = 10;						for(var i:int = 0; i < _numGPS; i++){								_gpsReceivers.push(new GPSIcon());				_gpsReceivers[i].y = _height - 60;				_gpsReceivers[i].x = xVal;				addChild(_gpsReceivers[i]);				xVal += width + pad;				_gpsTargets.push(new DisplayGraphicsFiles());				_gpsTargets[i].loadFile("helicopter/gpsTarget.png");				_targetHit.push(new Boolean());				_targetHit[i] = false;			}										_gpsTargets[0].y = _height/2;				_gpsTargets[0].x = 3*_width/4 - 50;				addChild(_gpsTargets[0]);								_gpsTargets[1].y = _height/2 - 180;				_gpsTargets[1].x = 3*_width/4 - 80;				addChild(_gpsTargets[1]);								_gpsTargets[2].y = _height/2 - 80 ;				_gpsTargets[2].x = 2*_width/3 - 75;				addChild(_gpsTargets[2]);								_gpsTargets[3].y = _height/2 - 80 ;				_gpsTargets[3].x = _width/3 - 75;				//addChild(_gpsTargets[3]);												_seismoTargets[0].x = 3*_width/4 + 20;				_seismoTargets[0].y = _height/2 ;				//addChild(_seismoTargets[0]);								_seismoTargets[1].x = 2*_width/3 + 100;				_seismoTargets[1].y = _height/2 - 160;				//addChild(_seismoTargets[1]);								_seismoTargets[2].x = 2*_width/3 - 50;				_seismoTargets[2].y = _height/2 - 40;				//addChild(_seismoTargets[2]);								_seismoTargets[3].x = _width/3;				_seismoTargets[3].y = _height/2 - 100;				//addChild(_seismoTargets[3]);								initGame();							}						private function init():void{																				if(_stage == null){								trace("No stage");				return;			}									with(_ocean.graphics){								beginFill(0x4897d6, 1.0);                 drawRect(-100, -100, _width + 200, _height + 200);                endFill();			}						with(_scoreBack.graphics){								beginFill(0x0000CC, 1);                drawRect(-100, _height - 150, _width + 200, 200);                endFill();			}						addChild(_ocean);						addChild(_map);						var rot:Number;						for(var k:int = 0; k < 6; k++){								_clouds.push(new Cloud());				addChild(_clouds[k]);								rot = Math.round(Math.random()*360);				_clouds[k].y = _height - 300 + k*10;				_clouds[k].rotation = rot ;				_clouds[k].x = -80 -k*40;							}			addChild(_scoreBack);			_timer.addEventListener(TimerEvent.TIMER, onTimer);																			_navBtns[0] = new DisplayGraphicsFiles();				_navBtns[0].loadFile("helicopter/navigationLeft.png");				_navBtns[0].button = true;								_navBtns[1] = new DisplayGraphicsFiles();				_navBtns[1].loadFile("helicopter/navigationRight.png");				_navBtns[1].button = true;								_navBtns[2] = new DisplayGraphicsFiles();				_navBtns[2].loadFile("helicopter/navigationUp.png");				_navBtns[2].button = true;								_navBtns[3] = new DisplayGraphicsFiles();				_navBtns[3].loadFile("helicopter/navigationDown.png");				_navBtns[3].button = true;								_navBtns[0].x = _width/2 - 90;				_navBtns[0].y= _height - 95;				_navBtns[0].addEventListener(MouseEvent.CLICK, moveLeft);				_navBtns[0].addEventListener(MouseEvent.MOUSE_DOWN,  moveLeftFaster);				_navBtns[0].addEventListener(MouseEvent.MOUSE_UP,  stopMotion);									_navBtns[1].x = _width/2 + 30 + 4;				_navBtns[1].y= _height - 95;								_navBtns[1].addEventListener(MouseEvent.CLICK, moveRight);				_navBtns[1].addEventListener(MouseEvent.MOUSE_DOWN,  moveRightFaster);				_navBtns[1].addEventListener(MouseEvent.MOUSE_UP,  stopMotion);									_navBtns[2].x = _width/2 + _navBtns[2].width/2 - 30;				_navBtns[3].x = _width/2 + _navBtns[3].width/2 -30;								_navBtns[2].addEventListener(MouseEvent.CLICK, moveUp);				_navBtns[2].addEventListener(MouseEvent.MOUSE_DOWN,  moveUpFaster);				_navBtns[2].addEventListener(MouseEvent.MOUSE_UP,  stopMotion);									_navBtns[2].y = _height - 150;				_navBtns[3].y = _height - 35;								_navBtns[3].addEventListener(MouseEvent.CLICK, moveDown);				_navBtns[3].addEventListener(MouseEvent.MOUSE_DOWN,  moveDownFaster);				_navBtns[3].addEventListener(MouseEvent.MOUSE_UP,  stopMotion);												for(var i:int = 0; i < _navBtns.length; i++){					addChild(_navBtns[i]);				}																		_drop.loadFile("helicopter/release.png");				_drop.x = _width/2 - 42;				_drop.y = _height - 108;				_drop.button = true;				_drop.addEventListener(MouseEvent.CLICK, releaseGPS);				addChild(_drop);								_instructions.width = _width/4 + 70;				_instructions.wordWrap = true;				_instructions.multiline = true;				_instructions.height = 75;				_instructions.x = 2*_width/3 - 50;				_instructions.y = _height - _instructions.height - 40;				formatText(_instructions);				_format.size = 14;				_instructions.defaultTextFormat = _format;					_instructions.text = "Place three of the GPS receivers onto the targets on the volcano. These instruments will measure and record any movement of the ground caused by volcanic activity. This data will help you to predict a volcanic eruption.";				addChild(_instructions);																				_scoreTxt.width = _instructions.width;				_scoreTxt.y = _height - 150;				_scoreTxt.x = _instructions.x;																formatText(_scoreTxt);				_format.size = 20;				_format.bold = true;				_scoreTxt.defaultTextFormat = _format;					_scoreTxt.text = "Score: " + _scoreVal;				addChild(_scoreTxt);								formatText(_instructions);								addChild(_helicopter);												_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);				_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);								addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);				addEventListener(KeyboardEvent.KEY_UP, onKeyUp);								addChild(_start);											}						public function initGame():void{								_timer.start();				_sound.play(0,100);				_sound.lowerSound(0.25);											}						public function get score():Number{				return _scoreVal;			}						private function onKeyDown(e:KeyboardEvent):void{								trace("keyboard down:" + e.charCode + e.keyCode);								if(e.keyCode == UP){					onMoveUpFaster();				}				else if (e.keyCode == DOWN){					onMoveDownFaster();				}				else if (e.keyCode == LEFT){					onMoveLeftFaster();				}				else if (e.keyCode == RIGHT){					onMoveRightFaster();				}								else if (e.keyCode == SPACE){										if(_doneGPS == false){						onReleaseGPS();					}					else{												onReleaseSeismo();					}														}												if(e.keyCode == 49){					trace("clocked 1");					endGame();				}											}						private function onKeyUp(e:KeyboardEvent):void{								trace("keyboard up: " + e.charCode);								_xAdd = 0;				_yAdd = 0;							}						private function formatText(textf:TextField){								trace("Format text");								_format.font = _font.fontName;				_format.size = 16;				_format.color = 0xFFFFFF;								textf.autoSize = TextFieldAutoSize.LEFT;				textf.selectable = false;								textf.embedFonts = true;				textf.antiAliasType = AntiAliasType.ADVANCED;				textf.filters = null;				textf.defaultTextFormat = _format;						}									private function moveRight(e:MouseEvent):void{								if(_helicopter.x + 50 < _width){					_helicopter.x += 10; 					addChild(_helicopter);				}																//trace("moveRight");			}									private function moveLeft(e:MouseEvent):void{								if(_helicopter.x - 50 >0){					_helicopter.x -= 10; 					addChild(_helicopter);				}			}						private function onMoveLeftFaster():void{								_bMouseDown = true;				if(_helicopter.x - 50 > 0){					_xAdd = -1*_addVal;					_yAdd = 0;				}				else{					_xAdd = 0;					_yAdd = 0;				}								addChild(_helicopter);			}						private function moveLeftFaster(e:MouseEvent):void{								onMoveLeftFaster();			}						private function onMoveUpFaster():void{								_bMouseDown = true;				if(_helicopter.y  > 20){					_xAdd = 0;					_yAdd = -1*_addVal;				}				else{					_xAdd = 0;					_yAdd = 0;				}								addChild(_helicopter);			}						private function moveUpFaster(e:MouseEvent):void{								onMoveUpFaster();			}						private function onMoveDownFaster():void{								_bMouseDown = true;				if(_helicopter.y < _height - 300){					_xAdd = 0;					_yAdd = _addVal;;				}				else{					_xAdd = 0;					_yAdd = 0;				}								addChild(_helicopter);			}						private function moveDownFaster(e:MouseEvent):void{								onMoveDownFaster();			}						private function onMoveRightFaster():void{								_bMouseDown = true;								trace("move right faster");								if(_helicopter.x < _width - 50){					_xAdd = _addVal;;					_yAdd = 0;				}				else{					_xAdd = 0;					_yAdd = 0;				}				addChild(_helicopter);			}						private function moveRightFaster(e:MouseEvent):void{								onMoveRightFaster();			}									private function stopMotion(e:MouseEvent):void{								_bMouseDown = false;				_xAdd = 0;				_yAdd = 0;							}						private function moveUp(e:MouseEvent):void{								if(_helicopter.y > 0){					_helicopter.y -= 10; 				}				else{					_helicopter.y = 0;				}								addChild(_helicopter);			}						private function moveDown(e:MouseEvent):void{								if(_helicopter.y + 50 < _height){					_helicopter.y += 10; 				}								addChild(_helicopter);				//trace("move down");			}						private function onReleaseGPS():void{								if(_index > _gpsReceivers.length){					return;				}				_oldX = _gpsReceivers[_index].x;				_oldY = _gpsReceivers[_index].y;								_gpsReceivers[_index].x = _helicopter.x + 25;				_gpsReceivers[_index].y = _helicopter.y + 90;				removeChild(_gpsReceivers[_index]);				addChild(_gpsReceivers[_index]);				addChild(_helicopter);								var good:Boolean = false;				var same:Boolean = false;								for(var i:int = 0; i < _gpsTargets.length; i++){										var d:Number = distance(_gpsReceivers[_index], _gpsTargets[i]);										if(_gpsReceivers[_index].hitTestObject(_gpsTargets[i]) ){												if (_targetHit[i] == true){													same = true;						}						else{							_scoreVal += _scoreUp;							_scoreTxt.text = "Score: " + _scoreVal;							_instructions.text = "Good Job!";							good = true;													_targetHit[i] = true;						}					}					else if(d < 50){												if (_targetHit[i] == true){													same = true;						}						else{							_instructions.text = "Close enough, but try to get closer next time for more points!";							_scoreVal += _scoreUp/2;							_scoreTxt.text = "Score: " + _scoreVal;													good = true;							_targetHit[i] = true;						}					}					    																		  				}								if(same == true){										_instructions.text = "Can't put two receivers on the same target try again!";					_gpsReceivers[_index].x = _oldX;					_gpsReceivers[_index].y = _oldY;					_scoreVal -= 20;					_scoreTxt.text = "Score: " + _scoreVal;					_fail.play(0,1);									}				else if(good == false)				{					_instructions.text = "Not close enough. Try again!";					_gpsReceivers[_index].x = _oldX;					_gpsReceivers[_index].y = _oldY;					_scoreVal -= 10;					_scoreTxt.text = "Score: " + _scoreVal;					_fail.play(0,1);				}				else{										_index++;										if(_index == _gpsReceivers.length - 1){												addChild(_gpsTargets[3]);						_instructions.text = "Next, place a fourth receiver farther from the volcano. This will be used as a reference point";					}										if(_index >= _gpsReceivers.length){						changeListeners();					}										_goodDrop.play(0,1);									}								addChild(_helicopter);															}						private function releaseGPS(MouseEvent):void{												onReleaseGPS();																																	}						private function changeListeners(){								trace("Done with GPS");					_drop.removeEventListener(MouseEvent.CLICK, releaseGPS);					_drop.addEventListener(MouseEvent.CLICK, releaseSeismo);					_instructions.text = "Next, try to place three seismometers around the volcano. These seismometers will help to detect swarms of tiny earthquakes that often occur before a volcanic eruption. Good Luck!"					_index = 0;										for(var i:int = 0; i < _seismoTargets.length - 1; i++){						addChild(_seismoTargets[i]);						_targetHit[i] = false;					}										_targetHit[_seismoTargets.length - 1] = false;				   _doneGPS = true;			}						private function distance(o1:Object, o2:Object):Number{												var squareSum = (o1.x - o2.x)*(o1.x - o2.x) + (o1.y - o2.y)*(o1.y - o2.y);				trace("squareSum = " +  squareSum);								return Math.sqrt(squareSum);							}						private function onTimer(e:TimerEvent){												for(var i:int = 0; i < _clouds.length; i++){															var yVal = Math.round(Math.random()*2);					var xVal = Math.round(Math.random()*5);									var oldY = _clouds[i].y;					_clouds[i].x += xVal;					_clouds[i].y -= yVal; 															if(_clouds[i].x > _width){						 var rot = Math.round(Math.random()*360);						_clouds[i].y = _height - 300;						_clouds[i].rotation = rot ;						_clouds[i].x = -i*80;					}										addChild(_clouds[i]);									}									yVal = -2 + Math.round(Math.random()*3);					xVal = -2 + Math.round(Math.random()*_windSpeed);										if(_helicopter.x + xVal + _xAdd < _width - 50 && _helicopter.x + xVal + _xAdd > 0){						_helicopter.x += xVal + _xAdd; 											}					if(_helicopter.y + yVal + _yAdd < _height - 200 && _helicopter.y + yVal + _yAdd > 20){						_helicopter.y += yVal + _yAdd;					}			}						private function endGame():void{								_drop.removeEventListener(MouseEvent.CLICK, releaseSeismo);						//end game				_instructions.text = "Good job placing your scientific instruments. These will help you monitor the volcano and keep Volcano Island safer. Now back to the office.";				_sound.stop();				_timer.stop();										addChild(_done);				_done.addEventListener(MouseEvent.CLICK, onDone);													}						private function onDone(e:MouseEvent){								dispatchEvent(new  HelicopterGameOverEvent( HelicopterGameOverEvent.HELICOPTER_GAME_COMPLETE));			}									private function releaseSeismo(e:MouseEvent):void{				onReleaseSeismo();			}						private function onReleaseSeismo():void{								_oldX= _seismo[_index].x;				_oldY = _seismo[_index].y;												_seismo[_index].x = _helicopter.x + 25 ;				_seismo[_index].y = _helicopter.y + 90;																removeChild(_seismo[_index]);				addChild(_seismo[_index]);				addChild(_helicopter);								var good:Boolean = false;				var same:Boolean = false;								for(var i:int = 0; i < _seismoTargets.length; i++){										var d:Number = distance(_seismo[_index], _seismoTargets[i]);					if(_seismo[_index].hitTestObject(_seismoTargets[i])){												if (_targetHit[i] == true){													same = true;						}						else{							_scoreVal += _scoreUp;							_scoreTxt.text = "Score: " + _scoreVal;							_instructions.text = "Good Job!";							good = true;							_targetHit[i] = true;						}					}					else if(d < 50){						if (_targetHit[i] == true){													same = true;						}						else{													_instructions.text = "Close enough, but try to get closer next time for more points!";							_scoreVal += _scoreUp/2;							_scoreTxt.text = "Score: " + _scoreVal;													good = true;							_targetHit[i] = true;						}					}					    																		  				}				if(same == true){										_instructions.text = "Can't put two receivers on the same target try again!";					_seismo[_index].x = _oldX;					_seismo[_index].y = _oldY;					_scoreVal -= 20;					_scoreTxt.text = "Score: " + _scoreVal;					_fail.play(0,1);									}				else if(good == false)				{					_instructions.text = "Not close enough. Try again!";					_seismo[_index].x = _oldX;					_seismo[_index].y = _oldY;					_scoreVal -= 10;					_scoreTxt.text = "Score: " + _scoreVal;										_fail.play(0,1);				}				else{										_index++;										if(_index == _seismo.length - 1){												_instructions.text = "Next place a fourth seismometer farther from the volcano.";						addChild(_seismoTargets[3]);					}										if(_index >= _seismo.length){						endGame();					}										_goodDrop.play(0,1);									}								addChild(_helicopter);							}		}																						}