package com.jewelmaster {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import flash.display.MovieClip
	import flash.text.*
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.utils.SharedObjectManager
	import com.gs.*
	import com.gs.easing.*
	import flash.events.*
	public class MedalsScreenClass extends MovieClip {
		public function MedalsScreenClass():void {
			_instance = this
			Broadcaster.addEventListener(PlayingLoopEvent.GO_MEDALS,restart)
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			Broadcaster.addEventListener (ButtonEvent.OVER, btnOverHandler);
			Broadcaster.addEventListener (ButtonEvent.OUT, btnOutHandler);
			_PlayingLoopManagerRef = PlayingLoopManager.getInstance()
			addEventListener (Event.REMOVED_FROM_STAGE, hideMedals);
		}
		private function btnOutHandler (e:ButtonEvent):void {
			medalText.text = "ROLL OVER A MEDAL"
		}
		private function btnOverHandler (e:ButtonEvent):void {
			var testBtnString:String = e.data.name
			if (testBtnString.indexOf ("medalBtn") > -1) {
				//trace ("its a medal button")
				var medalBtnNum:int = Number (testBtnString.charAt (8))
				var clipName:String = "medalBtn" + medalBtnNum
				var _clip:MovieClip = MovieClip (getChildByName (clipName))
				displayMedalText (medalBtnNum,_clip)
				
			}
		}
		private function hideMedals(event:Event):void {
			sceneBack.stopEffect()
		}
		private function btnDownHandler(e:ButtonEvent):void {
			////////trace(e.data.name)
	
			switch(e.data.name) {
				case "mainMenuBtn":
					//_PlayingLoopManagerRef.goNextScene ( settings.GS_SETUP_NEW_GAME)
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
				break
				
			}
			
		}
		public var medalTextArray:Array =["GAME COMPLETED","CLEARED ALL DIRT FROM A LEVEL","DIED 100 DEATHS","10 ENEMIES SQUASHED","30 ENEMIES SQUASHED","500 TREASURE COLLECTED","1000 TREASURE COLLECTED","200 GAMES PLAYED"]
		private function displayMedalText (_num:int,_clip:MovieClip):void {
		medalText.text = medalTextArray[_num - 1]
			if (_clip.unlocked) {
					medalText.appendText("\nYou've got this medal!")
				}
		
		}
		private var unlockedMedals:Array
		public function restart (event:PlayingLoopEvent):void {
			////trace ("restarting medals screen")
			// display all the medal icons properly
			sceneBack.startEffect()
			// medalBack
			medalText.text = "Roll over a medal"
			unlockedMedals = SharedObjectManager.getInstance ().getData ("medalsUnlocked")
			
			if (unlockedMedals == null ) {
				trace("no medal data found")
				unlockedMedals = new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
			}
			trace("unlockedMedals:"+unlockedMedals)
			////trace ("unlockedMedals = " + unlockedMedals)
			// go through all medals and show them locked or unlocked
			for (var i:int = 1; i < 9; i++) {
				var clipName:String = "medalBtn" + i
				var _clip:MovieClip = MovieClip(getChildByName(clipName))
				if (unlockedMedals[i - 1] == 1) {
					//_clip.lockedIcon.visible = false
					_clip.gotoAndStop(i+1)
					_clip.unlocked = true
				}else {
					_clip.gotoAndStop(1)
					_clip.unlocked = false
					_clip.btnMode = false
				}
				//_clip.medalBack.rotation = Math.random()*20-10
				_clip.useRollOver = false
			}
			
		}
		private function hideMainMenu():void {
			
		}
		
		public static function getInstance():MedalsScreenClass {
			return _instance
		}
		private static var _instance:MedalsScreenClass
		private  var _PlayingLoopManagerRef:PlayingLoopManager
		
		
		
	}
}