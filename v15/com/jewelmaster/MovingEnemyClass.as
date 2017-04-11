package com.jewelmaster {

	public class MovingEnemyClass extends ObjectClass {
		public function MovingEnemyClass (basex:int, basey:int, x:Number, y:Number, type:int, subtype:int, animationFrame:int) {
			super (basex, basey, x, y, type, subtype, animationFrame)
			
			
			movingCount = int (Math.random () * 20)
			movingCountMax = 20
			_subtype = subtype
			//trace ("enemy subclass = " + _subtype)
			switch (_subtype) {
				case settings.ENEMY_TYPE_RANDOM:
					_baseFrame = settings.MOVING_ENEMY_START
					_maxFrame = settings.MOVING_ENEMY_MAX
				break
				case settings.ENEMY_TYPE_HORIZONTAL:
					_baseFrame = settings.MOVING_ENEMY_HORIZONTAL_START
					_maxFrame = settings.MOVING_ENEMY_HORIZONTAL_MAX
					xDir = 1
				break
				case settings.ENEMY_TYPE_VERTICAL:
					yDir = 1
					_baseFrame = settings.MOVING_ENEMY_VERTICAL_START
					_maxFrame = settings.MOVING_ENEMY_VERTICAL_MAX
				break
				case settings.ENEMY_TYPE_FOLLOW:
					if (Math.random () < .5) {
						yDir = 1
					}else {
						xDir = 1
					}
					_baseFrame = settings.MOVING_ENEMY_FOLLOW_START
					_maxFrame = settings.MOVING_ENEMY_FOLLOW_MAX
				break
			}
			
			_animationFrame = _baseFrame
		}
		
			public override function getAnimationFrame ():int {
				_animationCount++
				if (_animationCount > 10) {
					_animationFrame++
					if (_animationFrame > _maxFrame) {
						_animationFrame = _baseFrame
					}
				}
				return _animationFrame
			}
		
			private var _animationFrame:int
			private var maxFrame:int
			private var enemyType:int
			public var xDir:int
			public var yDir:int
	}
}