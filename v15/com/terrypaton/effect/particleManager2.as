package
{
	import flash.display. *
	import flash.events. *;
	import flash.utils. *
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import particleManagerClass
	import flash.system.System
	import flash.filters. *
	public class particleManager extends Sprite
	{
		public function particleManager ()
		{
			//startMemory = (System.totalMemory) / 1024
			//startTime = getTimer()
			var myBitmapData : BitmapData = new BitmapData (320, 240, true, 0x00000000);
			particleRenderBitmapData = new BitmapData (320, 240, true, 0x00000000);
			var rect : Rectangle = new Rectangle (0, 0, 320, 240);
			var backGroundBitmap : Bitmap = new Bitmap (myBitmapData);
			var paritcleRenderBitmap : Bitmap = new Bitmap (particleRenderBitmapData);
			addChild (backGroundBitmap)
			addChild (paritcleRenderBitmap)
			_reportBox = new reportBox ()
			addChild (_reportBox)
			specialEffectsActive = true
			particleHolder = new Sprite ()
			_effectSpriteSheet = new effectSpriteSheet (300, 100)
			particleManagerRef = new particleManagerClass (particleRenderBitmapData, _effectSpriteSheet)
			addChild (particleHolder)
			//var temBMP:Bitmap =  new Bitmap(_effectSpriteSheet)
			//addChild (temBMP)
			//trace("this")
			//var tTimer:Timer=new Timer(15);
			//tTimer.addEventListener(TimerEvent.TIMER, playingLoop);
			addEventListener (Event.ENTER_FRAME, playingLoop);
			//tTimer.start();
			//addEventListener(Event.ENTE 1R_FRAME, playingLoop);
			initCompleted = true
			//lastTime = getTimer()
			particleCount = 0
			stage.addEventListener (KeyboardEvent.KEY_DOWN, keyDownHandler);
			addEventListener (MouseEvent.MOUSE_DOWN, mouseDownHandler);
			//addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			currentEffectNum = 1
			matrix = new Array ();
			matrix = matrix.concat ([1, 0, 0, 0, 0]);
			// red
			matrix = matrix.concat ([0, 1, 0, 0, 0]);
			// green
			matrix = matrix.concat ([0, 0, 1, 0, 0]);
			// blue
			matrix = matrix.concat ([0, 0, 0,.5, 0]);
			// alpha
			filter = new ColorMatrixFilter (matrix);
			addChild (new Stats ());
		}
		private var particleRenderBitmapData : BitmapData
		private var filter : BitmapFilter
		private var matrix : Array
		private var clip : MovieClip
		public function mouseDownHandler (event : MouseEvent) : void
		{
			if (addEffector)
			{
				clip = new effectorClip ()
				addChild (clip)
				clip.x = mouseX
				clip.y = mouseY
				particleManagerRef.createEffector (mouseX, mouseY, clip, effectorNum, 4, 0, 80)
				clip.gotoAndStop (effectorNum + 1)
				//

			}
		}
		private var effectorNum : int = 0
		public function keyDownHandler (event : KeyboardEvent) : void
		{
			trace (event.keyCode)
			if (event.keyCode == 32)
			{
				if (addEffector)
				{
					addEffector = false
				} else
				{
					addEffector = true
				}
			}
			var num
			switch (event.keyCode)
			{
				case 49 :
				num = 0
				break
				case 50 :
				num = 1
				break
				case 51 :
				num = 2
				break
				case 52 :
				num = 3
				break
				case 53 :
				num = 4
				break
				case 54 :
				num = 5
				break
				case 48 :
				particleManagerRef.clearEffectors ()
				break
			}
			if (addEffector)
			{
				effectorNum = num
			} else
			{
				currentEffectNum = num
			}
			//currentEffectNum++
			//if (currentEffectNum > 6) {
			//currentEffectNum = 0
			//}

		}
		private var zeroPoint:Point = new Point()
		
		public function playingLoop (e : Event)
		{
			if (initCompleted)
			{
				particleRenderBitmapData.fillRect(particleRenderBitmapData.rect, 0x00000000)
				particleRenderBitmapData.applyFilter (particleRenderBitmapData, particleRenderBitmapData.rect, zeroPoint , filter);
				var particleCount : int = particleManagerRef.manageParticles ()
				particleEffect (currentEffectNum, mouseX, mouseY)
				_reportBox.textBox.text = "\nPARTICLES: " + particleCount
				
				
			}
		}
		public function particleEffect (_effectType : int, _xloc : int, _yloc : int) : void
		{
			//trace("particleEffect")
			if (specialEffectsActive)
			{
				switch (_effectType)
				{
					case PARTICLE_EFFECT_ELECTRICAL_CHARGE :
					particleManagerRef.createParticles (_xloc, _yloc, 2, P_ELECTRICAL)
					particleManagerRef.createParticles (_xloc + Math.random () * 10 - 5, _yloc + Math.random () * 10 - 5, 1, P_BLUE_FLASH)
					break
					case PARTICLE_EFFECT_WELD :
					particleManagerRef.createParticles (_xloc, _yloc, 1,P_LINE)
					if (Math.random () * 10 < 2)
					{
						particleManagerRef.createParticles (_xloc, _yloc - 10, 1, P_WHITE_SMOKE)
					}
					if (Math.random () * 10 < 4)
					{
						//particleManagerRef.createParticles(_xloc + Math.random() * 10 - 5, _yloc + Math.random() * 10 - 5, 1, "flash")
						particleManagerRef.createParticles (_xloc, _yloc, 1, P_FLICKER)
					}
					//particleManagerRef.createParticles(_xloc, _yloc, 1, "wandering line")
					break
					case PARTICLE_EFFECT_BLACK_SMOKE :
					if (Math.random () * 10 < 6)
					{
						particleManagerRef.createParticles (_xloc, _yloc - 10, 1, P_BLACK_SMOKE)
					}
					break
					case PARTICLE_EFFECT_SPARK :
					particleManagerRef.createParticles (_xloc, _yloc, 2, P_WANDERING)
					particleManagerRef.createParticles (_xloc, _yloc, 1, P_FLICKER)
					particleManagerRef.createParticles (_xloc, _yloc, 1, P_GROWING)
					particleManagerRef.createParticles (_xloc, _yloc - 10, 1, P_WHITE_SMOKE)
					break
					//case "battery dies":
					//particleManagerRef.createParticles(_xloc, _yloc, 3, "smoke")
					//particleManagerRef.createParticles(_xloc, _yloc, 3, "falling")
					//break
					case PARTICLE_EFFECT_WIRE_PICKEDUP :
					particleManagerRef.createParticles (_xloc, _yloc, 2, P_WANDERING)
					break
					case PARTICLE_EFFECT_CHIP_PLACED :
					particleManagerRef.createParticles (_xloc, _yloc, 1, P_FALLING)
					particleManagerRef.createParticles (_xloc, _yloc, 1, P_WANDERING)
					break
					case PARTICLE_EFFECT_FLICKER :
					particleManagerRef.createParticles (_xloc, _yloc, 1, P_FLICKER)
					break
				}
			}
		}
		public var particleHolder : Sprite
		public var addEffector : Boolean
		public var particleManagerRef : particleManagerClass
		public var _effectSpriteSheet : effectSpriteSheet
		//public var frameCount:int
		public var n : int
		public var particleCount : int
		//public var nowTime:Number
		//private var lastTime:Number
		//private var startTime:Number
		private var initCompleted : Boolean
		private var _reportBox : reportBox
		private var specialEffectsActive : Boolean
		private var currentEffectNum : int
		//private var startMemory:int
		private static var PARTICLE_EFFECT_WELD : int = 0
		private static var PARTICLE_EFFECT_SPARK : int = 1
		private static var PARTICLE_EFFECT_WIRE_PICKEDUP : int = 2
		private static var PARTICLE_EFFECT_CHIP_PLACED : int = 3
		private static var PARTICLE_EFFECT_ELECTRICAL_CHARGE : int = 4
		private static var PARTICLE_EFFECT_BLACK_SMOKE : int = 5
		private static var PARTICLE_EFFECT_FLICKER : int = 6
		
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
