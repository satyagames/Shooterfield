package com.jewelmaster {
	import flash.display.MovieClip;
	import com.jewelmaster.settings
	public class renderItem extends MovieClip{
		public function renderItem (_bodyDef,x:Number, y:Number, type:int, rotation:Number,animationFrame:int) {
			body = _bodyDef
			_ix = x
			_iy = y
			_type =type
			_irot = rotation
			_active = true
			_animationFrame = animationFrame
			// determine how this item should be displayed
			switch (_type) {
				case settings.BOULDER:
					_baseFrame = settings.BOULDER_FRAME_START
				
				break
				case settings.DIRT:
					_baseFrame = settings.DIRT_FRAME_START
				
				break
				case settings.DIAMOND:
					_baseFrame = settings.DIAMOND_FRAME_START
				
				break
				case settings.ROCK:
					_baseFrame = settings.ROCK_FRAME_START
				
				break
				case settings.EXIT:
					_baseFrame = settings.EXIT_FRAME_START
				
				break
				case settings.DYNAMITE:
					_baseFrame = settings.DYNAMITE_FRAME_START
					////trace("RENDER dynamite frame = "+_baseFrame)
				
				break
				case settings.EXPLOSION:
					_baseFrame = settings.EXPLOSION_FRAME_START
					////trace("RENDER dynamite frame = "+_baseFrame)
				
				break
			}
		}
		public function getAnimationFrame ():int {
			
			_animationFrame =_baseFrame
			return _animationFrame
		}
		public var body:*
		public var _ix:Number
		public var _iy:Number
		public var _type:int
		public var _irot:Number
		public var _active:Boolean
		public var _animationFrame:int
		public var _animationCount:int
		public var _baseFrame:int
	}
	
}