package com.vd {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	
	public class StarField extends MovieClip {
		public function StarField():void {
			
		}
		public function init(_xsize:int=640,_ysize:int=480,_scroll1:int= 1,_scroll2:int= 2):Bitmap {
			starField1Scroll = _scroll1
			starField2Scroll = _scroll2
			xsize = _xsize
			ysize = _ysize
			starField1 = new BitmapData(_xsize, _ysize, true, 0x00000000)
			starField2 = new BitmapData(_xsize ,_ysize, false, 0x00000000)
			_bmpData = new BitmapData(_xsize ,_ysize, false, 0x00000000)
			_bmp = new Bitmap(_bmpData)
			
			var c:int = 20
			//var starColours:Array = [0xCCCCCC,0x777777,0xEEEEEE]
			//var starColours:Array = [0x777777,0x777777,0x777777]
			starColours = [0xff555555,0xff777777,0xffEEEEEE]
			while (c--) {
				var sx:int = Math.random()*xsize
				var sy:int = Math.random() * (ysize-4)+2
				var col:int = Math.random() * 3
				
				starField1.setPixel32(sx, sy, starColours[col])
				 sx = Math.random()*xsize
				 sy = Math.random() * (ysize-4)+2
				 col = Math.random() * 3
				starField2.setPixel32(sx,sy,starColours[col])
			}
			renderStarField(null)
			return _bmp
		}
		public function startEffect():void {
			this.addEventListener (Event.ENTER_FRAME, renderStarField);
			
		}
		public function stopEffect():void {
			this.removeEventListener (Event.ENTER_FRAME, renderStarField);
		}
		public function renderStarField(e:Event):void {
			starField1.scroll(0, starField1Scroll)
			starField2.scroll(0, starField2Scroll)
			
			if (starField1Scroll < 0) {
				// draw a line along the bottom
				if (Math.random()<.5){
					 col = Math.random() * 3
					starField2.setPixel32(int(Math.random()*640),477,starColours[col])
				}
				if (Math.random()<.5){
					 col = Math.random() * 3
					starField1.setPixel32(int(Math.random()*640),477,starColours[col])
				}
			}else if (starField1Scroll >0) {
				// draw a line along the bottom
				var n:int = Math.random() * 2
				while (n--) {
					if (Math.random()<.5){
						col = Math.random() * 3
						starField2.setPixel32(int(Math.random()*640),2,starColours[col])
					}
					if (Math.random()<.5){
						col = Math.random() * 3
						starField1.setPixel32(int(Math.random() * 640), 3, starColours[col])
					}
				}
			}
			// draw line of stars along the starfield
			_bmpData.copyPixels(starField2,starField1.rect,zeroPoint)
			_bmpData.copyPixels(starField1,starField1.rect,zeroPoint,null,null,true)
		}
		private var col:int
		private var xsize:int
		private var ysize:int
		private var _bmp:Bitmap
		private var _bmpData:BitmapData
		private var starField1:BitmapData
		private var starField2:BitmapData
		private var starField1Scroll:int
		private var starField2Scroll:int
		private var starColours:Array
		private var zeroPoint:Point = new Point(0,0)
		
		
	}
	
}