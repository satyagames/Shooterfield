package com.gameshell {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.ButtonEvent;
	import flash.display.*
	import flash.text.*
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.utils.SharedObjectManager
	import com.gs.*
	import com.gs.easing.*
	import flash.events.*
	
	import com.vd.RotatingSphere
	import com.vd.StarField
	import com.gameshell.GameShellEvents
	public class MedalsScreen extends MovieClip {
		public function MedalsScreen():void {
			_instance = this
			Broadcaster.addEventListener(GameShellEvents.GO_MEDALS,restart)
			Broadcaster.addEventListener (ButtonEvent.OVER, btnOverHandler);
			Broadcaster.addEventListener (ButtonEvent.OUT, btnOutHandler);
			addEventListener (Event.REMOVED_FROM_STAGE, hideMedals);
			
			/*_RotatingSphere = new RotatingSphere()
			_StarFieldRef = new StarField()
			starFieldBitmap= _StarFieldRef.init(640,480,-1,-2)
			//sphereShape = _RotatingSphere.init(0xFF0000)
			sphereShape = _RotatingSphere.init(0x996211, 0, 0, 600, 160, 320, 240)
			_RotatingSphere.cameraView.focalLength = 380
			_RotatingSphere.cameraView.z = 0
			_RotatingSphere.cameraView.y = 100
			
			_RotatingSphere.cameraView.z = 1300
			_RotatingSphere.cameraView.y = 100
			_RotatingSphere.cameraView.x= 0
			
			//_RotatingSphere.startSphere()
			//_StarFieldRef.startEffect()
			sceneBack.addChild(starFieldBitmap)
			
			sceneBack.addChild(sphereShape)*/
		}
		/*private var starFieldBitmap:Bitmap
		private var _StarFieldRef:StarField
		private var sphereShape:Shape
		public var _RotatingSphere:RotatingSphere*/
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
			//_StarFieldRef.stopEffect()
			//_RotatingSphere.stopSphere()
		}
		public var medalTextArray:Array =["GAME COMPLETED","100 ENEMIES DESTROYED","500 ENEMIES DESTROYED","1000 ENEMIES DESTROYED","5000 BULLETS FIRED","25 FLYING SAUCERS DESTROYED","50 FLYING SAUCERS DESTROYED","50 FLELDS DEFENDED","100 FLELDS DEFENDED","100 GAMES PLAYED"]
		private function displayMedalText (_num:int,_clip:MovieClip):void {
		medalText.text = medalTextArray[_num - 1]
			if (_clip.unlocked) {
					medalText.appendText("\nYou've got this medal!")
				}
		}
		private var unlockedMedals:Array
		public function restart (event:GameShellEvents):void {
			////trace ("restarting medals screen")
			// display all the medal icons properly
			//_StarFieldRef.startEffect()
			//_RotatingSphere.startSphere()
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
		public static function getInstance():MedalsScreen {
			return _instance
		}
		private static var _instance:MedalsScreen
	}
}