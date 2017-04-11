package com.gameshell {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.ButtonEvent;
	import com.terrypaton.events.HighscoreEvent;
	import flash.display.*
	import flash.events.*;
	import flash.text.*
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
	import com.gameshell.CoreDataManager
	import com.terrypaton.utils.commaNumber
	import com.gameshell.GameShellEvents
	import com.terrypaton.effect.particleManagerClass
	import com.vd.RotatingSphere
	import com.vd.StarField
	public class GameCompleteScreen extends MovieClip {
		public function GameCompleteScreen():void {
			_instance = this
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, hide)
			
			/*_RotatingSphere = new RotatingSphere()
			_StarFieldRef = new StarField()
			explosionBmpData = new BitmapData(640, 480, true, 0x00FF0000)
			explosionBmp = new Bitmap(explosionBmpData)
			starFieldBitmap= _StarFieldRef.init(640,480,1,2)
			//sphereShape = _RotatingSphere.init(0xFF0000)
			sphereShape = _RotatingSphere.init(0x999999, -100, 0, 600, 160, 320, 240,70)
			_RotatingSphere.cameraView.focalLength = 380
			_RotatingSphere.cameraView.z = 0
			_RotatingSphere.cameraView.y = 100
			
			_RotatingSphere.cameraView.z = 1200
			_RotatingSphere.cameraView.y = 200
			_RotatingSphere.cameraView.x= 300
			
			sceneBack.addChild(starFieldBitmap)
			sceneBack.addChild(sphereShape)*/
			sceneBack.addChild(explosionBmp)
			_particleManagerClass = new particleManagerClass()
			_particleSpriteSheet = new effectSpritesheet(10,10)
		}
		private var explosionBmpData:BitmapData
		private var explosionBmp:Bitmap
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
			switch(e.data.name) {
				case "gameCompleteSubmitScoreBtn":
					////trace("submitScoreBtn")
					var _data:Object = new Object ()
					//this.fallingItems.stopEffect()
					//this.fallingItems2.stopEffect()
					_data.score =score
					//_data.score =100
					gameCompleteSubmitScoreBtn.visible = false
					Broadcaster.dispatchEvent (new HighscoreEvent (HighscoreEvent.SUBMIT_HIGH_SCORE,true,_data))
			
				break
			}
		}
		private function gameOverLoop(e:Event) :void {
			explosionBmpData.fillRect(explosionBmpData.rect,0X00000000)
			_particleManagerClass.manageParticles(explosionBmpData, _particleSpriteSheet)
			if (Math.random() < .5) {
				//trace("make particle")
				_particleManagerClass.createParticles(int(Math.random()*640),int(Math.random()*480),10,int(Math.random()*2+11),1)	
			}
		}
		/*private var starFieldBitmap:Bitmap
		private var _StarFieldRef:StarField
		private var sphereShape:Shape
		public var _RotatingSphere:RotatingSphere*/
		public function restart ():void {
			//trace ("restarting game complete screen!!")
			addEventListener(Event.ENTER_FRAME, gameOverLoop)
			
			gameCompleteSubmitScoreBtn.visible = true
			//fallingItems.startEffect()
			//fallingItems2.startEffect()
			score = CoreDataManager.getInstance().score
			scoreTextBox.text = commaNumber.processNumber (score)
			//_StarFieldRef.startEffect()
			//_RotatingSphere.startSphere()
			
		
		}
		private function hide(e:Event):void {
			trace("hide game complete screen")
			//_StarFieldRef.stopEffect()
			//_RotatingSphere.stopSphere()
			_particleManagerClass.killAllParticles ()
			removeEventListener(Event.ENTER_FRAME,gameOverLoop)
		}
		public static function getInstance():GameCompleteScreen {
			return _instance
		}
		private static var _instance:GameCompleteScreen
		private var score:int = 0
		private var _particleManagerClass:particleManagerClass
		private var _particleSpriteSheet:BitmapData
	}
}