﻿package earthscope.events{		import earthscope.events.GameEvent;		public class RandomDogEvent extends GameEvent{				public static const DOG_RUNS_THROUGH_OFFICE:String = "Random dog runs through office";						public function RandomDogEvent(type:String, bubbles:Boolean= true, cancelable:Boolean = false){						super(type, bubbles, cancelable); 			trace("Random dog event created.");		}							}					}