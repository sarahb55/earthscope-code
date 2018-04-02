﻿/* * This Interface is for all of the game elements in the volcano game. * written by Sarah Block * November 30, 2007 */ package earthscope.models{		 import flash.events.EventDispatcher;import flash.events.Event;import earthscope.events.GameEvent;		public class GameData extends EventDispatcher{						/**		 * This method is designed to update each time the game timer ticks. It		 * should update the internal state of the game piece based on the time.		 */		public function tick(tick:Number):void{}				/**		 * This method tells the GameEngine whether or not anything needs to change		 * in the way the object is displayed.		 * @return true when drawing needs to be updated.		 * @return false if it needs no changes.		 */		public function updateView():Boolean{return false; }			}		}