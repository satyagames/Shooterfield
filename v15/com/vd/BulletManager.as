package com.vd {
	import com.vd.BulletClass
	import flash.geom.Point
	import com.terrypaton.math.TrigClass
	import com.terrypaton.events.PlayingLoopEvent
	import com.terrypaton.utils.Broadcaster
	import com.gameshell.DisplayManager
	import com.gameshell.CoreDataManager
	import com.gameshell.GameShellEvents
	import com.vd.settings
	
	public class BulletManager {
		public function BulletManager():void {
			_instance = this
			bulletArray = new Array()
		
		}
		public function dispose():void {
			enemyArray = []
			itemArray = []
			bulletArray = []
		}
		
		public static function getInstance ():BulletManager {
			return _instance;
		}
		public function fireBullet(_startLoc:Point, _xspeed:Number, _yspeed:Number, bulletType:int):void {
			// play a sound based on the weapon type
			var bulletCount:int = CoreDataManager.getInstance().BULLETS_FIRED
			bulletCount ++
			CoreDataManager.getInstance().BULLETS_FIRED  = bulletCount
			if (bulletCount == 5000) {
			//if (bulletCount == 5) {
				var _data:Object = new Object()
				_data.medalUnlocked = settings.MEDAL_5000_BULLETS_FIRED;
				Broadcaster.dispatchEvent (new GameShellEvents(GameShellEvents.MEDAL_UNLOCKED,true,_data));
			}
			switch (bulletType) {
				case settings.BULLET_TYPE_1:
					DisplayManager.getInstance().playSound("laserA_1.wav")
				break
				case settings.BULLET_TYPE_2:
					DisplayManager.getInstance().playSound("laserB_1.wav")
				break
				case settings.BULLET_TYPE_BIG:
					DisplayManager.getInstance().playSound("laserC_1.wav")
				break
				case settings.BULLET_TYPE_LASER:
					DisplayManager.getInstance().playSound("laserD_1.wav")
				break
			}
			
			var startLoc:Point = new Point(_startLoc.x,_startLoc.y)
			_BulletClassRef = new BulletClass(startLoc,_xspeed,_yspeed,bulletType)
			bulletArray.push(_BulletClassRef)
			n = bulletArray.length
			while (n--) {
				 _BulletClassRef = bulletArray[n]
			}
		}
		private var n:int
		private var hitDist:int
		private var _itemClass:ItemClass
		private var itemArray:Array
		public function manageBullets():void {
			//_DataManagerRef = DataManager.getInstance()
			enemyArray = EnemyManager.getInstance().getEnemyArray()
			itemArray = GenericItemManager.getInstance().getItemArray()
			var dist:Number
			n = bulletArray.length
			while (n--) {
				 _BulletClassRef = bulletArray[n]
				_BulletClassRef.manageBullet()
				var bulletLoc:Point = _BulletClassRef.getLoc()
				// test for any collision between items
				var j:int = itemArray.length
				while (j--) {
					_itemClass = itemArray[j]
					if (_itemClass.getitemType() != settings.ITEM_MULTI_HIT) {
						if (_itemClass.itemActiveCount <1){
							if (!_itemClass.kill ) {
								var itemLoc:Point = _itemClass.getLoc()
								dist = TrigClass.findDistance(itemLoc, bulletLoc)
								if (_BulletClassRef.getBulletType() == settings.BULLET_TYPE_BIG) {
									hitDist = 60
								}else {
									hitDist = 30
								}
								if (dist < hitDist) {
									//trace("ITEM DETECTED")
									if (_itemClass.getitemType() == settings.ITEM_BLOCKER && _BulletClassRef.getBulletType() != settings.BULLET_TYPE_LASER) {
										// OFFSET THE ITEM SO THAT IT IN NOT ISIDE IT
										var XD:int = itemLoc.x - bulletLoc.x
										var YD:int = itemLoc.y - bulletLoc.y
										//trace(XD,YD)
										if (Math.abs(XD) > Math.abs(YD)) {
												_BulletClassRef.reverseX()
												
												if (XD > 0) {
													
													bulletLoc.x = itemLoc.x - 30
												}else {
													bulletLoc.x = itemLoc.x + 30
												}
											}else {
												// YD is the higher value
												_BulletClassRef.reverseY()
												
												if (YD > 0) {
													
													bulletLoc.y = itemLoc.y - 30
												}else {
													bulletLoc.y = itemLoc.y + 30
												}
												
											}
										
										
										_BulletClassRef.hasHit(false)
									}else {
									
										_BulletClassRef.hasHit()
										if (_BulletClassRef.getBulletType() != settings.BULLET_TYPE_LASER) {
											_BulletClassRef.reverseY()
											//_BulletClassRef.reverseX()
											_BulletClassRef.bounceUp()
										}
										
									}
									_itemClass.hitItem()
									
									
								}
							}
						}
					}
				}
				//test for collisions between any enemies
				 j = enemyArray.length
				while (j--) {
					_EnemyClassRef = enemyArray[j]
					if (!_EnemyClassRef.isDamaged) {
						var enemyLoc:Point = _EnemyClassRef.getLoc()
						dist = TrigClass.findDistance(enemyLoc, bulletLoc)
						if (_BulletClassRef.getBulletType() == settings.BULLET_TYPE_BIG) {
							hitDist = 50
						}else {
							hitDist = 30
						}
						if (dist < hitDist) {
							_EnemyClassRef.isDamaged = true
							_EnemyClassRef.hitEnemy(_BulletClassRef.bulletStrength)
							_BulletClassRef.hasHit()
							var hitCount:int = _BulletClassRef.hitEnemyCount
							DataManager.getInstance().addPoints((hitCount * hitCount) * 50)
							DisplayManager.getInstance().playSound("enemyKilled_"+int(Math.random()*3+1)+".wav")
							
										if (_BulletClassRef.getBulletType() != settings.BULLET_TYPE_LASER) {
											_BulletClassRef.reverseY()
											_BulletClassRef.reverseX()
											_BulletClassRef.bounceUp()
										}
											var enemyKilledCount:int = CoreDataManager.getInstance().ENEMY_VECTORS_DESTROYED
										enemyKilledCount ++
										CoreDataManager.getInstance().ENEMY_VECTORS_DESTROYED  = enemyKilledCount
										if (enemyKilledCount == 100) {
										//if (enemyKilledCount == 2) {
											_data.medalUnlocked = settings.MEDAL_100_ENEMY_VECTORS_DESTROYED;
											Broadcaster.dispatchEvent (new GameShellEvents(GameShellEvents.MEDAL_UNLOCKED,true,_data));
										}else if (enemyKilledCount == 500) {
											_data.medalUnlocked = settings.MEDAL_500_ENEMY_VECTORS_DESTROYED;
											Broadcaster.dispatchEvent (new GameShellEvents(GameShellEvents.MEDAL_UNLOCKED,true,_data));
										}else if (enemyKilledCount == 1000) {
											_data.medalUnlocked = settings.MEDAL_1000_ENEMY_VECTORS_DESTROYED;
											Broadcaster.dispatchEvent (new GameShellEvents(GameShellEvents.MEDAL_UNLOCKED,true,_data));
										}
						}
						
					}
				}
				if (_BulletClassRef.kill) {
					bulletArray.splice(n,1)
				}
			}
		}
		private var _data:Object = new Object()
		public function getBulletArray():Array {
			return bulletArray
		}
		private var bulletArray:Array
		private var _BulletClassRef:BulletClass
		private var _GenericItemManagerRef:GenericItemManager;
		private static var _instance:BulletManager;
		private var _EnemyManagerRef:EnemyManager;
		private var enemyArray:Array;
		private var _EnemyClassRef:EnemyClass
		//private var _DataManagerRef:DataManager
	}
	
}