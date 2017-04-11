package com.vd {
	import com.terrypaton.events.EnemyEvents;
	import com.terrypaton.events.GeneralEvents;
	import flash.display.MovieClip
	import flash.geom.Point
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.math.TrigClass
	public class BulletClass {
		public function BulletClass(_startLoc:Point, _xVel:Number, _yVel:Number, _bulletType:int):void {
			bulletXVelocity = _xVel
			bulletYVelocity = _yVel
			bulletType = _bulletType
			bulletLoc = _startLoc
			kill = false
		}
		
		public function getLoc():Point {
			return bulletLoc
		}
		
		public function manageBullet():void {
			bulletLoc.x+=bulletXVelocity
			bulletLoc.y += bulletYVelocity
			bulletRadians= TrigClass.findRadiansFromSpeed(bulletXVelocity,bulletYVelocity)
			
			if (bulletType == settings.BULLET_TYPE_LASER) {
				if  (bulletLoc.y < -50) {
					kill = true
				}
			}else{
				bulletYVelocity += settings.GRAVITY
			}
			if (bulletLoc.y < -400  || bulletLoc.x <-100 || bulletLoc.x >750) {
				kill = true
			}
			if (bulletLoc.y > settings.PLANET_LEVEL ) {
				//var data:Object = { }
				//data.loc  = bulletLoc
				//Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.MAKE_SPLASH, true, data))
				//trace("bullet lands on planet")
				kill = true
			}
			
		}
		public function reverseY():void {
			bulletYVelocity = -bulletYVelocity * .6
			if (bulletYVelocity > 0 && bulletYVelocity< 2) {
				bulletYVelocity =2
			}
			if (bulletYVelocity < 0 && bulletYVelocity> -2) {
				bulletYVelocity =-2
			}
		}
		public function reverseX():void {
			bulletXVelocity = -bulletXVelocity
		}
		public function bounceUp():void {
			bulletYVelocity = -bulletYVelocity
			if (bulletYVelocity > 0) {
				bulletYVelocity = -bulletYVelocity * .6
				if (bulletYVelocity > -2) {
					bulletYVelocity = -2
				}
			}
		}
		public function hasHit(_addMulti:Boolean = true):void {
			hitEnemyCount++
			if (hitEnemyCount > 10) {
				kill = true
			}
			if (_addMulti){
				if (hitEnemyCount > 1) {
					var amountHit:int = 18 + hitEnemyCount
					if (amountHit > settings.HIT_10_TIMES) {
						amountHit = settings.HIT_MAX_TIMES
					}
					DataManager.getInstance().playSound("multiHit_1.wav")
					GenericItemManager.getInstance().addItem(bulletLoc, settings.ITEM_MULTI_HIT,amountHit)
				}
			}
		}
		public function getBulletType():int {
			return bulletType 
		}
		
		private var bulletLoc:Point = new Point()
		private var bulletXVelocity:Number 
		private var bulletYVelocity:Number 
		private var bulletType:int 
		public var bulletRadians:Number 
		public var bulletRotation:Number 
		public var hasDamaged:Boolean 
		public var kill:Boolean 
		public var hitEnemyCount:int = 0
		
		public var bulletStrength:Number = 1
		
		
		
		
		
	}
}