﻿package earthscope.utils{		import earthscope.utils.GPSGrapher;	import earthscope.events.GameEvent;	import flash.events.*;	import flash.display.Sprite;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;    import flash.text.TextFormat;	import flash.text.Font;	import fl.controls.Button;    import fl.controls.Label;    import fl.controls.RadioButton;    import fl.controls.RadioButtonGroup;	import flash.events.TimerEvent;	import flash.utils.Timer;		public class GPSDriver extends Sprite{				var dataArray:Array = new Array();		private var _graph:GPSGrapher = new GPSGrapher(500, 300);		private var _header:TextField = new TextField();		private var xPad = 80;		private var yPad = 60;		private var _format:TextFormat = new TextFormat();		private var _myFont:Font = new Arial();		private var _graphyY = 100;		private var _explanation:TextField = new TextField();		private var qre:RadioButtonGroup;		private var answers:Array = [ "The volcano is inactive (quiet).", "There is a small earthquake.", "The volcano inflates rapidly." ];		var rb1:RadioButton = new RadioButton();		var rb2:RadioButton = new RadioButton();		var rb3:RadioButton = new RadioButton();		var _fadeBox:Sprite = new Sprite();								var b1:Button = new Button();		var b2:Button = new Button();		var b3:Button = new Button();				var _timer:Timer = new Timer(100, 1000);		var _tick:Number = 0;    	var slope:Number = 0;		var v:Number;				private function onNoActivity(e:MouseEvent){			trace("Selected no activity");			slope = 0;			v = dataArray[dataArray.length - 1].y;			_tick = 0;		}		private function onSmallEarthquake(e:MouseEvent){						trace("Selected small earthquake");			var sign:Number = Math.random();			if(sign < 0.5){				sign = -1;			}			else{				sign = 1;			}			v += sign*(Math.round(10*Math.random()) + 5);			_tick = 0;		}				private function onInflation(e:MouseEvent){			slope = 0.5 + 0.25*Math.random();			trace("Selected on inflation: slope = " + slope);			_tick = 0;								}		public function  GPSDriver(){			super();			trace("Creating GPSDriver");			addChild(_graph);			_graph.x =  xPad;			_graph.y = _graphyY;			_timer.stop();			_timer.addEventListener(TimerEvent.TIMER, updatePlot);						rb1.addEventListener(MouseEvent.CLICK, onNoActivity);			rb2.addEventListener(MouseEvent.CLICK, onSmallEarthquake);			rb3.addEventListener(MouseEvent.CLICK, onInflation);						setUpWindow();			plot();		}				private function plotNoActivity(){						v = Math.round(50*Math.random()) + 10;						for(var i:Number = 0; i < 100; i++){								var p:Object = new Object();				p.x = i;				p.y = v + Math.round(3*Math.random()) - 3;								dataArray.push(p);							}						_graph.plot(dataArray);								}						private function updatePoints(){						dataArray.shift();						//trace (dataArray.length);						for(var i:Number = 0; i < dataArray.length; i++){												dataArray[i].x--;							}						var p:Object = new Object();			p.x = dataArray[dataArray.length - 1].x + 1;			p.y = Math.round(3*Math.random()) - 3 + slope*_tick + v;			trace(slope);			dataArray.push(p);						_graph.plot(dataArray);								}				private function plotEarthquake(){								}						private function plotSteadyInflation(){			dataArray = new Array();			slope = 0.25 + 0.5*Math.random();			for(var i:Number = 0; i < 100; i++){								var p:Object = new Object();				p.x =i;				p.y = slope*_tick + Math.round(3*Math.random())- 3 + v;				dataArray.push(p);											}						_graph.plot(dataArray);								}				private function updateSteadyInflation(){												for(var i:int = 0; i < dataArray.length; i++){								dataArray[i].x--;			}						dataArray.shift();						//var p:Object = new Object();			//p.x =2*dataArray[dataArray.length - 1] + 2;			//p.y = slope*i + Math.round(3*Math.random())- 3;			//dataArray.push(p);												_graph.plot(dataArray);								}				public function updateEarthquake(){						for(var i:int = 0; i < dataArray.length; i++){								dataArray[i].x--;			}						dataArray.shift();		}						private function updatePlot(e:TimerEvent):void{			trace("updatePlot");						plot();		}				public function plot(){						try{						if(dataArray.length < 3){					 plotNoActivity();			}						if(qre.selection.label == answers[0]){									slope = 0;													}			else if(qre.selection.label == answers[1]){																	}			else if(qre.selection.label == answers[2]){									_tick++;							}								updatePoints();						}			catch(e:Error){				trace(e);				dataArray = new Array();			}					}				private function setUpWindow():void{															_header.x =  xPad; 			_header.y = yPad; 						_format.size = 24;			_format.color = 0x000000;			//_format.font = "Arial";															_format.font = _myFont.fontName;						_header.autoSize = TextFieldAutoSize.LEFT			_header.defaultTextFormat = _format;			_header.text = "What does the GPS Monitor tell you about the volcano?";			addChild(_header);									_header.embedFonts = true;						_format.size = 16;						qre = new RadioButtonGroup("volcano");			rb1.label = answers[0];			rb2.label = answers[1];			rb3.label = answers[2];						_explanation.x = 610;			_explanation.y = _graphyY;			_explanation.multiline = true;			_explanation.wordWrap = true;			_explanation.width = 280;			_explanation.autoSize = TextFieldAutoSize.LEFT;			_explanation.defaultTextFormat = _format;			_explanation.embedFonts = true;			_explanation.text = "The GPS receivers you installed on the volcano measure their positions on the ground very accurately. When molten rock, or magma, moves up from deep underground, the surface of the Earth around the volcano bulges upward. If enough magma flows up, some might escape, causing an eruption. Before an eruption, telltale vertical movements of the GPS receivers are recorded on the graph. Press the button below to see what the graph might look like when..."									addChild(_explanation);												rb1.width = 300;			rb2.width = 300;			rb3.width = 300;									rb1.group = rb2.group = rb3.group = qre;						rb1.move(_explanation.x,_graphyY + _explanation.height + 20);			rb2.move(_explanation.x,_graphyY + _explanation.height + 50);			rb3.move(_explanation.x,_graphyY + _explanation.height + 80);						rb1.selected = true;			addChild(rb1);			addChild(rb2);			addChild(rb3);												//addChild(b1);			//addChild(b2);						//b1.label = "Stop";			//b1.move(_explanation.x + 130, _explanation.height + 210);						//b2.label = "Start";			//b2.move(_explanation.x , _explanation.height + 210);						b3.label = "Done";			b3.move(_explanation.x, _explanation.height + 210);						addChild(b3);						b1.addEventListener(MouseEvent.CLICK, clearGraph);			b2.addEventListener(MouseEvent.CLICK, plotPoints);			b3.addEventListener(MouseEvent.CLICK, onDone);		}				public function plotPoints(e:MouseEvent):void{									_timer.start();								}				public function onDone(e:MouseEvent):void{						dispatchEvent(new GameEvent( GameEvent.CHANGE));		}				public function clearGraph(e:MouseEvent):void{						_timer.stop();								}				public function start():void{						_timer.start();		}				public function stop():void{						_timer.stop();		}							}			}