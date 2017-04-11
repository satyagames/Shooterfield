package com.vd {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.EnemyEvents;
	import flash.display.MovieClip
	import flash.geom.Point
	import com.vd.ItemClass
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.math.TrigClass
	import com.terrypaton.effect.particleManagerClass
	import com.vd.settings
	public class EnemyClass {
		public function EnemyClass(startLoc:Point,_xVel:Number,_yVel:Number,_enemyType:int,_id:int,_maxYVelocity:Number = 1.5):void {
			enemyXVelocity = _xVel
			enemyYVelocity = _yVel
			enemyType = _enemyType
			//enemyType = 1
			enemyLoc = startLoc
			kill = false
			id = _id
			enemyState = ENEMY_FLOATING
			isDamaged = false
			animationFrame = animationFrameStart = enemyType
			animationFrameMax = animationFrame
			maxYVelocity = _maxYVelocity
			enemyRotationDir = 1
			enemyRadians = TrigClass.findRadiansFromSpeed(enemyXVelocity, enemyYVelocity)
			
		}
		
		public function getLoc():Point {
			return new Point(enemyLoc.x,enemyLoc.y)
		}
		
		public var animationFrameStart:int
		public var animationFrame:int
		public var animationFrameMax:int
		public var maxSwimmingSpeed:Number
		
		
		private var maxYVelocity:Number
		private function enemyFloating():void {
			animationFrame ++
			if (animationFrame > animationFrameMax) {
				animationFrame = animationFrameStart	
			}
				if (enemyLoc.y <40) {
						enemyYVelocity = 5
					}else {
						if (enemyYVelocity > maxYVelocity) {
							enemyYVelocity*=.8
						}
					}
				if (enemyType < settings.BONUS_1) {
						if (enemyLoc.x < 50) {
							enemyLoc.x = 50	
						}
						if (enemyLoc.x >590) {
							enemyLoc.x = 590	
						}
						if (enemyLoc.y > settings.PLANET_LEVEL) {
							
							//trace("player loses some life from enemy")
							DataManager.getInstance().damagePlayer(10)
							
							kill = true
						}
					}else {
						// bonus fly across the screen
						if (enemyLoc.x > 650) {
							kill = true
						}
					}
					//enemyRadians = (enemyRotation/180*Math.PI)
		}
		
		public function manageEnemy():void {
			
			switch(enemyState) {
				case ENEMY_FLOATING:
					enemyFloating()
				break
				
				
			
					
			}
			
			
			
			enemyLoc.x += enemyXVelocity
			enemyLoc.y += enemyYVelocity
			
			// create a trail after this enemy
			if (Math.random() < .25) {
				particleManagerClass.getInstance().createParticles(enemyLoc.x,enemyLoc.y,1,enemyType,enemyType)	
			}
			
		}
		public function hitEnemy(_num:Number = 1):void {
			isDamaged = true
			// damage the enemy, if it's damage is enough
			enemyHealth -= _num
			if (enemyHealth <= 0) {
				kill = true
				
			}
			
		
		}
		public function getEnemyType():int {
			return enemyType
		}
		private var enemyLoc:Point
		public var enemyXVelocity:Number
		private var enemyYVelocity:Number
		private var enemyType:int
		private var enemyMovementCounter:int
		public var enemyRotation:Number = 0
		public var enemyRotationDir:Number = 0
		public var enemyRadians:Number  = enemyRotation/180*Math.PI
		public var isDamaged:Boolean
		public var isCollected:Boolean
		public var hasDamagedPlayer:Boolean
		public var kill:Boolean
		public var id:int
		public var counter:int
		public var enemyState:int
		
		public var ENEMY_FLOATING:int = 10
		public var ENEMY_FALLING:int = 20
		public var ENEMY_LANDING:int = 30
		
		public var enemyHealth:Number = 1
		
	}
}