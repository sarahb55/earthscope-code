﻿package earthscope.events{		import earthscope.events.GameEvent;		public class BeachFestivalEvent extends GameEvent{				public static const BEACH_FESTIVAL:String = "Town requests beach festival";						public function BeachFestivalEvent(type:String, bubbles:Boolean= true, cancelable:Boolean = false){						super(type, bubbles, cancelable); 					}							}					}