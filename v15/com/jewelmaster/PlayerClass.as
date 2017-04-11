package com.jewelmaster {

	public class PlayerClass extends ObjectClass {
		public function PlayerClass (basex:int, basey:int, x:Number, y:Number, type:int, subtype:int, animationFrame:int) {
			super (basex, basey, x, y, type, subtype, animationFrame)
			wait ()
		}
		
			public override function getAnimationFrame ():int {
				//////trace(current_state)
				if (_animationFrame < maxFrame) {
					_animationFrame++
				}
				return _animationFrame
			}
			public function moveLeft ():void {
				//trace("left")
				_animationFrame =settings.PLAYER_MOVING_LEFT_START
				maxFrame =settings.PLAYER_MOVING_LEFT_MAX
				
			}
			public function moveRight():void {
				//trace("right")
				_animationFrame =settings.PLAYER_MOVING_RIGHT_START
				maxFrame =settings.PLAYER_MOVING_RIGHT_MAX
				
			}
			public function moveDown ():void {
				//trace("down")
				_animationFrame =settings.PLAYER_MOVING_DOWN_START
				maxFrame =settings.PLAYER_MOVING_DOWN_MAX
				
			}
			public function wait ():void {
				//trace("wait")
				_animationFrame =settings.PLAYER_WAITING_START
				maxFrame =settings.PLAYER_WAITING_MAX
				
			}
			public function moveUp ():void {
				//trace("up")
				_animationFrame =settings.PLAYER_MOVING_UP_START
				maxFrame =settings.PLAYER_MOVING_UP_MAX
				
			}
			public function playerDies ():void {
				////trace("set dying frame")
				_animationFrame = settings.PLAYER_DYING_START;
				maxFrame =settings.PLAYER_DYING_MAX
			}
			public function playerWins():void {
			
				
				_animationFrame = settings.PLAYER_WIN_START;
				maxFrame = settings.PLAYER_WIN_MAX;
			}
			private var _animationFrame:int
			private var maxFrame:int
	}
}