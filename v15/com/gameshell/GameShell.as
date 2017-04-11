package com.gameshell {
	
	import com.terrypaton.events.KeyBoardEvents
	import flash.display.*;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	//import com.mochi.as3.*
	import com.terrypaton.utils.Debug
	import com.terrypaton.utils.SharedObjectManager
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.events.PlayingLoopEvent
	import com.terrypaton.events.HighscoreEvent
	import com.terrypaton.events.ButtonEvent
	import com.gameshell.CoreDataManager
	import com.gameshell.DisplayManager
	import com.terrypaton.media.SoundManager
	import flash.media.*
	public class GameShell extends MovieClip {
		
		public function GameShell ():void {
			_instance = this
			_CoreDataManagerRef = new CoreDataManager ()
			
			
			_DisplayManagerRef = new DisplayManager ()
			addChild (_DisplayManagerRef)
			highscoreBlocker = new highscoreBlockerClip ()
			highscoreBlocker.mouseEnabled = true
			highscoreHolder = new MovieClip ()
			addChild (highscoreBlocker)
			highscoreBlocker.visible = false
			addChild(highscoreHolder)
			//com.mochi.as3.MochiServices.connect("38f48f049b2ad5e0", highscoreHolder,noMochiScores);
			trace ("Shared object:" + SharedObjectManager.getInstance ().getData ("levelunlocked"))
			// set up medals unlocked
			if ( SharedObjectManager.getInstance ().getData ("medalsUnlocked") == null) {
				trace("can't find the shared object data")
				//var medalsArray:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
				//SharedObjectManager.getInstance().setData("medalsUnlocked",medalsArray)
			}
			//var medalsArray:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			//SharedObjectManager.getInstance().setData("medalsUnlocked",medalsArray)
			if ( SharedObjectManager.getInstance ().getData ("livesLost") == null) {
				SharedObjectManager.getInstance().setData("livesLost",0)
			}
			if ( SharedObjectManager.getInstance ().getData ("ENEMY_VECTORS_DESTROYED") == null) {
				SharedObjectManager.getInstance().setData("ENEMY_VECTORS_DESTROYED", 0)
				_CoreDataManagerRef.ENEMY_VECTORS_DESTROYED = 0
				_CoreDataManagerRef.BULLETS_FIRED = 0
				_CoreDataManagerRef.SATELITES_DESTROYED = 0
				_CoreDataManagerRef.PLANETS_DEFENDED = 0
				_CoreDataManagerRef.GAMES_PLAYED = 06
			}else {
				_CoreDataManagerRef.ENEMY_VECTORS_DESTROYED = SharedObjectManager.getInstance ().getData ("ENEMY_VECTORS_DESTROYED")
				_CoreDataManagerRef.BULLETS_FIRED = SharedObjectManager.getInstance ().getData ("BULLETS_FIRED")
			_CoreDataManagerRef.SATELITES_DESTROYED = SharedObjectManager.getInstance ().getData ("SATELITES_DESTROYED")
			_CoreDataManagerRef.PLANETS_DEFENDED = SharedObjectManager.getInstance ().getData ("PLANETS_DEFENDED")
			_CoreDataManagerRef.GAMES_PLAYED = SharedObjectManager.getInstance ().getData ("GAMES_PLAYED")
			}
			
				//SharedObjectManager.getInstance ().setData ("levelunlocked",1)
			trace("_CoreDataManagerRef.BULLETS_FIRED = "+_CoreDataManagerRef.BULLETS_FIRED)
			
			 
			
			////trace("medalsArray = "+medalsArray)
			Broadcaster.broadcast (new GameShellEvents (GameShellEvents.GO_MAIN_MENU))
			Broadcaster.addEventListener (HighscoreEvent.SUBMIT_HIGH_SCORE, submitHighscore)
			Broadcaster.addEventListener (HighscoreEvent.SHOW_HIGH_SCORES, revealHighscoreChart)
			Broadcaster.addEventListener (ButtonEvent.OVER, btnOverHandler);
			Broadcaster.addEventListener (ButtonEvent.OUT, btnOutHandler);
			stage.addEventListener (KeyboardEvent.KEY_DOWN, keyDownHandler)
			stage.addEventListener (KeyboardEvent.KEY_UP, keyUpHandler)
			trace("CoreDataManager.getInstance().sfxState = "+CoreDataManager.getInstance().sfxState)
			if (CoreDataManager.getInstance().sfxState == 1) {
				SoundManager.playSound("welcome.wav")
			}
			_musicSound = new musicSound()
			if (SharedObjectManager.getInstance ().getData ("musicState") == 1) {
				playMusic()
			}
		}
		public function playMusic():void {
			try {
				_musicChannel.stop()
				}catch (e:Error) {
				
			}
			
			_musicChannel = _musicSound.play(0,9999)
		}
		public function stopMusic():void {
			_musicChannel.stop()
		}
		private var _musicChannel:SoundChannel
		private static var _musicSound:Sound;
		public function saveCoreData():void {
			SharedObjectManager.getInstance ().setData ("ENEMY_VECTORS_DESTROYED", _CoreDataManagerRef.ENEMY_VECTORS_DESTROYED) 
			SharedObjectManager.getInstance ().setData ("BULLETS_FIRED", _CoreDataManagerRef.BULLETS_FIRED )
			SharedObjectManager.getInstance ().setData ("SATELITES_DESTROYED", _CoreDataManagerRef.SATELITES_DESTROYED )
			SharedObjectManager.getInstance ().setData ("PLANETS_DEFENDED", _CoreDataManagerRef.PLANETS_DEFENDED )
			SharedObjectManager.getInstance ().setData ("GAMES_PLAYED", _CoreDataManagerRef.GAMES_PLAYED)
		}
		private function btnOverHandler (e:ButtonEvent):void {
			DisplayManager.getInstance().playSound("mouseOver.wav")
			var testBtnString:String = e.data.name
			if (testBtnString.indexOf ("medalBtn") > -1) {
				// dont sheen the medals
			}else {
				MovieClip(e.data.target).gotoAndPlay("over")
			}
			
		}
		private function btnOutHandler (e:ButtonEvent):void {
			var testBtnString:String = e.data.name
			if (testBtnString.indexOf ("medalBtn") > -1) {
				// dont sheen the medals
			}else {
				MovieClip(e.data.target).gotoAndPlay("out")
			}
		
		}
		public var highscoreHolder:MovieClip
		public var highscoreBlocker:MovieClip
		public function init ():void {
			
		}
		private var _data:Object = new Object()
		public function keyDownHandler (e:KeyboardEvent):void {
			_data.keyCode = e.keyCode
			Broadcaster.dispatchEvent (new KeyBoardEvents(KeyBoardEvents.KEY_PRESS,true,_data))
		}
		public function keyUpHandler (e:KeyboardEvent):void {
			_data.keyCode = e.keyCode
			Broadcaster.dispatchEvent (new KeyBoardEvents(KeyBoardEvents.KEY_RELEASE,true,_data))
		}
		private function submitHighscore (e:HighscoreEvent):void {
			var score:int = e.data.score
			highscoreBlocker.visible = true
			trace ("trying to submit score : " + score)
						
			/*var o:Object = { n: [4, 5, 0, 8, 3, 6, 6, 12, 15, 12, 2, 10, 15, 8, 13, 5], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
var boardID:String = o.f(0,"");
com.mochi.as3.MochiScores.showLeaderboard ( { clip:this, boardID: boardID, score: score, onClose: closeHighscores, onError: highscoreError } );*/
		
		}
		private function revealHighscoreChart (e:HighscoreEvent):void {
			highscoreBlocker.visible = true
			/*var o:Object = { n: [4, 5, 0, 8, 3, 6, 6, 12, 15, 12, 2, 10, 15, 8, 13, 5], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
		
var boardID:String = o.f(0,"");
com.mochi.as3.MochiScores.showLeaderboard({clip:this, boardID: boardID, onClose: closeHighscores, onError: highscoreError});*/
		
		
	}
	private function closeHighscores ():void {
		highscoreBlocker.visible =false
		trace("close high scores")
		dispatchEvent (new HighscoreEvent (HighscoreEvent.CLOSE_HIGHSCORES, true))
		Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_MAIN_MENU))
	}
	private function highscoreError (e):void {
		highscoreBlocker.visible =false
		////trace("high scores error")
		dispatchEvent(new HighscoreEvent(HighscoreEvent.CLOSE_HIGHSCORES,true))
	}
	private function noMochiScores(status:String):void {
			mochiScoresDisabled = true
		}
		public static function getInstance():GameShell {
			return _instance
		}
		public var mochiScoresDisabled:Boolean
		private static var _instance:GameShell
		private var _DisplayManagerRef:DisplayManager
		private var _SharedObjectManagerRef:SharedObjectManager
		private var _CoreDataManagerRef:CoreDataManager
	}
}