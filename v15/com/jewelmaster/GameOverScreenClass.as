package com.jewelmaster {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import com.terrypaton.events.HighscoreEvent;
	import flash.display.MovieClip
	import flash.text.*
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
	import mochi.as3.*
	import com.terrypaton.utils.commaNumber
	public class GameOverScreenClass extends MovieClip {
		public function GameOverScreenClass():void {
			_instance = this
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.REVEAL_MAIN_MENU))
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			Broadcaster.addEventListener (PlayingLoopEvent.GO_GAME_OVER,  restart);
			//_PlayingLoopManagerRef= PlayingLoopManager.getInstance()
		}
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
			switch(e.data.name) {
				case "submitScoreBtn":
					////trace("submitScoreBtn")
					var _data:Object = new Object ()
					
					_data.score =score
					//_data.score =100
					submitScoreBtn.visible = false
					Broadcaster.dispatchEvent (new HighscoreEvent (HighscoreEvent.SUBMIT_HIGH_SCORE,true,_data))
			
				break
				case "mainMenuBtn":
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
				break
				
			}
		}
		
		public function restart (e:PlayingLoopEvent):void {
			trace ("restarting gameover screen")
			submitScoreBtn.visible = true
			score =DataManager.getInstance().score
			scoreTextBox.text =commaNumber.processNumber(score)
		}
		private function hideMainMenu():void {
			
		}
		
		public static function getInstance():GameOverScreenClass {
			return _instance
		}
		private static var _instance:GameOverScreenClass
		//private  var _PlayingLoopManagerRef:PlayingLoopManager
		private  var _DataManagerRef:DataManager
		
		
		private var score:int = 0
	}
}