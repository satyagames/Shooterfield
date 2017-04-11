package com.vd {
	import com.terrypaton.utils.Stats;
	import flash.display.*
	import flash.geom.*
	import com.vd.VDEvents
	import com.gs.*
	import com.vd.DataManager
	import com.vd.RotatingSphere
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.math.TrigClass
	import com.terrypaton.effect.particleManagerClass
	import com.terrypaton.graphics.DrawPieChartLine;
	import com.terrypaton.utils.commaNumber
	import com.gameshell.CoreDataManager
	public class RenderManager extends MovieClip {
		public function RenderManager():void {
			_instance = this
			_particleManagerClass = new particleManagerClass()
			_particleSpriteSheet = new effectSpritesheet(10,10)
		}
		
		public function updateHUD(event:VDEvents):void {
			TweenLite.to(hudClip.healthClip.healthBar,.25,{scaleX : DataManager.getInstance().playerHealth/100})
			hudClip.scoreTextBox.text = commaNumber.processNumber(DataManager.getInstance().score)
			hudClip.levelTextBox.text = "LEVEL:"+ DataManager.getInstance().level
		}
		public function setup():void {
			Broadcaster.addEventListener(VDEvents.UPDATE_HUD,updateHUD)
			Broadcaster.addEventListener(VDEvents.REVEAL_HUD,revealHUD)
			Broadcaster.addEventListener(VDEvents.HIDE_HUD,hideHUD)
			Broadcaster.addEventListener(VDEvents.REVEAL_PLAYER,revealPlayer)
			hudClip = new HUD()
			hudClip.y = 480
			bulletClip_clip = new bulletClip()
			enemyClip_clip = new enemyClip()
			itemClip_clip = new itemClip()
			cannonPathClip = []
			renderMatrix = new Matrix()
			_tempPoint = new Point()
			_gameBmpData = new BitmapData(640, 480, false, 0x000000)
			_gameBmp = new Bitmap(_gameBmpData)
			
			_playerClip = new playerClip()
			_playerClip.alpha = 0
			// create star field
			starField = new BitmapData(640, 480, true, 0x00000000)
			starField2 = new BitmapData(640, 480, false, 0x00000000)
			// render stars
			var c:int = 100
			//var starColours:Array = [0xCCCCCC,0x777777,0xEEEEEE]
			//var starColours:Array = [0x777777,0x777777,0x777777]
			starColours = [0xff555555,0xff777777,0xffEEEEEE]
			while (c--) {
				var sx:int = Math.random()*640
				var sy:int = Math.random() * 474+2
				var col:int = Math.random() * 3
				
				starField.setPixel32(sx, sy, starColours[col])
				 sx = Math.random()*640
				 sy = Math.random() * 474+2
				 col = Math.random() * 3
				starField2.setPixel32(sx,sy,starColours[col])
			}
			
			_RotatingSphere = new RotatingSphere()
			
			//sphereShape = _RotatingSphere.init(0xFF0000)
			// find the colour of the planet we are defending
				var levelColours:Array = new Array(0x0066FF, 0xFF6600, 0x663300, 0x9933FF, 0xFF0000,  0xFF00FF,0x999900, 0x009999, 0x009900,0xFFCC00);
				var playingLevelColour:int  = CoreDataManager.getInstance().startLevel - 1
			sphereShape = _RotatingSphere.init(levelColours[playingLevelColour], 0, 0, 600, 160, 320, 240,-610)
			_RotatingSphere.cameraView.focalLength = 620
			
			if (CoreDataManager.getInstance() != null) {
				_RotatingSphere.cameraView.x =CoreDataManager.getInstance().camerax
				_RotatingSphere.cameraView.y =CoreDataManager.getInstance().cameray
				_RotatingSphere.cameraView.z =CoreDataManager.getInstance().cameraz
				
			}else {
				_RotatingSphere.cameraView.x = 0
				_RotatingSphere.cameraView.z = 6000
				_RotatingSphere.cameraView.y = 0
			}
			//_RotatingSphere.cameraView.z = 760
			//_RotatingSphere.cameraView.y = 670
			
			
			_RotatingSphere.startSphere()
			
			cannonPathClip = new Array();
			for (i = 0; i < 15; i++) {
				cannonMarker_clip = new cannonMarker();
				cannonMarker_clip.gotoAndStop (1);
				cannonPathClip[i] = cannonMarker_clip;
			}
			_powerUpWindow = new powerUpWindow()
			_powerUpWindow.alpha = 0
			_powerUpWindow.x =320
			_powerUpWindow.y = 458
			
			addChild(_gameBmp)
			addChild(_playerClip)
			//addChild(sphereShape)
			addChild(hudClip)
			powerUpShape = new Shape()
			_powerUpWindow.addChild (powerUpShape)
			addChild(_powerUpWindow)
			hidePowerUp()
			//addChild (new Stats())
			if (DataManager.getInstance().level == 1) {
				starField1Scroll = -2
				starField2Scroll = -1
			}else {
				starField1Scroll = 2
				starField2Scroll = 1
			}
		}
		private var starColours:Array
		public function displayPowerUpTime(_percent:Number):void {
			DrawPieChartLine.drawChart (powerUpShape,20,_percent,0xFF0000,-90);
		}
		private var powerUpShape:Shape
		private function revealPlayer(e:VDEvents):void 
		{
			_playerClip.scaleY = 1
			_playerClip.scaleX = 6
			_playerClip.alpha = 0
			TweenLite.to(_playerClip,1,{alpha:1,scaleX:1,scaleY:1})
			
		}
		
		private function hideHUD(e:VDEvents):void 
		{
			TweenLite.to(hudClip,.5,{y:480,alpha:0})
		}
		
		private function revealHUD(e:VDEvents):void 
		{
			hudClip.alpha = 0
			TweenLite.to(hudClip,1,{y:430,alpha:1})
		}
		public function zoomWorld():void {
			TweenLite.to(_RotatingSphere.cameraView,4,{x:0,z:760,y:670})
		}
		public function displayPowerUp(_num:int):void {
			_powerUpWindow.scaleX = _powerUpWindow.scaleY = .1
			_powerUpWindow.alpha = 0
			TweenLite.to(_powerUpWindow,.5,{scaleX:1,scaleY:1,alpha:1})
			_powerUpWindow.gotoAndStop(_num)
		}
		public function hidePowerUp():void {
			//_powerUpWindow.gotoAndStop(_num)
			TweenLite.to(_powerUpWindow,.5,{scaleX:1,scaleY:1,alpha:0})
		}
		private var _powerUpWindow:MovieClip
		private var currentAimingAlpha:Number = 0;
		private var pathPoint:Point = new Point()
		private var colTrans:ColorTransform = new ColorTransform();
		private var xVel:Number;
		private var yVel:Number;
		public function resetCannonPathClips ():void {
			for (i = 0; i < 15; i++) {
				cannonMarker_clip = cannonPathClip[i]
				cannonMarker_clip.gotoAndStop (1);
				//cannonPathClip[i] = cannonMarker_clip;
			}
		}
		private var hudClip:MovieClip
		private function drawCannonPath ():void {
			if (DataManager.getInstance().playerIsAiming) {
				if (currentAimingAlpha < 1) {
					currentAimingAlpha+=.1;
				}
			} else {
				if (currentAimingAlpha > 0) {
					currentAimingAlpha -= .1;
				}
			}
			colTrans.alphaMultiplier = currentAimingAlpha;
			pathPoint = DataManager.getInstance().getPlayerLoc();
			// find the offset for the tip of the cannon

			//tempPoint = TrigClass.findXYSpeed(_DataManagerRef.cannonRotation,50)
			tempPoint = TrigClass.findXYSpeed(DataManager.getInstance().cannonRotation,50);
			pathPoint.x += tempPoint.x;
			pathPoint.y += tempPoint.y;
			xVel = DataManager.getInstance().cannonVelocityPoint.x;
			yVel = DataManager.getInstance().cannonVelocityPoint.y;
			var _num:Number = (DataManager.getInstance().cannonPower);
			// test how many clips should have been told to play
			var currentPowerFrame:int = ((_num-11) /100) * 16;
			//HUD_clip.textBox.appendText("\ncurrentPowerFrame:"+currentPowerFrame)
			for (i = 1; i < 15; i++) {
				renderMatrix.identity ();
				pathPoint.x +=xVel;
				pathPoint.y += yVel;
				yVel += settings.GRAVITY;
				cannonMarker_clip = cannonPathClip[i];
				if (i <= currentPowerFrame) {
					if (cannonMarker_clip.currentFrame == 1) {
						cannonMarker_clip.gotoAndPlay ("mark");
					}
				}
				cannonPathClip[i] = cannonMarker_clip;
				renderMatrix.translate (pathPoint.x, pathPoint.y);
				_gameBmpData.draw (cannonMarker_clip, renderMatrix,colTrans);

			}
		}
		public var _RotatingSphere:RotatingSphere
		private var sphereShape:Shape
		private var zeroPoint:Point = new Point()
		private var starField1Scroll:int = -1
		private var starField2Scroll:int = -1
		private var col:int 
		private function renderStarField():void {
			starField.scroll(0, starField1Scroll)
			starField2.scroll(0, starField2Scroll)
			if (starField1Scroll < 0) {
				// draw a line along the bottom
				if (Math.random()<.2){
					col = Math.random() * 3
					starField2.setPixel32(int(Math.random()*640),477,starColours[col])
				}
				if (Math.random()<.2){
					 col = Math.random() * 3
					starField.setPixel32(int(Math.random()*640),477,starColours[col])
				}
			}else if (starField1Scroll >0) {
				// draw a line along the bottom
				var n:int = Math.random() * 2
				while (n--) {
					if (Math.random()<.2){
					col = Math.random() * 3
				starField2.setPixel32(int(Math.random()*640),2,starColours[col])
					}
					if (Math.random()<.2){
					col = Math.random() * 3
					starField.setPixel32(int(Math.random() * 640), 3, starColours[col])
					}
				}
			}
			// draw line of stars along the starfield
			//_gameBmpData.fillRect(_gameBmpData.rect, 0x000000);
			_gameBmpData.copyPixels(starField2,starField.rect,zeroPoint)
			_gameBmpData.copyPixels(starField,starField.rect,zeroPoint,null,null,true)
		}
		public function renderGame():void {
			// render the star field
			renderStarField()
			_particleManagerClass.manageParticles(_gameBmpData,_particleSpriteSheet)
			renderEnemies ();
			if (PlayingLoopManager.getInstance().gameState == settings.GS_PLAYING) {
				renderItems ();
			}
			
			renderBullets ();
			drawCannonPath()
			_playerClip.x = DataManager.getInstance().playerLoc.x
			_playerClip.y = DataManager.getInstance().playerLoc.y
			_playerClip.turret.rotation = DataManager.getInstance().cannonRotation
			
			if (DataManager.getInstance().playerIsAiming && DataManager.getInstance().cannonPower>10) {
				_playerClip.turret.turret2.scaleX =(100-(DataManager.getInstance().cannonPower)*.3)/100;
				_playerClip.turret.x = Math.random()*(DataManager.getInstance().cannonPower*.05);
				_playerClip.turret.y = Math.random()*(DataManager.getInstance().cannonPower*.05);
			} else {
				_playerClip.turret.x = 0;
				_playerClip.turret.y = 0;
			}
		}
		
		private var _tempPoint3:Point
		private var tempPoint:Point = new Point()
		private var _ItemClassRef:ItemClass
		private var _EnemyClassRef:EnemyClass
		private function renderItems ():void {
			var _itemArray:Array = GenericItemManager.getInstance().getItemArray();
			var n:int = _itemArray.length;
		
			while (n--) {
				_ItemClassRef = _itemArray[n];
				_tempPoint3 = _ItemClassRef.getLoc();
				renderMatrix.identity ();
				renderMatrix.rotate (_ItemClassRef.itemRadians);
				
				renderMatrix.translate (_tempPoint3.x  , _tempPoint3.y );
				itemClip_clip.gotoAndStop (_ItemClassRef.animationFrame);
				//trace("animationFrame:"+_ItemClassRef.animationFrame)
				colTrans.alphaMultiplier = _ItemClassRef.alphaVal
				_gameBmpData.draw (itemClip_clip, renderMatrix,colTrans);
			}
		}
		
		private function renderEnemies ():void {
			var _enemyArray:Array = EnemyManager.getInstance().getEnemyArray();
			var n:int = _enemyArray.length;
			while (n--) {
				_EnemyClassRef = _enemyArray[n];
				_tempPoint3 = _EnemyClassRef.getLoc();
				renderMatrix.identity ();
				renderMatrix.rotate (_EnemyClassRef.enemyRadians);
				
				renderMatrix.translate (_tempPoint3.x  , _tempPoint3.y );
				enemyClip_clip.gotoAndStop (_EnemyClassRef.animationFrame);
				_gameBmpData.draw (enemyClip_clip, renderMatrix);
					
			}
		}
		public function fireCannonPathClips ():void {
			
			_playerClip.turret.turret2.scaleX = 1
		}
		private function renderBullets ():void {
			var _bulletArray:Array = BulletManager.getInstance().getBulletArray();
			var n:int = _bulletArray.length;
			
			while (n--) {
				
				var _BulletClassRef = _bulletArray[n];
				_tempPoint = _BulletClassRef.getLoc();
			
				renderMatrix.identity ();
				renderMatrix.rotate (_BulletClassRef.bulletRadians);
				renderMatrix.translate (_tempPoint.x, _tempPoint.y);
				bulletClip_clip.gotoAndStop (_BulletClassRef.getBulletType());
				
				_gameBmpData.draw (bulletClip_clip, renderMatrix);

			}
		}
		public function dispose():void {
			
			try {
				_RotatingSphere.stopSphere()
			}catch (e:Error) {
				
			}
			try {
				_RotatingSphere = null
			}catch (e:Error) {
				
			}
			try {
				removeChild(_gameBmp)
			}catch (e:Error) {
				
			}
			try {
				removeChild(_playerClip)
			}catch (e:Error) {
				
			}
			try {
				removeChild(sphereShape)
			}catch (e:Error) {
				
			}
			try {
				removeChild(hudClip)
			}catch (e:Error) {
				
			}
			try {
				_powerUpWindow.removeChild (powerUpShape)
			}catch (e:Error) {
				
			}
			try {
				removeChild (_powerUpWindow)
			}catch (e:Error) {
				
			}
			try {
				Broadcaster.removeEventListener(VDEvents.UPDATE_HUD,updateHUD)
				Broadcaster.removeEventListener(VDEvents.REVEAL_HUD,revealHUD)
				Broadcaster.removeEventListener(VDEvents.HIDE_HUD,hideHUD)
				Broadcaster.removeEventListener(VDEvents.REVEAL_PLAYER,revealPlayer)
			}catch (e:Error) {
				
			}
			try {
				_gameBmpData.fillRect(_gameBmpData.rect,0x000000)
				_gameBmpData = null
				_gameBmp = null
				_playerClip = null
				starField = null
				starField2 =null
			}catch (e:Error) {
				
			}
			try {
				_particleManagerClass.killAllParticles ()
				//_particleManagerClass = null
			
			}catch (e:Error) {
				
			}
			
			
			
		}
		private static var _instance:RenderManager
		public static function getInstance():RenderManager {
			return _instance
		}
		
		private var _playerClip:MovieClip
		private var _particleManagerClass:particleManagerClass
		private var cannonMarker_clip:MovieClip
		private var cannonPathClip:Array
		private var i:int
		private var _gameBmp:Bitmap
		private var _gameBmpData:BitmapData
		private var renderMatrix:Matrix
		private var _tempPoint:Point
		private var _BulletClassRef:BulletClass
		private var bulletClip_clip:MovieClip
		private var enemyClip_clip:MovieClip
		private var itemClip_clip:MovieClip
		private var _particleSpriteSheet:BitmapData
		private var starField:BitmapData
		private var starField2:BitmapData
	}
}