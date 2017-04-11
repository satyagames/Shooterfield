package com.vd{
	import flash.display.MovieClip;
	
	public class vector3D {
		public function vector3D(_x:Number,_y:Number,_z:Number):void {
			x = _x
			y = _y
			z = _z
			nearArray = new Array()
		}
		public function removeIfContains(_neighbour:vector3D):void {
			var j: int = nearArray.length
			while (j--) {
				var test:vector3D = nearArray[j]
				if (test == _neighbour) {
					nearArray.splice(j, 1)
					break
				}
			}
		}
		public function addNearPoint(_neighbour:vector3D):void {
			nearArray.push(_neighbour)
		}
		public function getNodeAmount():int {
			return nearArray.length
		}
		public var renderX:Number
		public var renderY:Number
		public var x:Number
		public var y:Number
		public var z:Number
		public var stageCenterX:Number
		public var stageCenterY:Number
		public var rotation:Number
		public var upAngle:Number
		public var focalLength:Number
		public var obj:MovieClip
		public var nearArray:Array
		
		
	}
	
}