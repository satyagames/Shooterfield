package com.jewelmaster {
	import flash.display.MovieClip;
	import com.jewelmaster.JewelMasterEvents
	import com.terrypaton.utils.Broadcaster
	import com.jewelmaster.settings
	public class ObjectClass extends MovieClip{
		public function ObjectClass (basex:int,basey:int,x:Number, y:Number, type:int,subtype:int,animationFrame:int) {
		_basex= basex
		_basey= basey
			_ix = x
			_iy = y
			_type =type
			_irot = rotation
			_active = true
			_animationFrame = animationFrame
			_subtype = subtype
			destroy = false
			moving = false
			falling = false
			rolling = false
			activated = false
			animating = false
			swapping = false
			current_state = 1
			// determine how this item should be displayed
			_baseFrame = settings.DIAMOND_FRAME_START
			_maxFrame = settings.DIAMOND_FRAME_START
			
			_animationFrame =_baseFrame
		}
		
		private var _data:Object
		public function getAnimationFrame ():int {
			_animationFrame = _baseFrame+_subtype
			
			
			//
			return _animationFrame
		}
		public function explosionCascade():void {
			_animationFrame = _maxFrame
		}
		public var _ix:Number
		public var _targetx:Number
		public var _targety:Number
		public var _iy:Number
		public var _nextbasex:Number
		public var _nextbasey:Number
		public var _basex:Number
		public var _basey:Number
		public var xspeed:Number = 0
		public var yspeed:Number = 0
		public var _type:int
		public var _irot:Number
		public var _active:Boolean
		private var _animationFrame:int
		public var _subtype:int
		public var _animationCount:int
		public var _baseFrame:int
		public var _maxFrame:int
		public var destroy:Boolean
		public var moving:Boolean
		public var falling:Boolean
		public var rolling:Boolean
		public var animating:Boolean
		public var activated:Boolean
		public var swapping:Boolean
		public var movingCount:int
			public var movingCountMax:int
		public var current_state:int
	}
	
}