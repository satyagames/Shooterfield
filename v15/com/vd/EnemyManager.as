package com.vd {
	import com.vd.EnemyClass
	import flash.geom.Point
	import com.terrypaton.effect.particleManagerClass
	
	import com.terrypaton.events.PlayingLoopEvent
	import com.terrypaton.utils.Broadcaster
	public class EnemyManager {
		public function EnemyManager():void {
			_instance = this
			enemyArray = new Array()
			
			enemyCount = 0
			
		}
		
		public function dispose():void {
			enemyCount = 0
			enemyArray = []
		}
		public static function getInstance ():EnemyManager {
			return _instance;
		}
		private var enemySubtype:int
		
		
		
		public function addEnemy(_startLoc:Point, _angle:Number, _speed:Number, _xspeed:Number, _yspeed:Number):void {
			
			var enemyType:int = Math.random() * 5 + 1
			enemyCount++
			enemyCount++
			var startLoc:Point = new Point(_startLoc.x, _startLoc.y)
			// create a new ballon or umbrella for the enemy to hold onto
			_GenericItemManagerRef = GenericItemManager.getInstance()
			if (enemyType == 5) {
				enemySubtype = 3
			}else {
				enemySubtype = -1
			}
			//_itemClassRef = _GenericItemManagerRef.addItem(startLoc, settings.ITEM_PIRATES_FLAYING_MACHINE,enemySubtype-1)
			
			//trace("enemyType = "+enemyType)
			//trace("enemySubtype = "+enemySubtype)
			var speed:Number = 1.25+(DataManager.getInstance().level * .25)
			if (speed < 1.5) {
				speed = 1.5
			}
			if (speed > 3) {
				speed = 3
			}
			//trace("speed = "+speed)
			var _EnemyClassRef:EnemyClass = new EnemyClass(startLoc,_xspeed,_yspeed,enemyType,enemyCount,speed)
			enemyArray.push(_EnemyClassRef)
			//enemyArray[0] = _EnemyClassRef
		}
		private var n:int 
		private var enemyLoc:Point = new Point()
		public function manageEnemies():void {
			n = enemyArray.length
			while (n--) {
				_EnemyClassRef = enemyArray[n]
				_EnemyClassRef.manageEnemy()
				if (_EnemyClassRef.kill) {
					// create an explosion where this enemy is
					enemyLoc = _EnemyClassRef.getLoc()
					particleManagerClass.getInstance().createParticles(enemyLoc.x,enemyLoc.y,5,settings.PARTICLE_EXPLOSION_1,_EnemyClassRef.getEnemyType())
					particleManagerClass.getInstance().createParticles(enemyLoc.x,enemyLoc.y,15,settings.PARTICLE_EXPLOSION_2,_EnemyClassRef.getEnemyType())
					enemyArray.splice(n,1)
				}
			}
			
		}
		public function getEnemyArray():Array {
			return enemyArray
		}
		public var enemyArray:Array 
		private var _itemClassRef:ItemClass 
		private var _EnemyClassRef:EnemyClass 
		private var _GenericItemManagerRef:GenericItemManager;
		private static var _instance:EnemyManager;
		private var enemyCount:int
	}
	
}