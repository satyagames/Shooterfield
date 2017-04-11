package com.jewelmaster {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import flash.display.MovieClip
	import com.terrypaton.utils.Broadcaster
	import flash.events.MouseEvent
	import com.gs.*
	import com.terrypaton.utils.Debug
	import com.gs.easing.*
	import flash.events.*
	public class HelpScreenClass extends MovieClip {
		public function HelpScreenClass():void {
			_instance = this
			//Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.REVEAL_MAIN_MENU))
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			Broadcaster.addEventListener (PlayingLoopEvent.GO_HELP_SCREEN, restart);
			_PlayingLoopManagerRef = PlayingLoopManager.getInstance ()
			addEventListener (Event.REMOVED_FROM_STAGE, hideHelp);
		}
	
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
	
			switch(e.data.name) {
				case "leftHelpArrow":
				if (leftHelpArrow.buttonMode){
					helpPage--
					evalHelp ()
				}
				break
				case "rightHelpArrow":
				if (rightHelpArrow.buttonMode){
					helpPage++
					evalHelp ()
				}
				break
				case "mainMenuBtn":
					//_PlayingLoopManagerRef.goNextScene ( settings.GS_SETUP_NEW_GAME)
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
				break
				
			}
		}
	
		private function evalHelp ():void {
			helpClipData.gotoAndStop(helpPage)
			if (helpPage <2) {
				leftHelpArrow.buttonMode = false
				//leftHelpArrow.alpha = .5
				TweenLite.to(leftHelpArrow,.5,{x:-42})
			}else {
				leftHelpArrow.buttonMode = true
				//leftHelpArrow.alpha = 1
				TweenLite.to(leftHelpArrow,.5,{x:38.5})
			}
			if (helpPage >1) {
				rightHelpArrow.buttonMode = false
				rightHelpArrow.alpha = .5
					TweenLite.to(rightHelpArrow,.5,{x:685})
			}else {
				rightHelpArrow.buttonMode = true
				rightHelpArrow.alpha = 1
				TweenLite.to(rightHelpArrow,.5,{x:598})
			}
				
		}
		public function restart (e:PlayingLoopEvent):void {
			//trace ("restarting help screen")
			Debug.log ("restarting help screen")
				leftHelpArrow.x = -42
		rightHelpArrow.x = 685
			evalHelp ()
			sceneBack.startEffect()
		}
		private function hideHelp(event:Event):void {
			sceneBack.stopEffect()
		}
	
		
		public static function getInstance():HelpScreenClass {
			return _instance
		}
		private static var _instance:HelpScreenClass
		private  var _PlayingLoopManagerRef:PlayingLoopManager
			private var helpPage:int = 1
		
		
	}
}