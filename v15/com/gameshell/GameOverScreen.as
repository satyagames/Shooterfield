package com.gameshell {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.ButtonEvent;
	import com.terrypaton.events.HighscoreEvent;
	import com.gameshell.GameShellEvents
	import flash.display.*
	import flash.events.Event;
	import flash.text.*
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
import com.gameshell.CoreDataManager
	import com.terrypaton.utils.commaNumber
	import com.vd.RotatingSphere
	import com.vd.StarField
	public class GameOverScreen extends MovieClip {
		public function GameOverScreen():void {
			_instance = this
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			Broadcaster.addEventListener (GameShellEvents.GO_GAME_OVER,  restart);
			addEventListener (Event.REMOVED_FROM_STAGE, hideScreen);
			//_PlayingLoopManagerRef= PlayingLoopManager.getInstance()
			/*_RotatingSphere = new RotatingSphere()
			_StarFieldRef = new StarField()
			starFieldBitmap= _StarFieldRef.init(640,480,1,2)
			//sphereShape = _RotatingSphere.init(0xFF0000)
			sphereShape = _RotatingSphere.init(0xFF0000, 0, 0, 600, 160, 320, 240,70)
			_RotatingSphere.cameraView.focalLength = 380
			_RotatingSphere.cameraView.z = 0
			_RotatingSphere.cameraView.y = 100
			
			_RotatingSphere.cameraView.z = 1200
			_RotatingSphere.cameraView.y = 200
			_RotatingSphere.cameraView.x= 300
			
			sceneBack.addChild(starFieldBitmap)
			sceneBack.addChild(sphereShape)*/
		}
		/*private var starFieldBitmap:Bitmap
		private var _StarFieldRef:StarField
		private var sphereShape:Shape
		public var _RotatingSphere:RotatingSphere*/
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
			switch(e.data.name) {
				case "submitScoreBtn":
					var _data:Object = new Object ()
					
					_data.score =score
					//_data.score =100
					submitScoreBtn.visible = false
					Broadcaster.dispatchEvent (new HighscoreEvent (HighscoreEvent.SUBMIT_HIGH_SCORE,true,_data))
			
				break
			}
		}
		
		public function hideScreen (e:Event):void {
			//_StarFieldRef.stopEffect()
			//_RotatingSphere.stopSphere()
		}
		public function restart (e:GameShellEvents):void {
			trace ("restarting gameover screen")
			submitScoreBtn.visible = true
			score = CoreDataManager.getInstance().score
			scoreTextBox.text = commaNumber.processNumber(score)
			//_StarFieldRef.startEffect()
			//_RotatingSphere.startSphere()
		}
		public static function getInstance():GameOverScreen {
			return _instance
		}
		private static var _instance:GameOverScreen
		private var score:int = 0
	}
}