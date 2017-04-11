package com.jewelmaster {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import flash.display.MovieClip
	import flash.events.Event;
	import flash.events.MouseEvent
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
	import flash.ui.Mouse;
	import com.terrypaton.utils.Debug
	import com.terrypaton.utils.SharedObjectManager
	public class LevelChooserScreenClass extends MovieClip {
		public function LevelChooserScreenClass():void {
			_instance = this
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			Broadcaster.addEventListener (PlayingLoopEvent.SHOW_LEVEL_CHOOSER, setup);
			_PlayingLoopManagerRef = PlayingLoopManager.getInstance ()
			addEventListener(Event.REMOVED_FROM_STAGE,cleanup)
			addEventListener (Event.REMOVED_FROM_STAGE, hideLevelChooser);
		}
		private var levelsUnlocked:int
		public function cleanup (e:Event):void {
			var n:int = levelChooserHolder.numChildren
			while (n--) {
				levelChooserHolder.removeChildAt(0)
			}
		}
		private function hideLevelChooser(event:Event):void {
			sceneBack.stopEffect()
		}
		
		public function setup (e:PlayingLoopEvent):void {
			sceneBack.startEffect()
			Debug.log("SETUP LEVEL CHOOSER")
			levelsUnlocked = SharedObjectManager.getInstance ().getData ("levelunlocked")
			if (levelsUnlocked == 0) {
				levelsUnlocked = 1
				SharedObjectManager.getInstance().setData ("levelunlocked",levelsUnlocked)
			}
		
			//levelsUnlocked = 10
			//SharedObjectManager.getInstance().setData ("levelunlocked",levelsUnlocked)
			//Debug.log("levelsUnlocked = "+levelsUnlocked)
			
			var n:int = 100
			//levelsUnlvocked = 100
			while (n--) {
				_clip = new levelIconClip ()
				levelChooserHolder.addChild(_clip)
				var yval:int =n/10
				var xval:int = n - yval * 10
				_clip.x = xval * 44.5+21
				_clip.y = yval * 27.5+13
				_clip.textBox1.text = (n + 1)
				_clip.textBox2.text =(n+1)
				//if (n <= levelsUnlocked) {
				if (n == levelsUnlocked-1) {
					_clip.gotoAndStop (1)
					_clip.addEventListener (MouseEvent.CLICK, clickLevelHandler,false,0,true)
					_clip.levelNum = (n + 1)
					_clip.buttonMode = true
					_clip.textBox2.visible = false
				}else if (n < levelsUnlocked-1) {
					_clip.gotoAndStop (2)
					_clip.addEventListener (MouseEvent.CLICK, clickLevelHandler,false,0,true)
					_clip.levelNum = (n + 1)
					_clip.buttonMode = true
					_clip.textBox1.visible = false
				}else {
					_clip.gotoAndStop (3)
					_clip.alpha = .6
				}
				if (n>1){
					if (n == DataManager.getInstance().lastLevelCompleted) {
						// wobble the level just unlocked
						_clip.scaleX = _clip.scaleY = 3
						TweenLite.to(_clip,.75,{scaleX:1,scaleY:1,overwrite:false,ease:Bounce.easeOut})
						
					}
				}
				_clip.mouseChildren = false
				
			}
		}
		
		public function clickLevelHandler (e:MouseEvent):void {
			var _clip:MovieClip = MovieClip (e.target)
			var startOnLevel:int = int (_clip.levelNum)
			trace ("start on level " + startOnLevel)
			var _data:Object = new Object ()
			_data.startOnLevel =startOnLevel
			Broadcaster.dispatchEvent(new PlayingLoopEvent(JewelMasterEvents.SET_LEVEL,true,_data))
			Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.SETUP_NEW_GAME))
			Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_GAME_SCREEN))
		}
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
	
			switch(e.data.name) {
				case "mainMenuBtn":
					Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.GO_MAIN_MENU))
				break
				
			}
		}
		
		
		public static function getInstance():LevelChooserScreenClass {
			return _instance
		}
		private static var _instance:LevelChooserScreenClass
		private  var _PlayingLoopManagerRef:PlayingLoopManager
		private  var _clip:MovieClip
		
		
		
	}
}