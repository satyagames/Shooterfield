package com.jewelmaster {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import com.terrypaton.events.HighscoreEvent;
	import flash.display.MovieClip
	import flash.events.Event;
	import flash.text.*
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
	import mochi.as3.*
	import com.terrypaton.utils.commaNumber
	public class GameCompleteScreenClass extends MovieClip {
		public function GameCompleteScreenClass():void {
			_instance = this
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.REVEAL_MAIN_MENU))
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			//Broadcaster.addEventListener (PlayingLoopEvent.DISPLAY_GAME_COMPLETE,  restart);
			//_PlayingLoopManagerRef= PlayingLoopManager.getInstance()
			addEventListener(Event.REMOVED_FROM_STAGE,hide)
		}
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
			switch(e.data.name) {
				case "gameCompleteSubmitScoreBtn":
					////trace("submitScoreBtn")
					var _data:Object = new Object ()
					this.fallingItems.stopEffect()
					this.fallingItems2.stopEffect()
					_data.score =score
					//_data.score =100
					gameCompleteSubmitScoreBtn.visible = false
					Broadcaster.dispatchEvent (new HighscoreEvent (HighscoreEvent.SUBMIT_HIGH_SCORE,true,_data))
			
				break
				case "mainMenuBtn":
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
				break
				
			}
		}
		
		public function restart ():void {
			trace ("restarting game complete screen")
			gameCompleteSubmitScoreBtn.visible = true
			fallingItems.startEffect()
			fallingItems2.startEffect()
			score =DataManager.getInstance().score
			scoreTextBox.text = commaNumber.processNumber (score)
			
		}
		private function hide(e:Event):void {
			this.fallingItems.stopEffect()
			this.fallingItems2.stopEffect()
		}
		
		public static function getInstance():GameCompleteScreenClass {
			return _instance
		}
		private static var _instance:GameCompleteScreenClass
		//private  var _PlayingLoopManagerRef:PlayingLoopManager
		
		
		
		private var score:int = 0
	}
}