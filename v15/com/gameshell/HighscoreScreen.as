package com.gameshell {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.PlayingLoopEvent;
	import com.terrypaton.events.ButtonEvent;
	import com.terrypaton.events.HighscoreEvent;
	import flash.display.*
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
	import com.mochi.as3.*
	import flash.events.*
	import com.vd.RotatingSphere
	import com.vd.StarField
	public class HighscoreScreen extends MovieClip {
		public function HighscoreScreen():void {
			_instance = this
			Broadcaster.addEventListener (HighscoreEvent.SHOW_HIGH_SCORES, revealHighscoreChart);
			addEventListener (Event.REMOVED_FROM_STAGE, hideHighs);
			
			_RotatingSphere = new RotatingSphere()
			_StarFieldRef = new StarField()
			starFieldBitmap= _StarFieldRef.init(640,480,-1,-2)
			//sphereShape = _RotatingSphere.init(0xFF0000)
			sphereShape = _RotatingSphere.init(0x990000, 0, 0, 600, 160, 320, 240)
			_RotatingSphere.cameraView.focalLength = 380
			_RotatingSphere.cameraView.z = 0
			_RotatingSphere.cameraView.y = 100
			
			_RotatingSphere.cameraView.z = 1300
			_RotatingSphere.cameraView.y = -100
			_RotatingSphere.cameraView.x= 50
			
			//_RotatingSphere.startSphere()
			//_StarFieldRef.startEffect()
			sceneBack.addChild(starFieldBitmap)
			
			sceneBack.addChild(sphereShape)
		}
		private var starFieldBitmap:Bitmap
		private var _StarFieldRef:StarField
		private var sphereShape:Shape
		public var _RotatingSphere:RotatingSphere
		
		private function revealHighscoreChart(e:HighscoreEvent):void {
		
			_StarFieldRef.startEffect()
			_RotatingSphere.startSphere()
		 }
		 private function hideHighs(event:Event):void {
			_StarFieldRef.stopEffect()
			_RotatingSphere.stopSphere()
		}
	private function closeHighscores():void {
		trace ("close high scores")
		Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_MAIN_MENU))
	}
	private function highscoreError(e):void {
		////trace("high scores error")
		dispatchEvent(new HighscoreEvent(HighscoreEvent.CLOSE_HIGHSCORES,true))
	}
		public function restart ():void {
			////trace("restarting help screen")
			
		}
		private function highscoreDisplayed ():void {
		
		}
		
		public static function getInstance():HighscoreScreen {
			return _instance
		}
		private static var _instance:HighscoreScreen
		
		
		
	}
}