package com.terrypaton.effect {
	import flash.display. *;
	import flash.utils. *
	import flash.geom. *;
	import com.terrypaton.effect.particleClass
	import com.vd.settings
	public class particleManagerClass	{
		private var particleHolder : BitmapData
		private var newParticle : particleClass
		private var renderMatrix : Matrix = new Matrix ()
		private var gravityAngle : Number
		private var gravitySpeed : Number
		private var particleSize : Number
		private var particleCounter : Number
		private var _particleBitmapLoc : Point = new Point ()
		private var _particleXSize : int
		private var _particleYSize : int
		private var particleSpriteSheet : BitmapData
		private var alphaBitmap : BitmapData
		private var particleArray : Array
		public function particleManagerClass (){
			//trace ("particle manager init")
			particleSize = 10
			particleCounter = 0
			particleArray = []
			_instance = this
		}
		private var inited:Boolean=false
		public function killAllParticles () : void{
			//trace("kill all particles")
			var p:int = particleArray.length
			while (p--) {
				var particle:particleClass = particleArray[p]
				particle = null
				particleArray.splice(p,1)
			}
			particleArray = []
		}
		public function createParticles (x : Number, y : Number, _amount : int, _type : int,_subtype:int = 1) {
			while (_amount --){
				generateParticle (x, y, _type,_subtype)
			}
		}
		public static function getInstance ():particleManagerClass {
			return _instance;
		}
		private static  var _instance:particleManagerClass;
		private var zeroPoint : Point = new Point ()
		private var _particleSize : Point = new Point ()
		private var copyRect : Rectangle = new Rectangle (0, 0, 10, 10)
		private var pCount : int
		private var particleScale : Number
		
		public function manageParticles (particleHolder,particleSpriteSheet) : void	{
			pCount = 0
			var p:int = particleArray.length
			while (p--) {
			var particle:particleClass = particleArray[p]
				pCount++
				//trace( particle.alive)
				if ( ! particle.alive){
					particleArray.splice(p,1)
				} else{
					particle.moveit ();
					_particleSize = particle.getSize ()
					_particleBitmapLoc = particle.getSheetloc ()
					particleScale = particle.getScale ()
					var pxSize : int = Math.floor (_particleSize.x * particleScale)
					var pySize : int = Math.floor (_particleSize.y * particleScale)
					if (pxSize < 1)
					{
						pxSize = 1
					}
					if (pySize < 1)
					{
						pySize = 1
					}
					//trace("copyRect = "+copyRect)
					//trace("getParticleType = "+particle.getParticleType())
					var particleBitmap : BitmapData = new BitmapData (_particleSize.x , _particleSize.y,true, 0x00000000);
				
					copyRect.x = _particleBitmapLoc.x
					copyRect.y = _particleBitmapLoc.y
					copyRect.width = _particleSize.x
					copyRect.height = _particleSize.y
					//trace("copyRect = "+copyRect)
					particleBitmap.copyPixels (particleSpriteSheet, copyRect, zeroPoint, null, null, true)
					
					tempLoc = particle.getLoc ()
					cTransform.alphaMultiplier = particle.getAlpha ()
					renderMatrix.identity ()
					renderMatrix.scale(particleScale,particleScale)
					trot = particle.getRot () / 180 * Math.PI
					renderMatrix.rotate (trot);
					var tx:Number = copyRect.width/2*particleScale
					var ty:Number = copyRect.height/2*particleScale
					var cosr:Number = Math.cos(trot)
					var sinr:Number = Math.sin(trot)
					var xv:Number  = cosr *tx
					var xv2:Number  = sinr * tx
					var yv:Number  = sinr * ty
					var yv2:Number  = cosr * ty
					renderMatrix.translate (tempLoc.x - (xv - xv2) + tx , tempLoc.y - (yv + yv2) + ty);
					particleHolder.draw (particleBitmap, renderMatrix, cTransform)
				}
			}
			//return (pCount)
		}
		private var trot : Number
		private var tempLoc : Point = new Point ()
		private var cTransform : ColorTransform = new ColorTransform ();
		private function generateParticle (x : Number, y : Number, _typeOfParticle : int,_particleSubtype:int = 1){
			_particleBitmapLoc = new Point (0, 0)
			_particleXSize = 10
			_particleYSize = 10
			if (_typeOfParticle < 11) {
				_particleBitmapLoc.x	= (_particleSubtype-1)*2
				_particleBitmapLoc.y	= 0
				_particleYSize = _particleXSize = 2
			}
			switch (_typeOfParticle) {
				
				case settings.PARTICLE_EXPLOSION_1 :
					_particleBitmapLoc.x	=  (_particleSubtype-1)*3
					_particleBitmapLoc.y	= 20
					_particleXSize = 3
					_particleYSize = 3
				break
				case settings.PARTICLE_EXPLOSION_2 :
					_particleBitmapLoc.x	=  (_particleSubtype-1)*3
					_particleBitmapLoc.y	= 20
					_particleXSize = 3
					_particleYSize = 3
				break
				
			}
			newParticle = new particleClass (x, y, _typeOfParticle, _particleXSize, _particleYSize, _particleBitmapLoc.x, _particleBitmapLoc.y);
			particleArray.push (newParticle)
		
			particleCounter++
			//trace(particleCounter)
		}
		
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
	}
}
