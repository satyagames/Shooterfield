package com.terrypaton.math{
   import flash.geom.Point;

   public class FindScreenCords {
	   public function FindScreenCords(){
		   //trace("new findScreenCords")
	   }
	   public function translateCords(_object:Object):Array {
		   _screenLocation = new Array()
		   var x = _object.x - cameraObject.x;
		   var y = _object.y - cameraObject.y;
		   var z = _object.z - cameraObject.z;
		   var tx, ty, tz;// temporary x, y and z variables;

		  tx = cameraCosRotation * x - cameraSinRotation * z;
		   tz = cameraSinRotation * x + cameraCosRotation * z;
		
		   x = tx;
		   z = tz;
		
		   ty = cameraCosUpAngle * y - cameraSinUpAngle * z;
		   tz = cameraSinUpAngle * y + cameraCosUpAngle * z;
		
		   y = ty;
		   z = tz;
		
		   var scaleRatio:Number = focalLength / (focalLength + z);
		
		   _screenLocation.push({screenx:cameraObject.stageCenterX+x * scaleRatio, screeny:cameraObject.stageCenterY+y * scaleRatio,depth:Math.round ( -z),scale:100 * scaleRatio});
	
		
		   return _screenLocation
	   }
	   public function setupCameraRef(_camera:Object):void{
		   cameraObject = _camera
		
		   cameraCosRotation = Math.cos (cameraObject.rotation)
		   cameraSinRotation = Math.sin(cameraObject.rotation)
		   cameraCosUpAngle = Math.cos(cameraObject.upAngle)
		   cameraSinUpAngle = Math.sin(cameraObject.upAngle)
		
		   focalLength = _camera.focalLength
	
	   }
	
	   private var cameraObject:Object
	   private var _tempObject:Object
	
	   private var _screenLocation:Array
	
	   private var cameraCosRotation:Number
	   private var cameraSinRotation:Number
	   private var cameraCosUpAngle:Number
	   private var cameraSinUpAngle:Number
	   private var focalLength:Number
	   private var x:Number
	   private var y:Number
	   private var z:Number
   }
}