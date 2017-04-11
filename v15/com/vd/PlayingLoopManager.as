package com.vd {
	import com.terrypaton.events.PlayingLoopEvent
	import com.terrypaton.events.GeneralEvents
	import com.terrypaton.events.ButtonEvent
	import flash.events.*
	import flash.geom.*
	import com.terrypaton.media.SoundManager
	import com.gameshell.CoreDataManager
	import com.terrypaton.utils.Broadcaster
	import com.vd.*
	import com.gameshell.GameShellEvents
	public class PlayingLoopManager {
		public function PlayingLoopManager():void {
			_instance = this
			Broadcaster.addEventListener (GeneralEvents.QUIT_GAME, quitGameHandler);
			Broadcaster.addEventListener (GeneralEvents.CANCEL_QUIT_GAME, cancelQuit);
			Broadcaster.addEventListener (GeneralEvents.CONFIRM_QUIT_GAME, confirmQuit);
			Broadcaster.addEventListener (PlayingLoopEvent.INTRO_MOVIE_OVER, introMovieFinished);
			Broadcaster.addEventListener (PlayingLoopEvent.GO_NEXT_LEVEL, goNextLevel);
		
		}
		public function dispose():void {
			
		}
		public function goNextLevel(e:PlayingLoopEvent ):void {
			// remove the level complete and start the next level
			gameState = settings.GS_NEXT_LEVEL
			
		}
		public function introMovieFinished(e:PlayingLoopEvent ):void {
			Broadcaster.removeEventListener (PlayingLoopEvent.INTRO_MOVIE_OVER, introMovieFinished);
			gameState =  settings.GS_MAIN_MENU
			
		}
		public static function getInstance():PlayingLoopManager {
			return _instance
		}
		public function confirmQuit(e:GeneralEvents):void {
			goNextScene(settings.GS_MAIN_MENU)
		}
		public function cancelQuit(e:GeneralEvents):void {
			gameState = settings.GS_PLAYING
		}
		public function quitGameHandler(e:GeneralEvents):void {
			gameState = settings.GS_PAUSED
		}
		public function goNextScene(_nextScene:int):void {
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREENS))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_SCREEN_TRANSITION))
			nextScene = _nextScene
			counter = 30
			gameState = settings.GS_DELAY_SCENE_CHANGE
		}
		
		public function manageLoop():void {
			switch(gameState) {
				case settings.GS_PLAYING:
					DataManager.getInstance().manageGame()
					RenderManager.getInstance().renderGame()
				break
				case settings.GS_INIT:
					Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.INIT))
					gameState = settings.GS_INTRO_MOVIE
				break
				case settings.GS_INTRO_MOVIE:
					// set up a movie for the first time the game is run
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.SHOW_INTRO_MOVIE))
					gameState = settings.GS_INTRO_MOVIE_WAIT
				break
				case settings.GS_INTRO_MOVIE_WAIT:
				
				break
				
				case settings.GS_PAUSED:
				break
				case settings.GS_MAIN_MENU:
					//trace ("display the main menu")
					Broadcaster.broadcast(new GameShellEvents(GameShellEvents.GO_MAIN_MENU))
					gameState = settings.GS_MAIN_MENU_WAIT
				break
				
				case settings.GS_DELAY_SCENE_CHANGE:
				
				counter --
				if (counter < 1) {
					gameState = nextScene
				}
				break
				case settings.GS_MAIN_MENU_WAIT:
					//trace ("display the main menu")
					
				break
				case settings.GS_LEVEL_COMPLETE:
					// test if it's level or game complete
					
					
						Broadcaster.broadcast(new GameShellEvents(GameShellEvents.SHOW_LEVEL_COMPLETE_MESSAGE))
						counter = 20
						gameState = settings.GS_LEVEL_COMPLETE_WAIT
						
				break
				case settings.GS_LEVEL_COMPLETE_WAIT:
				
					Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.MANAGE_PLAYER))
					DataManager.getInstance().manageGame()
					RenderManager.getInstance().renderGame()
					if (counter > 0) {
						//trace("counter :"+counter)
						counter--
						if (counter < 1) {
							if (DataManager.getInstance().level > 9) {
									Broadcaster.broadcast(new GameShellEvents(GameShellEvents.GO_GAME_COMPLETE))
								gameState = settings.GS_GAME_COMPLETE
							}else {
								Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.SHOW_LEVEL_CHOOSER))
								gameState = settings.GS_PAUSED
							}
							
						}
					}
					
				
				//
				break
				case settings.GS_GAME_COMPLETE:
				
					
				break
				case settings.GS_SETUP_NEW_GAME:
					Broadcaster.broadcast(new GameShellEvents(GameShellEvents.GO_GAME_SCREEN))
					DataManager.getInstance().setup()
					RenderManager.getInstance().setup()
					
					Broadcaster.broadcast(new VDEvents(VDEvents.UPDATE_HUD))
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.SETUP_NEW_GAME))
					counter =130
					//DataManager.getInstance().activePowerUp(settings.POWERUP_RAPID_FIRE)
					//DataManager.getInstance().activePowerUp(settings.POWERUP_BIG_BULLET)
					//DataManager.getInstance().activePowerUp(settings.POWERUP_SPRAY_1)
					//DataManager.getInstance().activePowerUp(settings.POWERUP_SPRAY_2)
					//DataManager.getInstance().activePowerUp(settings.POWERUP_LASER)
					RenderManager.getInstance().zoomWorld()
					RenderManager.getInstance().renderGame()
					gameState =settings.GS_SETUP_NEW_GAME_WAIT
				break
				case settings.GS_NEXT_LEVEL:
					counter = 40
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.GO_NEXT_LEVEL))
					gameState = settings.GS_NEXT_LEVEL_WAIT
				break
				case settings.GS_NEXT_LEVEL_WAIT:
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.MANAGE_DINO))
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.MANAGE_PLAYER))
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.RENDER_SCREEN))
					
					//trace("counter :"+counter)
					counter--
					if (counter < 1) {
						//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.GO_NEXT_LEVEL))
						gameState =settings.GS_PLAYING
					}
				break
				
				case settings.GS_SETUP_NEW_GAME_WAIT:
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.MANAGE_PLAYER))
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.RENDER_SCREEN))
					counter--
					if (counter == 60) {
						Broadcaster.broadcast(new VDEvents(VDEvents.REVEAL_HUD))
						
					}
					if (counter == 35) {
						Broadcaster.broadcast(new VDEvents(VDEvents.REVEAL_PLAYER))
					}
					if (counter < 1) {
						//var temp:Point = new Point(-10,240)
						//var temp:Point = new Point(200,240)
						//GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER,settings.BLOCKER_1)
						//GenericItemManager.getInstance().addItem(temp, settings.ITEM_POWER_UP,settings.POWERUP_SPRAY_2)
						
						gameState =settings.GS_PLAYING
					}
				break
				
				case settings.GS_GAME_OVER:
					trace ("game over")
					startCounter (60)
					Broadcaster.dispatchEvent (new GeneralEvents (GeneralEvents.HIDE_HUD))
					//Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.RENDER_SCREEN))
					// display the game over screen
					//Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREEN_TRANSITION))
					
					gameState = settings.GS_GAME_OVER_WAIT
				break
				case settings.GS_GAME_OVER_WAIT:
					counter --
					if (counter < 1) {
						startCounter(30)
						Broadcaster.dispatchEvent (new GeneralEvents (GeneralEvents.SHOW_SCREEN_TRANSITION))
						RenderManager.getInstance()._RotatingSphere.stopSphere()
						gameState = settings.GS_GAME_OVER_WAIT_2
					}
					Broadcaster.broadcast(new PlayingLoopEvent(PlayingLoopEvent.RENDER_SCREEN))
				break
				case settings.GS_GAME_OVER_WAIT_2:
					counter --
					if (counter < 1) {
						Broadcaster.broadcast(new GameShellEvents(GameShellEvents.GO_GAME_OVER))
						Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREEN_TRANSITION))
						
						gameState = settings.GS_GAME_OVER_WAIT_3
					}
					
				break
				case settings.GS_GAME_OVER_WAIT_3:
					
					
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
