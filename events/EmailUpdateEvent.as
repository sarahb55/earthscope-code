﻿package earthscope.events{		import earthscope.events.GameEvent;		public class EmailUpdateEvent extends GameEvent{				public static const REPLY_YES:String = "Mayor replies yes to query.";		public static const REPLY_NO:String = "Mayor replies no to query.";						public function EmailUpdateEvent(type:String, bubbles:Boolean= true, cancelable:Boolean = false){						super(type, bubbles, cancelable); 					}							}					}