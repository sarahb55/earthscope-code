﻿package earthscope.views{		import earthscope.controller.GameEngine;import earthscope.utils.AlertBox;import earthscope.models.VolcanoData;import earthscope.models.MonitorData;import earthscope.events.VolcanoEruptsEvent;import earthscope.utils.SeismoGraph;import earthscope.utils.GPSMonitor;import earthscope.utils.GameButtonMayor;import earthscope.utils.DisplayGraphicsFiles;import earthscope.text.GameText;import flash.display.Sprite;import flash.events.MouseEvent;import earthscope.utils.PlayVideos;import earthscope.utils.GameButton;import earthscope.utils.DisplayGraphicsFiles;import earthscope.utils.GameTextField;import flash.events.*;import flash.text.*;import flash.display.*;import flash.text.*;import flash.net.*;import flash.geom.Rectangle;		public class FinalScreenView  extends Sprite{				private var _game:GameEngine;		private var _back:DisplayGraphicsFiles;		private var _boat1:DisplayGraphicsFiles;		private var _boat2:DisplayGraphicsFiles;		private var _boat3:DisplayGraphicsFiles;		private var _monitor:MonitorData;		private var _doneBtn:GameButtonMayor;		private var _scoreTxt:GameTextField;		private var _player;		private var _textMessage :TextField;		private var _loader:URLLoader;		private var _format:TextFormat;		protected var _location:Rectangle;		private var _lowerBorder:DisplayGraphicsFiles;				public function FinalScreenView(game:GameEngine){						_game = game;						_back = new DisplayGraphicsFiles() ;			_back.loadFile(GameText.PICTURE_DIRECTORY + GameText.SCORE_BACKGROUND);			addChild(_back);						_back.x = GameText.BACK_X;			_back.y = GameText.BACK_Y;						_doneBtn = new GameButtonMayor(400, 470, 165, 60,"play again");			_doneBtn.addEventListener(MouseEvent.CLICK, onDone);			addChild(_doneBtn);									_location = new Rectangle(310, 220, 300, 300);			_lowerBorder = new DisplayGraphicsFiles();			_lowerBorder.loadFile(GameText.PICTURE_DIRECTORY + GameText.LOWER_BORDER);			_lowerBorder.y = GameText.LOWER_BORDER_Y;			_lowerBorder.x = GameText.LOWER_BORDER_X;			addChild(_lowerBorder);			addChild(_doneBtn);					}				public function onEnterFinalScreen(){						if(_game.playerWins == true){								loadText(GameText.TEXT_DIRECTORY + GameText.PLAYER_WINS_TXT);							}			else{								loadText(GameText.TEXT_DIRECTORY + GameText.PLAYER_LOSES_TXT);			}					}				public function onExitFinalScreen(){								}				private function onDone(MouseEvent):void{									navigateToURL(new URLRequest("index.html"), "_self");			//System.exit(0);					}				 public function loadText(file:String){			 			 _textMessage  = new TextField();			 addChild(_textMessage);			 			 _loader = new URLLoader();			 _loader.addEventListener(Event.COMPLETE, handleComplete);			 _loader.load(new URLRequest(file));			 _loader.dataFormat = URLLoaderDataFormat.TEXT;			 			 format();			 trace (_textMessage.width + _textMessage.height);			 addChild(_textMessage);			 		 }		 		 private function handleComplete(event:Event){						  _textMessage.text = _loader.data;			  			  			  			var num:Number = _game.score;						_scoreTxt = new GameTextField("" + _game.score);			_scoreTxt.x = 440;			_scoreTxt.y = 200;			addChild(_scoreTxt);									if(_game.playerWins == false){				return;			}						if(num < 1000 ){							 _textMessage.text += "\n\nHowever to earn more points, you need to improve your management skills. Please look at your Mayor's Handbook for more information.";			}			else if (num >=1000 && num < 2000){								 _textMessage.text += "\n\nYou have done a good job as mayor and got everyone to safety. Thank you for playing and we hope you'll try again."			}			else {								 _textMessage.text += "\n\n You deserve a Wow! for doing a fantastic job as mayor. You have paid attention to preparation, popularity, and the town's money, and you timed the evacuation perfectly. Congratulations!"			}			 		 }		 		 public function set location(rect:Rectangle):void{			 			 _location = rect;		 }		 		public function format(){									_textMessage.textColor = 0x000000;			_textMessage.wordWrap = true;			_textMessage.width = 400;						_textMessage.autoSize = TextFieldAutoSize.CENTER;			_textMessage.x = _location.x + 20;			_textMessage.y = _location.y + 20;			_textMessage.width = _location.width;			_textMessage.height = _location.height;			_format = new TextFormat();			_format.font = "Arial";			_format.size = 12;			_format.color = GameText.WHITE;			_textMessage.defaultTextFormat = _format;		}													}		}