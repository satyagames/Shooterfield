package com.jewelmaster {
	import flash.display.*
	import flash.events.Event
	public class fallItemsScreenClass extends MovieClip {
		
		private function loop(event:Event):void {
			n = _array.length
			while (n--) {
				_clip = _array[n]
				_clip.x+=_clip.vx
				_clip.y += _clip.vy
				_clip.vy +=.5
				if (_clip.y > 500) {
					_clip.vx = Math.random()*4-2
					_clip.vy = Math.random() * 2 + 1
					_clip.x = Math.random()*640
					_clip.y = -(Math.random()*200 + 50)
					_clip.gotoAndStop(int(Math.random()*10+1))
				}
			}
		}
		public function startEffect():void {
			addEventListener(Event.ENTER_FRAME,loop)
		}
		public function stopEffect():void {
			removeEventListener(Event.ENTER_FRAME,loop)
		}
		public function fallItemsScreenClass():void {
			//trace("setup falling items")
			_array = new Array()
			n = 30
			while (n--) {
				_clip = new gameCompletefallingClip()
				this.addChild(_clip)
				_clip.x = Math.random()*320 + 160
				_clip.y = Math.random () * 960 - 480
				_clip.scaleX = _clip.scaleY = Math.random()*1.2+.7
				_array.push(_clip)
				_clip.vx = Math.random()*6-3
				_clip.vy = Math.random() * 2 + 1
				_clip.gotoAndStop(int(Math.random() * 10 + 1))
				_clip.cacheAsBitmap = true
			}
			startEffect()
			this.mouseEnabled = false
			this.mouseChildren = false
			
		}
		
		
		private var _clip:MovieClip
		private var _array:Array
		private var n:int
	}
}