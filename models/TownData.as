﻿package earthscope.models{	   import flash.text.TextField;   import flash.events.Event;   import earthscope.events.GameEvent;   import earthscope.events.PuffOfSmokeEvent;   import earthscope.events.RandomDogEvent;   import earthscope.events.AnxiousTownPersonEvent;   import earthscope.events.VolcanoWarningEvent   import earthscope.events.RumbleEvent;   import earthscope.models.VolcanoData;   import earthscope.models.MayorData;   import earthscope.events.VolcanoWarningEvent;   import earthscope.events.ScientistOnNewsEvent;   import earthscope.events.EvacuationIgnoredEvent;   import earthscope.events.WarningEvent;   import earthscope.events.EvacuationUnderwayEvent;   import earthscope.events.BeachFestivalEvent;   import earthscope.events.EmailUpdateEvent;   import earthscope.models.EmailData;   import earthscope.utils.SoundPlayer;         import earthscope.text.GameText;   	public class TownData extends GameData{				private var _debug:TextField;		private var _view = false;		private var _anxiety:Number = 20;		private var _increaseAnxietySmoke:Number = 5;		private var _increaseAnxietyRumble:Number = 15;		private var _volcano:VolcanoData;		private var _preparedness:Number = 0;		private var _warned:Boolean = false;		private var _warningHeeded:Number = 30;		private var _anxiousTownPersonDispatched:Boolean = false;		private var _dispatchAnxiousTownPerson:Number = 60;		private var _mayor:MayorData;		private var _dogProbability = 0.95;		private var _increasePrepardness:Number = 1;		private var _townEvacuated:Boolean = false;		private var _dogDispatched:Boolean = false;		private var _anxietyMax:Number = 100;		private var _money = GameText.MONEY;		private var _beachFestival:Boolean = false;		private var _warningCancelled:Boolean = false;		private var _emailData:EmailData;				private var _plusFunds:SoundPlayer = new SoundPlayer();   		private var _minusFunds:SoundPlayer = new SoundPlayer();   		private var _plusPrep:SoundPlayer = new SoundPlayer();   		private var _minusPrep:SoundPlayer = new SoundPlayer();							public function TownData(emailData:EmailData){			trace("Making a new town");			_warned = false;			_emailData = emailData;			_emailData.addEventListener(EmailUpdateEvent.REPLY_YES, onEmailUpdate);			_emailData.addEventListener(EmailUpdateEvent.REPLY_NO, onEmailUpdate);						_plusFunds.loadSound("sounds/moneyUp.mp3");			_minusFunds.loadSound("sounds/moneyDown.mp3");			_plusPrep.loadSound("sounds/prepUp.mp3");			_minusPrep.loadSound("sounds/prepDown.mp3");						}				override public function tick(tick:Number): void		{						_anxiety = clamp(_anxiety);			_debug.appendText("Updating town...  ");			_debug.appendText("Town anxiety: " + _anxiety + "...  ");						decreaseAnxiety();						if(_anxiety >= GameText.ANXIETY_LEVEL_TRIGGERS_ANXIOUS_TOWNSPERSON && !_anxiousTownPersonDispatched && _volcano.getRumble()){								dispatchEvent(new AnxiousTownPersonEvent(AnxiousTownPersonEvent.HIGH_ANXIETY));				_anxiousTownPersonDispatched = true;											}									var num:Number;			num = Math.random();						if(num > _dogProbability && !_dogDispatched){				dispatchEvent(new RandomDogEvent(RandomDogEvent.DOG_RUNS_THROUGH_OFFICE));				_debug.appendText("random dog event dispatched..."  + "...  ");				_dogDispatched = true;							}			/*			if(_warned){									//_preparedness += GameText.CLOCK_LOOP_SUCCESSFUL_WARNING_PREPARDNESS_CHANGE;					//_preparedness = clamp(_preparedness);					//_debug.appendText("Town preparation increases to: " + _preparedness + "...  ");					//changeMoney(GameText.CLOCK_LOOP_SUCCESSFUL_WARNING_MONEY_CHANGE);							}						if(!_warned && !_beachFestival && num < GameText.BEACH_FESTIVAL_PROBABILITY){									dispatchEvent(new BeachFestivalEvent(BeachFestivalEvent.BEACH_FESTIVAL));					_beachFestival = true;					_debug.appendText("Town requests beach festival!");					trace("Town requests beach festival!");							}*/						_debug.appendText("Town Treasury: " + _money + "...  ");		}						public function changePrepardness(val:Number):void{						_preparedness += val;									if(val > 5){								_plusPrep.play(0,1);							}			else if(val < 5){				_minusPrep.play();			}						_preparedness = clamp(_preparedness);					}				public function onEmailUpdate(e:EmailUpdateEvent):void{			trace("Updating on email"); 			changePrepardness(_emailData.prepChange);			changeMoney(5000*_emailData.moneyChange);					}				public function setDebugField(text_field:TextField){						_debug = text_field;					}				public function get money():Number{						return _money;		}				public function get warned():Boolean{						return _warned;			trace (_warned + " from town warned..");		}				public function get warningCancelled():Boolean{						return _warningCancelled; //Set to true..			trace (_warned + " from town warned..");		}		public function get evacuated():Boolean{						return _townEvacuated;		}				public function cancelVolcanoEvacuationWarning(e:VolcanoWarningEvent){						cancelEvacuationWarning();					}				public function cancelEvacuationWarning(){						if(_warned == false){								return;			}						_warned = false;			_warningCancelled = true;			_preparedness += GameText.CHANGE_IN_TOWN_PREP_ON_CANCEL_WARNING;						if(_volcano.activity == false){								_mayor.changePopularity(GameText.CHANGE_IN_MAYOR_POP_ON_CANCEL_WARNING_VOLCANO_QUIETS);							}			else{								_mayor.changePopularity(GameText.CHANGE_IN_MAYOR_POP_ON_CANCEL_WARNING);			}					}				public function maintainVolcanoEvacuationWarning(VolcanoWarningEvent){						//only do anything for now if volcano is quiet			if(_volcano.activity == false){				_warned = true;				_warningCancelled = false;				_mayor.changePopularity(GameText.CHANGE_IN_MAYOR_POP_ON_MAINTIAN_WARNING_AFTER_QUIET);			}					}				public function setVolcano(volcano:VolcanoData){			_volcano = volcano;			_volcano.addEventListener(PuffOfSmokeEvent.PUFF_OF_SMOKE, volcanoPuffs);			_volcano.addEventListener(RumbleEvent.RUMBLE, volcanoRumbles);			_volcano.addEventListener(ScientistOnNewsEvent.ADVISOR, scientistOnNews);		}				public function setMayor(mayor:MayorData){			_mayor = mayor;			_mayor.addEventListener(VolcanoWarningEvent.MAYOR_ISSUES_WARNING, mayorIssuesWarning); 			_mayor.addEventListener(VolcanoWarningEvent.MAYOR_ORDERS_EVACUATION, mayorOrdersEvacuation);			_mayor.addEventListener(VolcanoWarningEvent.MAYOR_CANCELS_WARNING, cancelVolcanoEvacuationWarning);			_mayor.addEventListener(VolcanoWarningEvent.MAYOR_MAINTAINS_WARNING, maintainVolcanoEvacuationWarning);								}				public function mayorApprovesBeachFestival():void{						changeMoney(-1*GameText.BEACH_FESTIVAL_COST);					}				public function mayorDeniesBeachFestival():void{											}				public function changeMoney(v:Number):void{						_money += v;						if(v < 5000){								_minusFunds.play(0,1);			}			else if(v > 5000){								_plusFunds.play(0,1);							}					}						public function scientistOnNews(scientistOnNews):void{						_anxiety += GameText.SCIENTIST_ON_NEW_ANXIETY_CHANGE;			_preparedness += GameText.SCIENTIST_ON_NEW_PREPARDNESS_CHANGE;						_preparedness = clamp(_preparedness);			_anxiety = clamp(_anxiety);						_debug.appendText("Town sees scientist on the news. Prepardness increases to: " + _preparedness + "....  ");					}						public function get anxiety():Number{						return _anxiety;		}				public function get preparation(){						return _preparedness;		}				public function decreaseAnxiety(){						_anxiety += GameText.CLOCK_LOOP_CHANGE_ANXIETY;			_anxiety = clamp(_anxiety);		}				override public function updateView():Boolean		{			return _view;		}				public function volcanoPuffs(PuffOfSmokeEvent):void{						_anxiety += GameText.INCREASE_TOWN_ANXIETY_SMOKE;			_anxiety = clamp(_anxiety);			_debug.appendText("Town sees puff of smoke. Anxiety increases to: " + _anxiety + "...  ");		}				public function volcanoRumbles(RumbleEvent):void{						_anxiety += GameText.INCREASE_TOWN_ANXIETY_RUMBLE;			_anxiety = clamp(_anxiety);			_debug.appendText("Town hears a rumble. Anxiety increases to: " + _anxiety + "...  ");		}				public function mayorIssuesWarning(e:VolcanoWarningEvent){						_warned = true;			_debug.appendText("Town heeds warning by mayor: ...  ");			_preparedness += _increasePrepardness;			_preparedness = clamp(_preparedness);			_mayor.changePopularity(GameText.SUCCESSFUL_WARNING_POPULARITY_CHANGE);			changeMoney(GameText.SUCCESSFUL_WARNING_MONEY_CHANGE);			dispatchEvent(new WarningEvent(WarningEvent.TOWN_ACCEPTS_WARNING));						/*if(_volcano.percentComplete > GameText.MIN_VOLCANO_STATE_FOR_SUCCESSFUL_WARNING){								_warned = true;				_debug.appendText("Town heeds warning by mayor: ...  ");				_preparedness += _increasePrepardness;				_preparedness = clamp(_preparedness);				_mayor.changePopularity(GameText.SUCCESSFUL_WARNING_POPULARITY_CHANGE);				_money += GameText.SUCCESSFUL_WARNING_MONEY_CHANGE;				dispatchEvent(new WarningEvent(WarningEvent.TOWN_ACCEPTS_WARNING));			}			else{								_debug.appendText("Town ignores mayors warning. Volcano too far from eruption......  ");				_mayor.changePopularity(GameText.FAILED_WARNING_POPULARITY_CHANGE);				_money += GameText.FAILED_WARNING_MONEY_CHANGE;				dispatchEvent(new WarningEvent(WarningEvent.TOWN_IGNORES_WARNING));				_warned = false;			}*/							}			public function mayorOrdersEvacuation(e:VolcanoWarningEvent){		_debug.appendText("Mayor orders evacuation......  ");				_debug.appendText("Evacuation underway......  ");				dispatchEvent (new EvacuationUnderwayEvent(EvacuationUnderwayEvent.TOWN_ACCEPTS_EVACUATION));				_mayor.changePopularity(GameText.SUCCESSFUL_EVACUATION_POPULARITY_CHANGE);				changeMoney(GameText.SUCCESSFUL_EVACUATION_MONEY_CHANGE);				_townEvacuated = true;					/*				if(_warned && 		   _preparedness > GameText.MIN_PREPARDNESS_FOR_EVACUATION && 		   _mayor.popularity > GameText.MIN_POPULARITY_FOR_EVACUATION && 		   _money > GameText.MIN_MONEY_FOR_EVACUATION){						_debug.appendText("Evacuation underway......  ");			dispatchEvent (new EvacuationUnderwayEvent(EvacuationUnderwayEvent.TOWN_ACCEPTS_EVACUATION));			_mayor.changePopularity(GameText.SUCCESSFUL_EVACUATION_POPULARITY_CHANGE);			_money += GameText.SUCCESSFUL_EVACUATION_MONEY_CHANGE;			_townEvacuated = true;		}		else{			_debug.appendText("Evacuation ignored... Conditions for evacuation were not met...  ");			_mayor.changePopularity(GameText.FAILED_EVACUATION_POPULARITY_CHANGE);			_money += GameText.FAILED_EVACUATION_MONEY_CHANGE;			dispatchEvent (new EvacuationIgnoredEvent(EvacuationIgnoredEvent.EVACUATION_IGNORED));		}		*/			}			private function clamp(num:Number):Number{			var retVal:Number = 0;						if(num > 100){								retVal = 100;							}			else if(num < GameText.MIN_GAME_VARIABLE){								retVal = GameText.MIN_GAME_VARIABLE;			}			else{								retVal = num;							}						return retVal;					}			}	}					