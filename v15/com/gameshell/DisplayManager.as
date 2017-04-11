package com.gameshell{
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.ButtonEvent;
	import com.terrypaton.events.HighscoreEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.terrypaton.utils.Stats;
	import com.terrypaton.utils.Broadcaster;
	import com.terrypaton.events.PlayingLoopEvent;
	import flash.geom.ColorTransform;
	import com.terrypaton.utils.SeededRandomNumber
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.gameshell.GameShellEvents
	import com.gameshell.MedalsScreen
	import com.vd.settings
	import com.gs.*
	import com.gs.easing.*
	import com.terrypaton.media.SoundManager
	import com.terrypaton.utils.SharedObjectManager
	
	public class DisplayManager extends MovieClip {
		
		public function DisplayManager ():void {
			_instance = this;
			sprite_GameHolder = new Sprite();
			sprite_MenuHolder = new Sprite();
			sprite_StatsSprite = new Sprite();
			sprite_Transitions = new Sprite ();
			
			addChild (sprite_GameHolder);
			addChild (sprite_MenuHolder);
			addChild (sprite_Transitions);
			// stats sprite
			addChild (sprite_StatsSprite);
			//
			sprite_StatsSprite.visible = false;
			sprite_StatsSprite.addChild (new Stats ());
			//
			//_DataManagerRef = DataManager.getInstance();
			setupListeners ();
			setupGraphics ();
			addChild(clip_medalUnlocked)
			clip_medalUnlocked.x = 320
			clip_medalUnlocked.y = -45
			clip_medalUnlocked.visible = false
			addChild (baseControls_clip)
			baseControls_clip.x = 640
			sprite_GameHolder.scrollRect = new Rectangle(0, 0, 640, 480)
		}
		
		private function medalUnlocked(e:GameShellEvents):void {
			//trace("medal unlocked")
			var testMedal:int = e.data.medalUnlocked
			trace("testing medal num: " + testMedal)
			
			var medalsArray:Array = SharedObjectManager.getInstance ().getData ("medalsUnlocked")
			if (medalsArray == null){
				medalsArray = new Array(0,0,0,0,0,0,0,0,0,0,0,0)
			}
			if (medalsArray[testMedal] == 0) {
				playSound("medalAwarded.wav")
				clip_medalUnlocked.visible = true
				clip_medalUnlocked.y = -45
				TweenLite.to(clip_medalUnlocked,1,{y:83})
				TweenLite.to(clip_medalUnlocked, 1, { y: -45, delay:3, overwrite:false, onComplete:hideMedalsPanel } )
				medalsArray[testMedal] = 1
				clip_medalUnlocked.textBox.text = MedalsScreen.getInstance().medalTextArray[testMedal]
				trace(MedalsScreen.getInstance().medalTextArray[testMedal])
				clip_medalUnlocked.medalBadge.gotoAndStop(testMedal+2)
			}
			trace("set the medal array data - medalsArray:"+medalsArray)
			SharedObjectManager.getInstance().setData("medalsUnlocked",medalsArray)
		}
		private function hideMedalsPanel():void {
			clip_medalUnlocked.visible  = false
		}
		public static function getInstance ():DisplayManager {
			return _instance;
		}
		public function displayLevelCompleteMsg (e:GameShellEvents):void {
			
			sprite_MenuHolder.addChild ( levelCompleteMsg)
			levelCompleteMsg.textBox.text = "LEVEL "+CoreDataManager.getInstance().lastLevelCompleted+" COMPLETE"
			levelCompleteMsg.x = -145
			levelCompleteMsg.y = 240
			TweenLite.to(levelCompleteMsg,.75,{x:320})
		}
		public function goGame (e:GameShellEvents):void {
			var gamesPlayedCount:int = CoreDataManager.getInstance().GAMES_PLAYED
			gamesPlayedCount ++
			CoreDataManager.getInstance().GAMES_PLAYED  = gamesPlayedCount
			if (gamesPlayedCount == 100) {
				var _data:Object = new Object()
				_data.medalUnlocked = settings.MEDAL_100_GAMES_PLAYED;
				Broadcaster.dispatchEvent (new GameShellEvents(GameShellEvents.MEDAL_UNLOCKED,true,_data));
			}
										
										
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_HOME_BTN))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREEN_TRANSITION))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREENS))
			sprite_GameHolder.addChild (gamePlay_clip)
			stage.focus = gamePlay_clip
			//
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.REVEAL_GAME_HUD))
			playSound("zoomToPlanet.wav")
		}
		private function hideGame():void {
			
		}
		public function removeTheMovieClip(e:GeneralEvents):void {
			try {
				var _clip:MovieClip = e.data.clip
				_clip.parent.removeChild(_clip)
				}
			catch (e:Error) {
				
			}
			
		
		}
		public function goMainMenu (e:GameShellEvents):void {
			// show the main menu panel
			
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.EVAL_SOUND))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_HOME_BTN))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREENS))
			sprite_MenuHolder.addChild (MainMenu_clip);
			MainMenu_clip.restart()
			MainMenu_clip.gotoAndPlay("in")
		}
		private function goNextLevel(e:PlayingLoopEvent):void {
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_HOME_BTN))
			levelComplete_clip.gotoAndPlay("out")
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.REVEAL_GAME_HUD))
			
		}
		public function goLevelComplete (e:GameShellEvents):void {
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_HOME_BTN))
			trace ("tell the hud to be put away")
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_HUD))
			//sprite_GameHolder.addChild (levelComplete_clip);
			//levelComplete_clip.gotoAndPlay("in")
			
		}
		public function goGameComplete (e:GameShellEvents):void {
			var _data:Object = new Object()
			_data.medalUnlocked = settings.MEDAL_GAME_COMPLETED;
			Broadcaster.dispatchEvent (new GameShellEvents(GameShellEvents.MEDAL_UNLOCKED, true, _data));
											
			GameShell.getInstance().saveCoreData()
			
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_HOME_BTN))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_HUD))
			if (gameComplete_clip == null) {
				gameComplete_clip = new gameCompleteClip()
			}
			
			playSound("gameCompleted.wav")
			sprite_MenuHolder.addChild (gameComplete_clip);
			//gameComplete_clip.gotoAndPlay ("in")
			gameComplete_clip.restart()
		}
		public function goMedals (e:GameShellEvents):void {
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_HOME_BTN))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREENS))
			sprite_MenuHolder.addChild (medalsScreen_clip);
			medalsScreen_clip.gotoAndPlay("in")
		}
		
		public function goLevelChooser (e:GameShellEvents):void {
			Broadcaster.dispatchEvent (new GeneralEvents (GeneralEvents.SHOW_HOME_BTN))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREENS))
			sprite_MenuHolder.addChild (levelChooserScreen_clip);
			//levelChooserScreen_clip.restart()
			//levelChooserScreen_clip.gotoAndPlay("in")
		}
		public function goHighscoreScreen (e:GameShellEvents):void {
			// trace ("display manager", "goHighscoreScreen")
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_HOME_BTN))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREENS))
			sprite_MenuHolder.addChild (highscoreScreen_clip);
			highscoreScreen_clip.gotoAndPlay ("in")
			Broadcaster.dispatchEvent(new HighscoreEvent(HighscoreEvent.SHOW_HIGH_SCORES))
		}
		
		public function goHelpScreen (e:GameShellEvents):void {
			//trace("display manager","show help screen")
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_HOME_BTN))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREENS))
			sprite_MenuHolder.addChild (howToPlay_clip);
			howToPlay_clip.gotoAndPlay("in")
		}
		
			
		
		public function goGameOverScreen (e:GameShellEvents):void {
			GameShell.getInstance().saveCoreData()
			////trace("go game over")
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.SHOW_HOME_BTN))
			Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.HIDE_SCREENS))
			sprite_MenuHolder.addChild (gameOver_clip);
			gameOver_clip.gotoAndPlay ("in")
			playSound("gameOver.wav")
			
		}
	
		public function playSound(_sound : String):void {
			if (CoreDataManager.getInstance().sfxState == 1) {
				//trace("play sound - "+_sound)
				SoundManager.playSound(_sound);
			}
		}
		public function renderGame (e:PlayingLoopEvent):void {
			
		
		
		}
		public function updateLives(e:GeneralEvents):void {
		
			
		}
		private var _tempPoint:Point = new Point()
		
		public function toggleStats (e:PlayingLoopEvent) {
			sprite_StatsSprite.visible = ! sprite_StatsSprite.visible;
		}
		private function setupGraphics () {
			MainMenu_clip = new mainMenuScreen()
			howToPlay_clip = new helpScreen()
			highscoreScreen_clip = new highscoreScreen()
			levelChooserScreen_clip = new levelChooserScreen()
			medalsScreen_clip = new medalsScreen ()
			gameOver_clip = new gameOverClip ()
			levelCompleteMsg = new levelCompleteMsgClip()
			gamePlay_clip = new gamePlayClip()
			baseControls_clip = new baseControls ()
			
			clip_medalUnlocked = new medalUnlockedClip()
		}
		private var clip_medalUnlocked:MovieClip
		private function hideScreens (e:GeneralEvents):void {
			// put all screens away
			
			try {
				sprite_MenuHolder.removeChild (levelCompleteMsg);
			}catch (e:Error) {
			}
			try {
				sprite_MenuHolder.removeChild (MainMenu_clip);
			}catch (e:Error) {
			}
			try {
				sprite_MenuHolder.removeChild (levelChooserScreen_clip);
			}catch (e:Error) {
			}
			try {
				sprite_MenuHolder.removeChild (highscoreScreen_clip);
			}catch (e:Error) {
				
			}
			try {
				sprite_MenuHolder.removeChild (medalsScreen_clip);
			}catch (e:Error) {
				
			}
			try {
				sprite_MenuHolder.removeChild (gameOver_clip);
			}catch (e:Error) {
				
			}
				try {
				sprite_MenuHolder.removeChild (howToPlay_clip);
			}catch (e:Error) {
				
			}
			try {
				sprite_GameHolder.removeChild (gamePlay_clip);
			}catch (e:Error) {
				
			}
			try {
				sprite_MenuHolder.removeChild (gameComplete_clip);
			}catch (e:Error) {
				
			}
			
		}
		
		private function setupListeners () {
			// //C.ch("display manager", "setupListeners()");
			Broadcaster.addEventListener (PlayingLoopEvent.TOGGLE_STATS, toggleStats);
			Broadcaster.addEventListener (PlayingLoopEvent.RENDER_SCREEN, renderGame);
			Broadcaster.addEventListener (GameShellEvents.GO_GAME_SCREEN, goGame);
			Broadcaster.addEventListener (GameShellEvents.GO_HELP_SCREEN, goHelpScreen);
			Broadcaster.addEventListener (GameShellEvents.GO_HIGHSCORES, goHighscoreScreen);
			Broadcaster.addEventListener (GameShellEvents.GO_MAIN_MENU, goMainMenu);
			Broadcaster.addEventListener (GameShellEvents.DISPLAY_LEVEL_COMPLETE, displayLevelCompleteMsg);
			Broadcaster.addEventListener (GameShellEvents.GO_LEVEL_COMPLETE, goLevelComplete);
			Broadcaster.addEventListener (PlayingLoopEvent.DISPLAY_GAME_COMPLETE, goGameComplete);
			Broadcaster.addEventListener(GeneralEvents.UPDATE_LIVES, updateLives)
			Broadcaster.addEventListener (GameShellEvents.GO_GAME_OVER, goGameOverScreen);
			Broadcaster.addEventListener (GeneralEvents.QUIT_GAME, displayQuitGameConfirmation);
			Broadcaster.addEventListener (GeneralEvents.CANCEL_QUIT_GAME, hideQuitGameConfirmation);
			Broadcaster.addEventListener (GeneralEvents.CONFIRM_QUIT_GAME, hideQuitGameConfirmation);
			Broadcaster.addEventListener (PlayingLoopEvent.GO_NEXT_LEVEL, goNextLevel);
			Broadcaster.addEventListener (GeneralEvents.REMOVE_MOVIECLIP, removeTheMovieClip);
			
			Broadcaster.addEventListener (GeneralEvents.HIDE_SCREENS, hideScreens);
			Broadcaster.addEventListener (GameShellEvents.SHOW_LEVEL_CHOOSER, goLevelChooser);
			Broadcaster.addEventListener (GameShellEvents.GO_MEDALS, goMedals);
			Broadcaster.addEventListener (HighscoreEvent.CLOSE_HIGHSCORES, goMainMenu);
			Broadcaster.addEventListener (GameShellEvents.SHOW_LEVEL_COMPLETE_MESSAGE, displayLevelCompleteMsg);
			Broadcaster.addEventListener (GameShellEvents.GO_GAME_COMPLETE, goGameComplete);
			Broadcaster.addEventListener (GameShellEvents.MEDAL_UNLOCKED, medalUnlocked);
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
		}
		private function btnDownHandler (e:ButtonEvent):void {
			if (e.data.name =="mainMenuBtn"){
				Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_MAIN_MENU))
			}
		}
		private function displayQuitGameConfirmation(e:GeneralEvents):void {
			sprite_MenuHolder.addChild(confirmQuit_clip)
			confirmQuit_clip.x = 450
			confirmQuit_clip.y = -100
			TweenMax.to(confirmQuit_clip,1,{y:200,ease:Cubic.easeOut})
		}
		private function removeMovie(_clip:MovieClip):void {
			_clip.parent.removeChild(_clip)
		}
		private function hideQuitGameConfirmation(e:GeneralEvents):void {
			TweenMax.to(confirmQuit_clip,.6,{y:-200,ease:Quint.easeIn,onComplete:removeMovie,onCompleteParams:[confirmQuit_clip]})
		}
		public var sprite_StatsSprite:Sprite;
		private var sprite_GameHolder:Sprite;
		private var sprite_MenuHolder:Sprite;
		private var sprite_Transitions:Sprite;
		private var gamebackground_clip:MovieClip;
		private var screenTransition_clip:MovieClip;
		private var player_clip:MovieClip;
		private var gameBitmapData:BitmapData;
		private var gameBitmap:Bitmap;
		private var renderMatrix:Matrix = new Matrix();
		//private var _DataManagerRef:DataManager;
		private static  var _instance:DisplayManager;
		private var _playerLoc:Point;
		private var levelCompleteMsg:MovieClip;
		private var gamePlay_clip:MovieClip;
		private var levelComplete_clip:MovieClip;
		private var gameComplete_clip:MovieClip;
		private var gameOver_clip:MovieClip;
		private var download_clip:MovieClip;
		private var howToPlay_clip:MovieClip;
		private var highscoreScreen_clip:MovieClip;
		private var MainMenu_clip:MovieClip;
		private var confirmQuit_clip:MovieClip;
		private var HUD_clip:MovieClip;
		private var levelChooserScreen_clip:MovieClip;
		private var medalsScreen_clip:MovieClip;
		private var baseControls_clip:MovieClip;
		
	
	}
}