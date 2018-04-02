﻿package earthscope.utils{		import flash.display.Shape;    import flash.display.Sprite;    import flash.geom.Rectangle;    import flash.events.MouseEvent;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;    import flash.text.TextFormat;	import flash.ui.Mouse;	import flash.filters.BevelFilter;	import flash.filters.BitmapFilterQuality;	import flash.filters.BitmapFilterType;	import flash.net.URLRequest;	import flash.utils.Timer;	import flash.events.TimerEvent;	import earthscope.utils.GPSGrapher;		import earthscope.models.VolcanoData;	import earthscope.events.RumbleEvent;	import earthscope.events.VolcanoWakesUpEvent;				public class GPSMonitor extends Sprite{						private var _box:Sprite;		private var _rect:Rectangle;		private var _numPoints:Number = 25;		private var dataArray:Array = new Array();		private var _volcano:VolcanoData;		private var _spacing:Number = 10;		private var _pause:Boolean = false;		private var j:uint = 0;		private var gpsGraph:GPSGrapher; 						var _timer:Timer = new Timer(400, 100000);		var _tick:Number = 0;    	var slope:Number = 0;		var v:Number = 10;				public function GPSMonitor(rect:Rectangle, volcano:VolcanoData){			trace ("Creating new draw moving graph object...");						_timer = new Timer(1000);			_timer.addEventListener(TimerEvent.TIMER, updatePlot);			_timer.start();			_rect = rect;						gpsGraph = new GPSGrapher(rect.width, rect.height);			gpsGraph.x = rect.x;			gpsGraph.y = rect.y;			addChild(gpsGraph);						_volcano = volcano;			_numPoints = _volcano.ticksToLive + 5;			//_volcano.addEventListener(PuffOfSmokeEvent.PUFF_OF_SMOKE, puff);			//_volcano.addEventListener(PuffOfSmokeEvent.NO_SMOKE, no_puff);			_volcano.addEventListener(RumbleEvent.RUMBLE, rumble);			//_volcano.addEventListener(VolcanoEruptsEvent.VOLCANO_ERUPTS, onVolcanoErupts);			_volcano.addEventListener(VolcanoWakesUpEvent.VOLCANO_WAKES_UP, onVolcanoWakesUp);									buttonMode = true;			useHandCursor = true;									//initGraph();						plotNoActivity();										}				private function onVolcanoWakesUp(VolcanoWakesUpEvent){						v += 20;			onInflation();		}				private function rumble(RumbleEvent){								}						private function onNoActivity(){			trace("Selected no activity");			slope = 0;			v = dataArray[dataArray.length - 1].y;			_tick = 0;		}		private function onSmallEarthquake(){						trace("Selected small earthquake");						v += Math.round(10*Math.random()) + 5;			_tick = 0;		}				private function onInflation(){						slope = 0.25 + 0.25*Math.random();			trace("Selected on inflation: slope = " + slope);			_tick = 0;								}				private function plotNoActivity(){									for(var i:Number = 0; i < 32; i++){								var p:Object = new Object();				p.x = 3*i;				p.y = v + Math.round(2*Math.random()) - 2;								dataArray.push(p);							}						gpsGraph.plot(dataArray);								}				public function pause(){						_timer.stop();		}				public function start(){						_timer.start();		}						private function updatePoints(){						dataArray.shift();									//trace (dataArray.length);						for(var i:Number = 0; i < dataArray.length; i++){												dataArray[i].x -=3;							}						var p:Object = new Object();			p.x = dataArray[dataArray.length - 1].x + 3;			p.y = Math.round(3*Math.random()) - 3 + slope*_tick + v;			trace(slope);			dataArray.push(p);						gpsGraph.plot(dataArray);								}				private function updatePlot(e:TimerEvent):void{			trace("updatePlot");						plot();		}				public function plot(){						try{						if(dataArray.length < 3){					 plotNoActivity();			}						if(_volcano.percentComplete > 2 ){								slope = _volcano.percentComplete/70.0;				trace(slope);				_tick ++;			}					updatePoints();						}			catch(e:Error){				trace(e);				dataArray = new Array();			}					}				/*		private function initGraph(){						for(var i:int = 0; i <= _numPoints; i++){								points[i] = new Object();				points[i].x = _rect.width*i/_numPoints + _rect.x;				points[i].y = 1;								trace("Making points");							}								}						public function pause(){						_timer.stop();		}				public function start(){						_timer.start();		}				public function drawGraph(){								}						public function updateGraph(TimerEvent){									graphics.clear();						var array:Array = _volcano.array;															if(array.length < 2){				return;			}						graphics.lineStyle(1, 0x000000);						var ticks:Number = _volcano.ticksToLive;									var val:Number = array[array.length - 1];			var yunit = _rect.height/110.0;			    			var yval:Number = -Math.pow(val/5, 1.5)+0.05*(-0.5*Math.random() + 0.5)*_rect.height + _rect.height*.9 + _rect.y ;										points[j].y = yval;			j++;																				//graphics.moveTo(_rect.x, _rect.height*0.5 + _rect.y - 2) ;			//graphics.lineTo(_rect.x + _rect.width, _rect.height*0.5 + _rect.y);						//graphics.lineStyle(1, 0xFF00FF);						//graphics.moveTo(_rect.x, _rect.height*0.75 + _rect.y - 2);			//graphics.lineTo(_rect.x + _rect.width, _rect.height*0.75 + _rect.y);						//graphics.moveTo(_rect.x, _rect.height*0.25 + _rect.y - 2 );			//graphics.lineTo(_rect.x + _rect.width, _rect.height*0.25 + _rect.y );												graphics.moveTo(points[0].x, points[0].y);												for(var i:int = 1; i < j - 1; i++){								graphics.lineStyle(1);				graphics.lineTo(points[i].x, points[i].y);								//trace(points[i].y);											}																				}				*/	}							}