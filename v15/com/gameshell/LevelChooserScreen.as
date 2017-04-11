package com.gameshell {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import flash.display.*
	import flash.events.Event;
	import flash.events.MouseEvent
	import com.terrypaton.utils.Broadcaster
	import com.gameshell.GameShellEvents
	import com.gameshell.CoreDataManager
	import com.gs.*
	import com.gs.easing.*
	import flash.ui.Mouse;
	import com.terrypaton.utils.Debug
	import com.terrypaton.utils.SharedObjectManager
	import com.vd.RotatingSphere
	import com.vd.StarField
	public class LevelChooserScreen extends MovieClip {
		public function LevelChooserScreen():void {
			_instance = this
			Broadcaster.addEventListener (GameShellEvents.SHOW_LEVEL_CHOOSER, setup);
			Broadcaster.addEventListener (ButtonEvent.DOWN,clickLevelHandler);
			//Broadcaster.addEventListener (ButtonEvent.OVER,planetOverHandler);
			//Broadcaster.addEventListener (ButtonEvent.OUT,planetOutHandler);
			addEventListener(Event.REMOVED_FROM_STAGE,cleanup)
			addEventListener (Event.REMOVED_FROM_STAGE, hideLevelChooser);
			
			/*_StarFieldRef = new StarField()
			starFieldBitmap = _StarFieldRef.init(640, 480, -1, -2)
			sceneBack.addChild(starFieldBitmap)*/
			
			
		}
		private var levelChooserSpheres:Array
		private var levelsUnlocked:int
		private var clipString:String
		private var starFieldBitmap:Bitmap
		//private var _StarFieldRef:StarField
		private var sphereShape:Shape
		public function cleanup (e:Event):void {
			var n:int = levelChooserHolder.numChildren
			while (n--) {
				levelChooserHolder.removeChildAt(0)
			}
		}
		private function hideLevelChooser(event:Event):void {
			//_StarFieldRef.stopEffect()
		}
		private var _clip:MovieClip 
		private var levelPositions:Array
		public function setup (e:GameShellEvents):void {
			//_StarFieldRef.startEffect()
			//sceneBack.startEffect()
			//trace("SETUP LEVEL CHOOSER")
			levelsUnlocked = SharedObjectManager.getInstance ().getData ("levelunlocked")
			if (levelsUnlocked == 0) {
				levelsUnlocked = 1
				SharedObjectManager.getInstance().setData ("levelunlocked",levelsUnlocked)
			}
		
			//levelsUnlocked = 10
			//SharedObjectManager.getInstance().setData ("levelunlocked",levelsUnlocked)
			//Debug.log("levelsUnlocked = "+levelsUnlocked)
			
			//levelsUnlvocked = 100
			
			// setup the 10 levels
			
			levelChooserSpheres = []
		levelPositions = new Array(-2800, -1000,9000,0x0066FF,-800, -630,7500,0xFF6600,850, -1400,10000,0x663300,1900, -650,7500,0x9933FF,2300,600,6800,0xFF0000,820,1150,5800,0xFF00FF,1450,300,11500,0x999900,-300,750,9000,0x009999,-1200,2100,9450,0x009900,-1750,720,6050,0xFFCC00);
			//levelPositions.push(0, 300,6000)
			var n:int = levelPositions.length 
			//trace("n = "+n)
			for (var i:int = 0; i < n; i+=4) {
				var tx:int = levelPositions[i]
				var ty:int = levelPositions[i+1]
				var tz:int = levelPositions[i+2]
				var col:int=levelPositions[(i+3)];
				//var _RotatingSphere:RotatingSphere = new RotatingSphere()
				//var _tempShape:Shape = _RotatingSphere.init(0x00FF00, 0, 0, 600, 160, 320, 240, -610)
				//trace("level = "+((i / 4)+1))
				clipString = "levelNum" + (i/4+1)
				 _clip = MovieClip(getChildByName(clipString))
				if (((i / 4) + 1) > levelsUnlocked) {
					trace("LOCKED")
					//col = 0x333333
					
					 _clip.visible = false
				}else {
					 _clip.visible = true
					 
				}
				var rotSpeed:Number 
				if (Math.random() < .5) {
					rotSpeed = .04
				}else {
					rotSpeed = -.04
				}
				//var _tempShape:Shape=_RotatingSphere.init(col,0,0,600,200,320,240,-300,160,rotSpeed);
				//_RotatingSphere.cameraView.focalLength = 620
				
				//_RotatingSphere.cameraView.x = tx
				//_RotatingSphere.cameraView.y = ty
				//_RotatingSphere.cameraView.z = tz
				
				//_RotatingSphere.init(
				//levelChooserSpheres.push(_RotatingSphere)
				//levelChooserHolder.addChild(_tempShape)
				//trace(_tempShape)
				//_RotatingSphere.manageObjects()
				//_RotatingSphere.startSphere()
			}
			//n = 11
			for (var c:int = 1; c < 11;c++){
				clipString = "levelNum" + c
				_clip = MovieClip(getChildByName(clipString))
				//_clip.alpha = 0
			}
			trace("levelsUnlocked:"+levelsUnlocked)
		}
		
		public function planetOutHandler (e:ButtonEvent):void {
			//if (String(e.data.name).slice(0, 8) == "levelNum") {
				//var levelNum:int = int(String(e.data.name).slice(8))
				//trace(levelNum)
				//if (levelNum <= levelsUnlocked) {
					// get the planet ref
					//var _RotatingSphere:RotatingSphere = levelChooserSpheres[levelNum - 1];
					//_RotatingSphere.stopSphere()
				//}
			//}
		}
		public function planetOverHandler (e:ButtonEvent):void {
			
			/*trace(String(e.data.name))
			if (String(e.data.name).slice(0, 8) == "levelNum") {
				var levelNum:int = int(String(e.data.name).slice(8))
				
				trace(levelNum)
				if ((levelNum) <= levelsUnlocked) {
					
					var _RotatingSphere:RotatingSphere = levelChooserSpheres[levelNum - 1];
					_RotatingSphere.startSphere()
				}
			}*/
		}
		public function clickLevelHandler (e:ButtonEvent):void {
			if (String(e.data.name).slice(0,8) == "levelNum") {
			var levelNum:int = int(String(e.data.name).slice(8))
				//trace(levelNum)
				CoreDataManager.getInstance().startLevel = levelNum
				// store the planet start cords into core data manager
				var loc:int = (levelNum-1)*4
				CoreDataManager.getInstance().camerax = levelPositions[loc]
				CoreDataManager.getInstance().cameray = levelPositions[loc+1]
				CoreDataManager.getInstance().cameraz = levelPositions[loc + 2]
				trace(levelPositions[loc])
				//Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.SET_LEVEL,true,_data))
				
				Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.SETUP_NEW_GAME))
				Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_GAME_SCREEN))
			}
		}
		public static function getInstance():LevelChooserScreen {
			return _instance
		}
		private static var _instance:LevelChooserScreen
		//private  var _clip:MovieClip	
	}
}