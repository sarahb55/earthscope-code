﻿package earthscope.events{		import earthscope.events.GameEvent;		public class VolcanoEruptsEvent extends GameEvent{				public static const VOLCANO_ERUPTS:String = "Volcano Erupts.";						public function VolcanoEruptsEvent(type:String, bubbles:Boolean= true, cancelable:Boolean = false){						super(type, bubbles, cancelable); 			trace("Volcano erupts!");		}							}					}