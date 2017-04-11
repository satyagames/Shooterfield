package com.jewelmaster {
	import com.terrypaton.events.PlayingLoopEvent
	import com.terrypaton.events.GeneralEvents
	import com.terrypaton.events.ButtonEvent
	import flash.events.*
	import com.jewelmaster.DataManager
	import com.terrypaton.utils.Broadcaster
	import flash.events.*
	import com.terrypaton.utils.SharedObjectManager
	import com.terrypaton.effect.particleManagerClass
	public class PlayingLoopManager extends EventDispatcher{
		public function PlayingLoopManager():void {
			_instance = this
			Broadcaster.addEventListener(PlayingLoopEvent.SETUP_NEW_GAME,setupNewGame)
		}
		
		public function setupNewGame (e:PlayingLoopEvent):void {
			////trace("SETUP NEW GAME")
			gameState = settings.GS_PLAYING
			
		}
		
		public static function getInstance():PlayingLoopManager {
			return _instance
		}
		
		public function manageLoop ():void {
		//////trace("loop")
			switch(gameState) {
				case settings.GS_PLAYING:
					DataManager.getInstance().Update()
				break
				case settings.GS_SWAPPING:
					DataManager.getInstance ().Update ()
					counter = 10
					gameState = settings.GS_SWAPPING_WAIT
				break
				case settings.GS_SWAPPING_WAIT:
					counter--
					if (counter < 1) {
						// test for matches
					
						DataManager.getInstance().testForMatches()
						gameState = settings.GS_PLAYING
					}
				break
				case settings.GS_PLAYER_DEATH:
					counter = 60
					// render the player dying
					
					DataManager.getInstance().Update()
					gameState = settings.GS_PLAYER_DEATH_WAIT
				break
				case settings.GS_PLAYER_DEATH_WAIT:
					DataManager.getInstance ().Update ()
				
				if (counter < 30) {
						Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.START_PIXELATE))
				}else {
					RenderManager.getInstance().particleEffect(4,DataManager.getInstance()._PlayerClassRef._ix+Math.random()*40-20,DataManager.getInstance()._PlayerClassRef._iy+Math.random()*40-20)
				RenderManager.getInstance().particleEffect(3,DataManager.getInstance()._PlayerClassRef._ix+Math.random()*40-20,DataManager.getInstance()._PlayerClassRef._iy+Math.random()*40-20)
				}
					counter--
					if (counter < 1) {
						Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.STOP_PIXELATE))
						//DataManager.getInstance().playerLosesALife ()
						gameState = settings.GS_PLAYER_DEATH_WAIT_2
						////trace("tell the player, life lost")
					
				}
				break
				case settings.GS_PLAYER_DEATH_WAIT_2:
					particleManagerClass.getInstance().killAllParticles()
					// count down, then restart the level if the player still has lives left
					if (DataManager.getInstance ().lives < 1) {
						gameState = settings.GS_GAME_OVER
						
					}else {
						DataManager.getInstance ().setupLevel()
						gameState = settings.GS_PLAYING
					}
				
				break
				case settings.GS_LEVEL_COMPLETE:
					DataManager.getInstance ().Update ()
					counter = 80
					gameState = settings.GS_LEVEL_COMPLETE_WAIT
				break
				case settings.GS_LEVEL_COMPLETE_WAIT:
				// render particles all over the screen
					DataManager.getInstance ().celebrateLevelComplete()
					DataManager.getInstance ().Update ()
					counter--
					
					
					if (counter < 1) {
						gameState = settings.GS_LEVEL_COMPLETE_WAIT
						var levelsUnlocked:int = SharedObjectManager.getInstance ().getData ("levelunlocked")
						trace ("levelsUnlocked = " + levelsUnlocked)
						
						if (DataManager.getInstance ().level < 100) {
								Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.SHOW_LEVEL_CHOOSER))
						}else {
								Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_GAME_COMPLETE))
						}
					gameState =  settings.GS_LEVEL_COMPLETE_WAIT_2
					}
				break
				case settings.GS_LEVEL_COMPLETE_WAIT_2:
				
				break
				case settings.GS_GAME_OVER:
					Broadcaster.dispatchEvent (new PlayingLoopEvent (PlayingLoopEvent.GO_GAME_OVER))
					gameState = settings.GS_GAME_OVER_WAIT_2
				break
				case settings.GS_GAME_OVER_WAIT_2:
					
				break
				case settings.GS_PAUSED:
				break
				
			}
		}
		public function startCounter(_num:int):void {
			counter = _num
		}
		public var gameState:int
		public var counter:int
		public var nextScene:int
		private static var _instance:PlayingLoopManager
	}
}
