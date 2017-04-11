package com.terrypaton.effect
{
	import flash.display. *;
	import flash.geom.Point;
	import com.vd.settings
	public class particleClass
	{
		public var lastX : Number;
		public var lastY : Number;
		public var x : Number;
		public var y : Number;
		private var bx : Number;
		private var by : Number;
		//private var gravity:Number;
		public var alive : Boolean;
		public var moving : Boolean;
		public var life : int;
		public var alphaVal : Number;
		public var dx : Number;
		public var dy : Number;
		public var gx : Number;
		public var gy : Number;
		public var reduceAlpha : Number;
		public var scale : Number;
		public var _speed : Number;
		private var rot : Number;
		private var radians : Number;
		private var angle : Number;
		private var sheetX : Number;
		private var sheetY : Number;
		private var xSize : Number;
		private var ySize : Number;
		//private var spriteRef:Sprite;
		public var bitmapRef : Bitmap;
		public var particleType : int;
		public var baseAlpha : Number;
		private var P_ELECTRICAL:int = 1
		private var P_WANDERING_LINE:int = 2
		private var P_LINE:int = 3
		private var P_FALLING:int = 4
		private var P_WANDERING:int = 5
		private var P_GROWING:int = 6
		private var P_WHITE_SMOKE:int = 7
		private var P_BLACK_SMOKE:int = 8
		private var P_BLUE_FLASH:int = 9
		private var P_FLASH:int = 10
		private var P_FLICKER:int = 11
		public var xpos : int // position in the bitmap to copy from
		public function particleClass (_x : int, _y : int, _particleType : int, _xSize : Number, _ySize : Number, _sheetX, _sheetY)
		{
			particleType = _particleType
			lastX = x = _x
			lastY = y = _y
			alive = true
			xSize = _xSize
			ySize = _ySize
			life = 60
			sheetX = _sheetX
			sheetY = _sheetY
			sheetLoc.x = sheetX
			sheetLoc.y = sheetY
			alphaVal = 1
			rot = Math.random () * Math.PI
			baseAlpha = 1
			moving = true
			// setup defaults
			scale = 1
			var _startRotation : Number = Math.random () * 360
			var _gravitySpeed : Number = 2
			var _gravityAngle : Number = 90
			reduceAlpha = 0
			_speed = 2
			angle = Math.random () * 360
			// now change the defaults depending on the particle
			if (particleType < 11) {
				angle = Math.random () * 360
					//scale = Math.random () * 1 +.5
					_speed = 0
					//_gravitySpeed =.2
					life = 80
					_gravitySpeed = 0
					reduceAlpha = 1 / life
					//reduceAlpha = 0
					
					x += Math.floor (Math.random () * 10 - 5)
					y += Math.floor (Math.random () * 10 - 5)
			}
			switch (particleType)
			{
				case settings.PARTICLE_EXPLOSION_1:
					angle = Math.random () * 360
					scale = Math.random () * 1 +.5
					_speed = 2
					//_gravitySpeed =.2
					life = 30
					_gravitySpeed = 0
					reduceAlpha = 1 / life
					//reduceAlpha = 0
					x += Math.floor (Math.random () * 10 - 5)
					y += Math.floor (Math.random () * 10 - 5)
					
					
				break
				case settings.PARTICLE_EXPLOSION_2:
					angle = Math.random () * 360
					scale = Math.random () * 1 +.5
					_speed = 3
					life = 20
					_gravitySpeed = 0
					reduceAlpha = 1 / life
					//reduceAlpha = 0
					x += Math.floor (Math.random () * 10 - 5)
					y += Math.floor (Math.random () * 10 - 5)
					
					
				break
			}
			
			radians = (_gravityAngle) * Math.PI / 180;
			gx = (_gravitySpeed * Math.cos (radians));
			gy = (_gravitySpeed * Math.sin (radians))
			// movement
			radians = angle * Math.PI / 180;
			bx = (_speed * Math.cos (radians));
			by = (_speed * Math.sin (radians))

		}
		private var returnPoint:Point = new Point()
		public function getParticleType () : int {
			return particleType
		}
		public function getSheetloc () : Point
		{
			
			
			return sheetLoc
		}
		private var sheetLoc:Point = new Point()
		public function getScale () : Number
		{
			return scale
		}
		
		public function getSize () : Point
		{
			//trace("getSize = "+xSize)
			returnPoint.x = xSize
			returnPoint.y = ySize
			return returnPoint
		}
		public function getAlpha () : Number
		{
			return alphaVal
		}
		public function getRot () : Number
		{
			return rot
		}
		public function getLoc () : Point
		{
			returnPoint.x = x - xSize / 2
			returnPoint.y = y - ySize / 2
			return returnPoint
		}
		
		public function effectParticle (_vx, _vy)
		{
			x += _vx
			y += _vy
		}
		private function managetrailParticle():void {
			//gx = Math.random () *.1 -.05
			//gy = Math.random () *.1 -.05
		}
		public function moveit ()
		{
			if (alive)
			{
				life --
				if (life < 1)
				{
					alive = false
				}
				/**/
				switch (particleType)
				{
					case settings.PARTICLE_ENEMY_TRAIL_1:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_2:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_3:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_4:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_5:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_6:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_7:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_8:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_9:
						managetrailParticle()
					break
					case settings.PARTICLE_ENEMY_TRAIL_10:
						managetrailParticle()
					break
					case settings.PARTICLE_EXPLOSION_1:
						dx = x - lastX
						dy = y - lastY
						radians = Math.atan2 (dy, dx)
						rot = radians * 180 / Math.PI
					break
					case settings.PARTICLE_EXPLOSION_2:
						gx = Math.random () * 2 -1
						gy = Math.random () * 2 -1
						dx = x - lastX
						dy = y - lastY
						radians = Math.atan2 (dy, dx)
						rot = radians * 180 / Math.PI
					break
				}
				if (y > 480 || y < 0 || x > 640 || x < 0){
					alive = false
				}
				lastX = x
				lastY = y
				x += bx
				y += by
				bx += gx
				by += gy
				if (Math.abs (bx) <.1 && Math.abs (by) <.1)
				{
					moving = false
				}
				if (reduceAlpha != 0)
				{
					
					//alphaVal -= reduceAlpha
					alphaVal *=.98
					if (alphaVal <.05)
					{
						alive = false
					}
				}
			}
		}
	}
}
