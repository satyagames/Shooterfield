package com.terrypaton.items{
	import flash.geom.Point;
	public class CameraClass {
		public var cx:Number;
		public var cy:Number;
		public var cz:Number;
		public var crotation:Number;
		public var cangle:Number;
		public function CameraClass(_newx,_newy,_newz,_newRotation,_newAngle):void {
				trace("new CameraClass")
				cx = _newx;
				cy = _newy;
				cz = _newz;
				crotation = _newRotation;
				cangle = _newAngle;
		}

		
	}
}