package com.jewelmaster {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import com.terrypaton.events.HighscoreEvent;
	import flash.display.MovieClip
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
	import mochi.as3.*
	import flash.events.*
	public class HighscoreScreenClass extends MovieClip {
		public function HighscoreScreenClass():void {
			_instance = this
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.REVEAL_MAIN_MENU))
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			//Broadcaster.addEventListener (HighscoreEvent.SHOW_HIGH_SCORES, revealHighscoreChart);
			_PlayingLoopManagerRef = PlayingLoopManager.getInstance()
			
			addEventListener (Event.REMOVED_FROM_STAGE, hideHighs);
		}
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
			switch(e.data.name) {
				case "mainMenuBtn":
				
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
				break
				
			}
		}
		private function revealHighscoreChart(e:HighscoreEvent):void {
		 MochiScores.showLeaderboard( { boardID: "", res: "640x480", clip: this, onClose: closeHighscores, onError: highscoreError ,onDisplay:highscoreDisplayed}  );
			sceneBack.startEffect()
		 }
		 private function hideHighs(event:Event):void {
			sceneBack.stopEffect()
		}
	private function closeHighscores():void {
		trace ("close high scores")
		
		//dispatchEvent (new HighscoreEvent (HighscoreEvent.CLOSE_HIGHSCORES, true))
		Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
	}
	private function highscoreError(e):void {
		////trace("high scores error")
		dispatchEvent(new HighscoreEvent(HighscoreEvent.CLOSE_HIGHSCORES,true))
	}
		public function restart ():void {
			////trace("restarting help screen")
		}
		private function highscoreDisplayed ():void {
			//title.y = 0
		}
		
		public static function getInstance():HighscoreScreenClass {
			return _instance
		}
		private static var _instance:HighscoreScreenClass
		private  var _PlayingLoopManagerRef:PlayingLoopManager
		
		
		
	}
}