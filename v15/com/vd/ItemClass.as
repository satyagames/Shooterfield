package com.vd {
	import flash.display.MovieClip
	import flash.geom.Point
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.math.TrigClass
	import com.terrypaton.effect.particleManagerClass
	public class ItemClass {
		public function ItemClass(_startLoc:Point,_life:int,_itemType:int,_itemSubType:int = -1):void {
			//trace("add in an item")
			itemType = _itemType
			itemLoc = _startLoc
			life = _life
			kill = false
			alphaVal = 1
			if (_itemSubType < 0) {
				itemSubType = Math.random() * 3
			}else {
				itemSubType = _itemSubType
			}
			
			itemState = IS_NORMAL
			itemActiveCount = 0
			
			switch(_itemType) {
				case settings.ITEM_POWER_UP:
					animationFrame = baseAnimationFrame = itemSubType 
					itemActiveCount= 10
				break
				
				case settings.ITEM_MULTI_HIT:
					totalLife = life = 30
					itemYVelocity = -0.1
					animationFrame = baseAnimationFrame  = itemSubType 
				break
				case settings.ITEM_SATELITE:
					if (_startLoc.x < 0) {
						
						itemXVelocity = 2+Math.random()*2
						itemYVelocity= Math.random()*1-.5
					}else {
						itemXVelocity = -(2+Math.random()*2)
						itemYVelocity= Math.random()*1-.5
					}
					animationFrame = baseAnimationFrame  = itemSubType
				break
				case settings.ITEM_BLOCKER:
					animationFrame = baseAnimationFrame = itemSubType 
				break
				
			}
			
			
		}
		
		public var totalLife:int
		public var alphaVal:Number
		public function getLoc():Point {
			return itemLoc
		}
		public function setLoc(_xLoc:Number,_yLoc:Number):void {
			itemLoc.x = _xLoc
			itemLoc.y = _yLoc
		}
		public function manageItem():void {
		
			// based on the item type do various things
			switch(itemState) {
				case IS_NORMAL:
					switch(itemType) {
					case settings.ITEM_SATELITE:
						itemLoc.x+=itemXVelocity
						itemLoc.y += itemYVelocity
						if (itemXVelocity > 0) {
							if (itemLoc.x > 650) {
								kill = true
							}
						}else {
							if (itemLoc.x <-20) {
								kill = true
							}
						}
						
					break
					case settings.ITEM_BLOCKER:
					
					break
					case settings.ITEM_POWER_UP:
						if (itemActiveCount > 0) {
							itemActiveCount --
						}
					break
					case settings.ITEM_MULTI_HIT:
						itemLoc.y += itemYVelocity
						itemYVelocity *= 1.1
						alphaVal = life / totalLife
						life --
						if (life < 1) {
							kill = true
						}
					break
					
				}
				break
				
			}
			
		}
		public var itemActiveCount:int = 0
		public function hitItem():void {
			if (itemType == settings.ITEM_POWER_UP){
				kill = true
				trace("ITEM_POWER_UP HIT")
				
				// give the player what ever this item holds
				DataManager.getInstance().addPoints(1000)
				DataManager.getInstance().playSound("hitBonus.wav")
				
				particleManagerClass.getInstance().createParticles(itemLoc.x,itemLoc.y,5,settings.PARTICLE_EXPLOSION_1,1)
				particleManagerClass.getInstance().createParticles(itemLoc.x,itemLoc.y,15,settings.PARTICLE_EXPLOSION_2,1)		
			
				switch(itemSubType) {
					case settings.POWERUP_LASER:
						DataManager.getInstance().activePowerUp(settings.POWERUP_LASER)
					break
					case settings.POWERUP_BIG_BULLET:
						DataManager.getInstance().activePowerUp(settings.POWERUP_BIG_BULLET)
					break
					case settings.POWERUP_RAPID_FIRE:
						DataManager.getInstance().activePowerUp(settings.POWERUP_RAPID_FIRE)
					break
					case settings.POWERUP_SPRAY_1:
						DataManager.getInstance().activePowerUp(settings.POWERUP_SPRAY_1)
					break
						case settings.POWERUP_SPRAY_2:
						DataManager.getInstance().activePowerUp(settings.POWERUP_SPRAY_2)
					break
						case settings.POWERUP_WAVY:
						DataManager.getInstance().activePowerUp(settings.POWERUP_WAVY)
					break
					case settings.POWERUP_HOMING:
						DataManager.getInstance().activePowerUp(settings.POWERUP_HOMING)
					break
					case settings.POWERUP_LIGHTNING:
						DataManager.getInstance().activePowerUp(settings.POWERUP_LIGHTNING)
					break
					
				}
			}
			if (itemType == settings.ITEM_BLOCKER) {
				trace("hit blocker")
				//DataManager.getInstance().playSound("hitBlocker_" + int((Math.random() * 5) + 1) + ".wav")
				DataManager.getInstance().playSound("hitBlocker.wav")
				DataManager.getInstance().addPoints(20)
			}
			if (itemType == settings.ITEM_SATELITE) {
				kill = true
				// give the player what ever this item holds
				DataManager.getInstance().addPoints(750)
				DataManager.getInstance().playSound("hitSatelite.wav")
				
				particleManagerClass.getInstance().createParticles(itemLoc.x,itemLoc.y,5,settings.PARTICLE_EXPLOSION_1,1)
				particleManagerClass.getInstance().createParticles(itemLoc.x,itemLoc.y,15,settings.PARTICLE_EXPLOSION_2,1)		
			particleManagerClass.getInstance().createParticles(itemLoc.x,itemLoc.y,5,settings.PARTICLE_EXPLOSION_1,3)
				particleManagerClass.getInstance().createParticles(itemLoc.x,itemLoc.y,15,settings.PARTICLE_EXPLOSION_2,2)	
				//switch(itemSubType) {
				//case settings.SATELITE_TYPE_1:
						//DataManager.getInstance().addPowerUp(itemLoc)
						DataManager.getInstance().activePowerUp((int(Math.random()*5)+1))
					//break
					//case settings.SATELITE_TYPE_2:
						//DataManager.getInstance().addPowerUp(itemLoc)
						//
					//break
					//case settings.SATELITE_TYPE_3:
						//DataManager.getInstance().addPowerUp(itemLoc)
					//break
				//}
			}
			//trace("kill = "+kill)
			
		}
		
		public function getitemType():int {
			return itemType 
		}
		
		private var itemLoc:Point = new Point()
		private var itemXVelocity:Number = 0 
		private var itemYVelocity:Number = 0
		private var itemType:int 
		public var itemRadians:Number  = 0
		public var itemRotation:Number 
		public var isDamaged:Boolean 
		public var kill:Boolean 
		public var life:int 
		public var itemSubType:int 
		public var itemState:int 
		private var IS_NORMAL:int =0
		private var IS_EXIT:int = 1
		private var baseAnimationFrame:int 
		private var animationTotalFrames:int = 29
		public var animationFrame:int
		public var animationFrameStart:int
		public var maxAnimationFrame:int
	}
}