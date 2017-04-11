package com.jewelmaster {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import flash.display.MovieClip
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class MainMenuClass extends MovieClip {
		public function MainMenuClass():void {
			_instance = this
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.REVEAL_MAIN_MENU))
			addEventListener (Event.REMOVED_FROM_STAGE, hideMainMenu);
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			_PlayingLoopManagerRef= PlayingLoopManager.getInstance()
		}
		
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
	
			switch(e.data.name) {
				case "playGameBtn":
					//_PlayingLoopManagerRef.goNextScene ( settings.GS_SETUP_NEW_GAME)
					//Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.SETUP_NEW_GAME))
					//DataManager.getInstance().score = 0
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.SHOW_LEVEL_CHOOSER))
					//Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_GAME_COMPLETE))
					//Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_GAME_OVER))
				break
				
				case "visitSiteBtn":
					var request:URLRequest =new URLRequest("http://www.zopy.in");
					navigateToURL(request, "_blank");
				break
				case "helpBtn":
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_HELP_SCREEN))
					
					//Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_GAME_OVER))
				break
				case "medalsBtn":
					var request:URLRequest =new URLRequest("http://www.zopy.in");
					navigateToURL(request, "_blank");
					//Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MEDALS))
				break
				case "highscoresBtn":
					//Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_HIGHSCORES))
				break
			}
		}
		private function revealMainMenu(e:GeneralEvents):void {
				
		}
		public function restart ():void {
			////trace("restarting main menu")
			sceneBack.startEffect()
		}
		private function hideMainMenu(event:Event):void {
			sceneBack.stopEffect()
		}
		
		public static function getInstance():MainMenuClass {
			return _instance
		}
		private static var _instance:MainMenuClass
		private  var _PlayingLoopManagerRef:PlayingLoopManager
		
		
		
	}
}