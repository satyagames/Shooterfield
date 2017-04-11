package com.jewelmaster {
	import com.jewelmaster.PlayingLoopManager
	import com.terrypaton.events.KeyBoardEvents
	import flash.display.*;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import mochi.as3.*
	import com.terrypaton.utils.Debug
	import com.terrypaton.utils.SharedObjectManager
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.events.PlayingLoopEvent
	import com.terrypaton.events.HighscoreEvent
	import com.terrypaton.events.ButtonEvent
	public class JewelMaster extends MovieClip {
		
		public function JewelMaster ():void {
			_instance = this
			_PlayingLoopManagerRef = new PlayingLoopManager ()
			_DisplayManagerRef = new DisplayManager ()
			addChild (_DisplayManagerRef)
			highscoreBlocker = new highscoreBlockerClip ()
			highscoreBlocker.mouseEnabled = true
			highscoreHolder = new MovieClip ()
			addChild (highscoreBlocker)
			highscoreBlocker.visible = false
			addChild(highscoreHolder)
			//addEventListener (Event.ENTER_FRAME, loop)
			//mochi.as3.MochiServices.connect ("ea2acbb912944e65", highscoreHolder, noMochiScores);
			mochi.as3.MochiServices.connect("ea2acbb912944e65", highscoreHolder,noMochiScores);
			//mochi.as2.MochiServices.connect("ea2acbb912944e65");
			trace ("SHared object:" + SharedObjectManager.getInstance ().getData ("levelunlocked"))
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
		
			////trace("medalsArray = "+medalsArray)
			Broadcaster.broadcast (new PlayingLoopEvent (PlayingLoopEvent.GO_MAIN_MENU))
			Broadcaster.addEventListener (HighscoreEvent.SUBMIT_HIGH_SCORE, submitHighscore)
			Broadcaster.addEventListener (ButtonEvent.OVER, btnOverHandler);
			Broadcaster.addEventListener (ButtonEvent.OUT, btnOutHandler);
			stage.addEventListener (KeyboardEvent.KEY_DOWN, keyDownHandler)
			stage.addEventListener (KeyboardEvent.KEY_UP, keyUpHandler)
		}
		private function btnOverHandler (e:ButtonEvent):void {
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
		//public function loop (e:Event):void {
			//_PlayingLoopManagerRef.manageLoop()
		//}
		
		private function submitHighscore (e:HighscoreEvent):void {
			var score:int = e.data.score
			highscoreBlocker.visible = true
			trace ("trying to submit score : " + score)
			//mochi.MochiScores.showLeaderboard({boardID: "26ee997e92e16d77", score: _DataManagerRef.score});
			//mochi.as3.MochiScores.showLeaderboard ( { boardID: "26ee997e92e16d77", score: 100, clip: this, onClose: closeHighscores, onError: highscoreError } );
			
			var o:Object = { n: [2, 6, 14, 14, 9, 9, 7, 14, 9, 2, 14, 1, 6, 13, 7, 7], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
var boardID:String = o.f(0,"");
mochi.as3.MochiScores.showLeaderboard ( { clip:this, boardID: boardID, score: score, onClose: closeHighscores, onError: highscoreError } );
		
		}
		private function revealHighscoreChart (e:HighscoreEvent):void {
			highscoreBlocker.visible = true
			var o:Object = { n: [2, 6, 14, 14, 9, 9, 7, 14, 9, 2, 14, 1, 6, 13, 7, 7], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
		
var boardID:String = o.f(0,"");
mochi.as3.MochiScores.showLeaderboard({clip:this, boardID: boardID, onClose: closeHighscores, onError: highscoreError});
		
		
	}
	private function closeHighscores ():void {
		highscoreBlocker.visible =false
		trace("close high scores")
		dispatchEvent (new HighscoreEvent (HighscoreEvent.CLOSE_HIGHSCORES, true))
		Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
	}
	private function highscoreError (e):void {
		highscoreBlocker.visible =false
		////trace("high scores error")
		dispatchEvent(new HighscoreEvent(HighscoreEvent.CLOSE_HIGHSCORES,true))
	}
	private function noMochiScores(status:String):void {
			
			
			
			mochiScoresDisabled = true
		}
		public static function getInstance():JewelMaster {
			return _instance
		}
		public var mochiScoresDisabled:Boolean
		private static var _instance:JewelMaster
		private var _PlayingLoopManagerRef:PlayingLoopManager
		private var _DisplayManagerRef:DisplayManager
		private var _SharedObjectManagerRef:SharedObjectManager
	}
}