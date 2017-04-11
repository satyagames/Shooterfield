package com.gameshell {
	import com.terrypaton.events.GeneralEvents;
	import flash.events.MouseEvent;
	import flash.display.MovieClip
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.utils.SharedObjectManager
	import com.terrypaton.utils.Debug
	import com.gs.*
	import com.gs.easing.*
	import flash.ui.Mouse;
	import com.terrypaton.media.SoundManager
	import com.gameshell.GameShellEvents
	
	import com.gameshell.CoreDataManager
	public class BaseControls extends MovieClip {
		public function BaseControls():void {
			_instance = this
			Broadcaster.addEventListener (GeneralEvents.EVAL_SOUND, evalSound);
			Broadcaster.addEventListener (GeneralEvents.HIDE_HOME_BTN, hideMainMenu);
			Broadcaster.addEventListener (GeneralEvents.SHOW_HOME_BTN, revealMainMenu);
			//Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			//_PlayingLoopManagerRef = PlayingLoopManager.getInstance ()
			
			if (SharedObjectManager.getInstance ().getData ("soundFXState") == undefined) {
				soundFXState = 1
				SharedObjectManager.getInstance ().setData ("soundFXState", soundFXState)
			
			}else {
				 soundFXState= SharedObjectManager.getInstance ().getData ("soundFXState")
	
			}
			if (SharedObjectManager.getInstance ().getData ("musicState") == undefined) {
				musicState = 1
				SharedObjectManager.getInstance ().setData ("musicState",musicState)
			}else {
				 musicState = SharedObjectManager.getInstance ().getData ("musicState")
				 
			}
			
			CoreDataManager.getInstance().sfxState = soundFXState
			CoreDataManager.getInstance().musicState = musicState
			evalSound(null)
			setupButtons ()
		}
		private function evalSound (e:GeneralEvents):void {
			// display the sound buttons correctly
			trace ("eval Sound buttons")
			
			if (soundFXState == 1) {
				soundMuteBtn.gotoAndStop(1)
			}else {
				soundMuteBtn.gotoAndStop(2)
			}
			if (musicState == 1) {
				musicMuteBtn.gotoAndStop(1)
			}else {
				musicMuteBtn.gotoAndStop(2)
			}
			CoreDataManager.getInstance().sfxState = soundFXState
			CoreDataManager.getInstance().musicState = musicState
			
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
		private var soundFXState:int
		private var musicState:int
		private function btnOutHandler (e:MouseEvent):void {
			MovieClip(e.target).gotoAndPlay("out")
		}
		private function btnOverHandler (e:MouseEvent):void {
				MovieClip(e.target).gotoAndPlay("over")
		}
		private function btnDownHandler(e:MouseEvent):void {
			////trace(e.target.name)
	
			switch(e.target.name) {
				case "soundMuteBtn":
					if (soundFXState==1) {
						soundFXState = 0
						SoundManager.adjustVolume(0)
					}else {
						SoundManager.adjustVolume(1)
						soundFXState = 1
					}
					SharedObjectManager.getInstance ().setData ("soundFXState",soundFXState)
					evalSound (null)
					
				break
				
				case "musicMuteBtn":
					if (musicState==1) {
						musicState = 0
						musicState = 0
						GameShell.getInstance().stopMusic()
						//SoundManager.adjustVolume(0)
					}else {
						musicState = 1
						//SoundManager.adjustVolume(1)
						GameShell.getInstance().playMusic()
					}
					SharedObjectManager.getInstance ().setData ("musicState",musicState)
					evalSound (null)
					// turn the music off
					trace ("SET THE MUSIC")
					
				break
				case "homeBtn":
					Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_MAIN_MENU))
				break
				
			}
		}
		
		private function revealMainMenu(e:GeneralEvents):void {
				homeBtn.visible = true
		}
		private function hideMainMenu(e:GeneralEvents):void {
			homeBtn.visible = false
		}
		
		public static function getInstance():BaseControls {
			return _instance
		}
		private static var _instance:BaseControls
		//private  var _PlayingLoopManagerRef:PlayingLoopManager
		
		
		
	}
}