package com.jewelmaster {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.utils.SharedObjectManager
	import com.terrypaton.utils.Debug
	import com.gs.*
	import com.gs.easing.*
	import flash.ui.Mouse;
	import com.terrypaton.media.SoundManager
	
	public class BaseControlsClass extends MovieClip {
		public function BaseControlsClass():void {
			_instance = this
			Broadcaster.addEventListener (GeneralEvents.EVAL_SOUND, evalSound);
			Broadcaster.addEventListener (GeneralEvents.HIDE_HOME_BTN, hideMainMenu);
			Broadcaster.addEventListener (GeneralEvents.SHOW_HOME_BTN, revealMainMenu);
			//Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			//_PlayingLoopManagerRef = PlayingLoopManager.getInstance ()
			if (SharedObjectManager.getInstance ().getData ("soundFXState") == undefined) {
				soundFXState = true
				SharedObjectManager.getInstance ().setData ("soundFXState",soundFXState)
			}else {
				var soundFXState:Boolean = SharedObjectManager.getInstance ().getData ("soundFXState")
			}
			if (SharedObjectManager.getInstance ().getData ("musicState") == undefined) {
				musicState = true
				SharedObjectManager.getInstance ().setData ("musicState",musicState)
			}else {
				 musicState = SharedObjectManager.getInstance ().getData ("musicState")
			}
			evalSound(null)
			setupButtons ()
		}
		private function evalSound (e:GeneralEvents):void {
			// display the sound buttons correctly
			trace ("eval Sound buttons")
			
			if (soundFXState == true) {
				soundMuteBtn.gotoAndStop(1)
			}else {
				soundMuteBtn.gotoAndStop(2)
			}
			if (musicState == true) {
				musicMuteBtn.gotoAndStop(1)
			}else {
				musicMuteBtn.gotoAndStop(2)
			}
			
		}
		private function setupButtons ():void {
			soundMuteBtn.addEventListener (MouseEvent.CLICK, btnDownHandler)
			musicMuteBtn.addEventListener(MouseEvent.CLICK,btnDownHandler)
			homeBtn.addEventListener (MouseEvent.CLICK, btnDownHandler)
			homeBtn.addEventListener (MouseEvent.MOUSE_OUT, btnOutHandler)
			homeBtn.addEventListener (MouseEvent.MOUSE_OVER, btnOverHandler)
			
			soundMuteBtn.buttonMode = true
			musicMuteBtn.buttonMode = true
			homeBtn.buttonMode = true
			
			soundMuteBtn.gotoAndStop(1)
			musicMuteBtn.gotoAndStop(1)
			homeBtn.gotoAndStop (1)
			
			soundMuteBtn.mouseChildren = false
			musicMuteBtn.mouseChildren = false
			homeBtn.mouseChildren = false
		}
		private var soundFXState:Boolean
		private var musicState:Boolean
		private function btnOutHandler (e:MouseEvent):void {
		
			MovieClip(e.target).gotoAndPlay("out")
		}
		private function btnOverHandler (e:MouseEvent):void {
				////trace(e.target)
				MovieClip(e.target).gotoAndPlay("over")
		}
		private function btnDownHandler(e:MouseEvent):void {
			////trace(e.target.name)
	
			switch(e.target.name) {
				case "soundMuteBtn":
					//_PlayingLoopManagerRef.goNextScene ( settings.GS_SETUP_NEW_GAME)
					//Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.SETUP_NEW_GAME))
					if (soundFXState) {
						soundFXState = false
						SoundManager.adjustVolume(0)
					}else {
						SoundManager.adjustVolume(1)
						soundFXState = true
					}
					SharedObjectManager.getInstance ().setData ("soundFXState",soundFXState)
					evalSound (null)
					// now mute the sound effects
					
				break
				
				case "musicMuteBtn":
					if (musicState) {
						musicState = false
						SoundManager.adjustVolume(0)
					}else {
						musicState = true
						SoundManager.adjustVolume(1)
					}
					SharedObjectManager.getInstance ().setData ("musicState",musicState)
					evalSound (null)
					// turn the music off
					trace ("SET THE MUSIC")
					
				break
				case "homeBtn":
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
				break
				
			}
		}
		
		private function revealMainMenu(e:GeneralEvents):void {
				homeBtn.visible = true
		}
		public function restart ():void {
			////trace("restarting main menu")
		}
		private function hideMainMenu(e:GeneralEvents):void {
			homeBtn.visible = false
		}
		
		public static function getInstance():BaseControlsClass {
			return _instance
		}
		private static var _instance:BaseControlsClass
		//private  var _PlayingLoopManagerRef:PlayingLoopManager
		
		
		
	}
}