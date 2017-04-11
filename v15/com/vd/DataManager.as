package com.vd{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*
	import com.vd.*
	import com.terrypaton.math.TrigClass
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.events.GeneralEvents
	import com.terrypaton.media.SoundManager
	import com.terrypaton.utils.SharedObjectManager
	import com.gameshell.CoreDataManager
	import com.gameshell.GameShellEvents
	public class DataManager {
		public function DataManager():void {
			_instance = this
			_SoundManager = new SoundManager()
		}
		private static var _instance:DataManager
		public static function getInstance():DataManager {
			return _instance
		}
		public function damagePlayer(_num:int):void {
			RenderManager.getInstance()._RotatingSphere.shakeCamera(20)
			playSound("enemyHitsPlanet_1.wav")
			
			playerHealth -= _num
			if (playerHealth < 1) {
				playerHealth = 0
				CoreDataManager.getInstance().score = score
				
				
				PlayingLoopManager.getInstance().gameState = settings.GS_GAME_OVER
			}
			Broadcaster.broadcast(new VDEvents(VDEvents.UPDATE_HUD))
		}
		
		
		public function dispose():void {
			Game.getInstance().removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler)
			Game.getInstance().removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler)

		}
		public function addHealth(_num:int):void {
			playerHealth += _num
			if (playerHealth > 100) {
				playerHealth = 100
			}
			Broadcaster.broadcast(new VDEvents(VDEvents.UPDATE_HUD))
		}
	
			
		public function manageGame():void {
		
			managePlayer()
			manageEnemyAmounts()
			EnemyManager.getInstance().manageEnemies()
			GenericItemManager.getInstance().manageItems()
			BulletManager.getInstance().manageBullets()
			
		}
		public function getPlayerLoc ():Point {
			return new Point(playerLoc.x,playerLoc.y);
		}
		private function mouseDownHandler(e:MouseEvent):void {
			
			if (PlayingLoopManager.getInstance().gameState == settings.GS_PLAYING){
				mouseIsDown = true
			}
		}
		private var fireCounter:int
		public var playerHealth:int
		private function mouseUpHandler(e:MouseEvent):void {
			if (PlayingLoopManager.getInstance().gameState == settings.GS_PLAYING){
				if (mouseIsDown) {
					if (playerIsAiming) {
						fireCannon()
					}
				}
			}
		}
		private var currentBulletType:int
		private var powerUpActive:Boolean
		var fireStartLoc:Point = new Point()
		private function fireCannon () :void {
			//trace("fireCannon")
			if (powerUpActive && currentPowerUp == settings.POWERUP_RAPID_FIRE) {
				fireCounter = settings.FIRING_DELAY_RAPID
			}else {
				fireCounter = settings.FIRING_DELAY
			}
			if (powerUpActive && currentPowerUp == settings.POWERUP_LASER) {
				
			}
			
			//playSound("cannon_"+(int (Math.random()*3)+1)+".wav")
			mouseIsDown = false
			aimingClipArray = new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
			playerIsAiming = false
			RenderManager.getInstance().fireCannonPathClips()
			
			fireStartLoc.x = playerLoc.x
			fireStartLoc.y = playerLoc.y
			var tempPoint:Point = TrigClass.findXYSpeed(cannonRotation, 50)
			fireStartLoc.x += tempPoint.x
			fireStartLoc.y += tempPoint.y
			// find the offset for the tip of the cannon
			RenderManager.getInstance().resetCannonPathClips ()
			if (powerUpActive) {
				switch(currentPowerUp) {
					case settings.POWERUP_SPRAY_1:
					
						tempPoint = TrigClass.findXYSpeed(cannonRotation-5, cannonPower *settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
						
						 tempPoint = TrigClass.findXYSpeed(cannonRotation+5, cannonPower * settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
						
						break
					case settings.POWERUP_SPRAY_2:
				
						tempPoint = TrigClass.findXYSpeed(cannonRotation-5, cannonPower *settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
						
						tempPoint = TrigClass.findXYSpeed(cannonRotation+5, cannonPower * settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
						
						tempPoint = TrigClass.findXYSpeed(cannonRotation, cannonPower * settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
					
					break
					case settings.POWERUP_LASER:
				
						tempPoint = TrigClass.findXYSpeed(cannonRotation, 15)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
					break
					case settings.POWERUP_BIG_BULLET:
						tempPoint = TrigClass.findXYSpeed(cannonRotation, cannonPower *settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
					break
					case settings.POWERUP_HOMING:
						tempPoint = TrigClass.findXYSpeed(cannonRotation, cannonPower *settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
					break
					case settings.POWERUP_WAVY:
				
					break
					case settings.POWERUP_RAPID_FIRE:
				tempPoint = TrigClass.findXYSpeed(cannonRotation, cannonPower * settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
					break
					case settings.POWERUP_LIGHTNING:
				
					break
					
					case settings.POWERUP_HOMING:
						tempPoint = TrigClass.findXYSpeed(cannonRotation, cannonPower *settings.CANNON_FACTOR)
						BulletManager.getInstance().fireBullet(fireStartLoc, tempPoint.x, tempPoint.y, currentBulletType)
					break
				}
			}else {
				// standard fire is on
				//trace("standard fire")
				tempPoint = TrigClass.findXYSpeed(cannonRotation, cannonPower *settings.CANNON_FACTOR)
				BulletManager.getInstance().fireBullet(fireStartLoc,tempPoint.x,tempPoint.y,currentBulletType)
			}
		}
		private var powerUpCounter:int 
		private var powerUpCounterMax:int 
		public function activePowerUp(_powerupNum:int):void {
			powerUpActive = true
			currentPowerUp = _powerupNum
			RenderManager.getInstance().displayPowerUp(_powerupNum)
			
			powerUpCounterMax = powerUpCounter = 600
			switch(_powerupNum) {
				case settings.POWERUP_SPRAY_1:
					currentBulletType = settings.BULLET_TYPE_1
					
				break
				case settings.POWERUP_SPRAY_2:
					currentBulletType = settings.BULLET_TYPE_1
				break
				case settings.POWERUP_LASER:
					currentBulletType = settings.BULLET_TYPE_LASER
					break
				case settings.POWERUP_BIG_BULLET:
					currentBulletType = settings.BULLET_TYPE_BIG
					break
				case settings.POWERUP_HOMING:
				currentBulletType = settings.BULLET_TYPE_HOMING
					break
				case settings.POWERUP_WAVY:
				
					break
				case settings.POWERUP_RAPID_FIRE:
			currentBulletType = settings.BULLET_TYPE_1
					break
				case settings.POWERUP_LIGHTNING:
				
					break
				case settings.POWERUP_HOMING:
					currentBulletType = settings.BULLET_TYPE_2
				break
			}
		}
		private var currentPowerUp:int
		var tempP:Point = new Point()
		public function managePlayer():void {
			sateliteCounter --
			if (sateliteCounter < 1) {
				findSateliteCounter()
				// add in a satelite
				if (Math.random() < .5) {
						tempP = new Point(-10,Math.random()*200+50)
				}else {
					tempP = new Point(650,Math.random()*200+50)
				}
				//trace("add a satelite")
				var satType:int = Math.random()*3+40
				//GenericItemManager.getInstance().addItem(temp, settings.ITEM_POWER_UP,settings.POWERUP_SPRAY_2)
				GenericItemManager.getInstance().addItem(tempP, settings.ITEM_SATELITE,satType)
						
				
			}
			if (playerIsAiming) {
				if (mouseIsDown) {
					if (cannonPower < 100) {
						if (currentPowerUp == settings.POWERUP_RAPID_FIRE) {
							//cannonPower+=6.5
							cannonPower+=8
						}else {
							//cannonPower+=3
							cannonPower+=4.5
						}
						
					}else {
						fireCannon()
					}
				}
			}else {
				fireCounter --
				//trace(fireCounter)
				if (fireCounter < 1) {
						cannonPower = 10
					playerIsAiming = true
					RenderManager.getInstance().resetCannonPathClips()
				}
			}
			// rotate the cannon to the mouse
			mousePoint.x = Game.getInstance().mouseX
			mousePoint.y = Game.getInstance().mouseY
			//(playerLoc,mousePoint)
			
			cannonRotation = TrigClass.findAngle(mousePoint, playerLoc)
			
			if (cannonRotation<-178){
				cannonRotation = -178
			}
			if (cannonRotation>-2 && cannonRotation >275){
				cannonRotation = - 2
			}
			cannonVelocityPoint = TrigClass.findXYSpeed(cannonRotation,15)
			// manage the power ups
			if (powerUpActive) {
				powerUpCounter --
				if (powerUpCounter < 1) {
					powerUpCounter = 0
					trace("power up deactivated")
					powerUpActive = false
					currentBulletType = settings.BULLET_TYPE_1
					RenderManager.getInstance().hidePowerUp()
				}
				// display the power up time left
				
				var _displayPercent:Number = powerUpCounter/powerUpCounterMax
				RenderManager.getInstance().displayPowerUpTime(_displayPercent)
			}
		}
		public function addPowerUp(_loc:Point):void {
			trace("add power up - only 5 types at the moment",_loc)
			// add a power up based on the level
			var powerUpType:int = Math.random() * 5 + 1
			playSound("hitSatelite.wav")
			GenericItemManager.getInstance().addItem(_loc, settings.ITEM_POWER_UP,powerUpType)
						
		}
		private function findSateliteCounter():void {
			sateliteCounter = 400-(level*20)+Math.random()*400
		}
		private var sateliteCounter:int
		private var temp:Point = new Point()
		public function setup():void {
			Game.getInstance().addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler)
			Game.getInstance().addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler)
			if (CoreDataManager.getInstance() != null) {
				level = CoreDataManager.getInstance().startLevel 
			}

trace("starting level "+level)
			cannonVelocityPoint = new Point()
			mousePoint = new Point()
			playerLoc = new Point()
			playerLoc.x = 320
			playerLoc.y = 400
			
			cannonPower = 10
			playerIsAiming = true
			mouseIsDown = false
			addEnemyCounter = 0
			level_enemies_amount = level*10+20
			//level_enemies_amount = 3
			enemiesGenerated = 0
			currentBulletType = settings.BULLET_TYPE_1
			playerHealth = 100
			powerUpActive = false
			findSateliteCounter()
			
			// setup initial level stuff
			switch (level) {
				case 2:
					temp.x = 200
					temp.y = 220
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 440
					temp.y = 220
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER,settings.BLOCKER_1)
				break
				case 4:
					temp.x = 100
					temp.y = 240
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 540
					temp.y = 240
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 320
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER,settings.BLOCKER_1)
				break
				case 6:
					temp.x = 100
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 540
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x =100
					temp.y = 300
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x =540
					temp.y = 300
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER,settings.BLOCKER_1)
				break
				case 8:
					temp.x = 100
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 540
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x =100
					temp.y = 300
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x =540
					temp.y = 300
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 320
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER,settings.BLOCKER_1)
				break
				case 8:
					temp.x = 100
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 540
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x =100
					temp.y = 300
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x =540
					temp.y = 300
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 320
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER,settings.BLOCKER_1)
				break
				case 10:
					temp.x = 100
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 540
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x =100
					temp.y = 300
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x =540
					temp.y = 300
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER, settings.BLOCKER_1)
					temp.x = 320
					temp.y = 100
					GenericItemManager.getInstance().addItem(temp, settings.ITEM_BLOCKER,settings.BLOCKER_1)
				break
			}
			
			
			
		}
		private function manageEnemyAmounts():void {
			if (enemiesGenerated < level_enemies_amount) {
				addEnemyCounter--
				if (addEnemyCounter < 1) {
					findEnemyDelay()
					tempPoint.x = Math.random() * (settings.SCREEN_WIDTH - 200) + 100
					tempPoint.y = -50
					var ang:Number = TrigClass.findAngle( playerLoc, tempPoint)
					ang = Math.random()*30-15+90
					var tempPoint2:Point = TrigClass.findXYSpeed((ang+Math.random()*10-5), level)
					EnemyManager.getInstance().addEnemy(tempPoint, 90, 2, tempPoint2.x, tempPoint2.y)
					enemiesGenerated ++
				}
				
			}
			if (PlayingLoopManager.getInstance().gameState == settings.GS_PLAYING){
				if (enemiesGenerated >= level_enemies_amount) {
					if (EnemyManager.getInstance().enemyArray.length < 1) {
						var levelsUnlocked:int = SharedObjectManager.getInstance ().getData ("levelunlocked")
						if (levelsUnlocked < level +1) {
							levelsUnlocked  = level +1
						}
						SharedObjectManager.getInstance().setData ("levelunlocked",levelsUnlocked)
						// looks level is complete
						playSound("levelComplete.wav")
						CoreDataManager.getInstance().lastLevelCompleted = level
						PlayingLoopManager.getInstance().gameState = settings.GS_LEVEL_COMPLETE
						
						var levelCompleteCount:int = CoreDataManager.getInstance().ENEMY_VECTORS_DESTROYED
									levelCompleteCount ++
										CoreDataManager.getInstance().PLANETS_DEFENDED  = levelCompleteCount
										if (levelCompleteCount == 500) {
										//if (enemyKilledCount == 2) {
											_data.medalUnlocked = settings.MEDAL_50_PLANETS_DEFENDED;
											Broadcaster.dispatchEvent (new GameShellEvents(GameShellEvents.MEDAL_UNLOCKED,true,_data));
										}else if (levelCompleteCount == 100) {
											_data.medalUnlocked = settings.MEDAL_100_PLANETS_DEFENDED;
											Broadcaster.dispatchEvent (new GameShellEvents(GameShellEvents.MEDAL_UNLOCKED,true,_data));
										}
						
						
					}
				}
			}
			
		}
		private var _data:Object = new Object()
		private function findEnemyDelay():void {
			addEnemyCounter = 15 + 22-(level*2)+Math.random()*10
			/*
			switch (level) {
				case 1:
					addEnemyCounter = 25+int(Math.random()*25)
				break
				case 2:
					addEnemyCounter = 25+int(Math.random()*20)
				break
				case 3:
					addEnemyCounter = 25+int(Math.random()*15)
				break
				case 4:
					addEnemyCounter = 20+int(Math.random()*15)
				break
				case 5:
					addEnemyCounter = 15+int(Math.random()*15)
				break
				case 5:
					addEnemyCounter = 15+int(Math.random()*15)
				break
			}
			*/
		}
		public function addPoints (_num:int):void {
			score += _num;
			data.score = score;
			Broadcaster.dispatchEvent (new VDEvents(VDEvents.UPDATE_HUD));
			//RenderManager.getInstance().updateHUD()
		}
		
		public function playSound(_sound : String):void {
			if (CoreDataManager.getInstance().sfxState == VAR_ON) {
				//trace("play sound - "+_sound)
				SoundManager.playSound(_sound);
			}
		}
		public var data:Object = new Object()
		public var sfxState:Boolean = true
		public var tempPoint:Point = new Point()
		public var playerLoc:Point
		public var mousePoint:Point
		public var cannonRotation:Number
		public var cannonPower:Number
		public var cannonVelocityPoint:Point
		public var level_enemies_amount:int = 1
		public var level:int =1
		public var score:int = 0
		public var VAR_ON:int = 1
		public var VAR_OFF:int = 0
		public var _SoundManager:SoundManager
		public var mouseIsDown:Boolean
		public var playerIsAiming:Boolean
		public var aimingClipArray:Array
		private var addEnemyCounter:int
		private var enemiesGenerated:int
		
	}
}