package com.vd{
	import flash.events.*;
	import flash.text.*;
	import flash.display.*;
	import flash.geom.*;
	import com.vd.vector3D
	import com.terrypaton.math.FindScreenCords
	public class RotatingSphere extends MovieClip {



	
		public function RotatingSphere ():void {
			
		}
		public var rotSpeed:int
		public var zRenderCutoff:int
		public var radius:Number
		public var maxNodes:Number = 360
		private var renderYOffset:Number 
		private var renderXOffset:Number 
		public function init (_col:uint = 0xFF0000,_x:int = 160,_y:int = 120,_radius:int= 1600,_closeness:int = 550,_xoff:Number = 0,_yoff:Number = 0 ,_zRenderCutoff:int = -50, _maxNodes:int = 360,_rotationSpeed:Number =.0002 ):Shape {
		
		rotSpeed = _rotationSpeed
			_findScreenCordsRef = new FindScreenCords ();
			zRenderCutoff = _zRenderCutoff
			//trace ("HEY");
			maxNodes = _maxNodes
			closeness = _closeness
			objectArray = [];
			zVelocity = 0;
			xVelocity = 0;
			yVelocity = 0;
			var _tx:Number;
			var wallType:int;
			var _ty:Number;
			var scounter:int = 0;
			var baseStep:Number= 25;
			var iCount:int = 5;
			var n:int = 20;
			var scaleit:int = 500;
			rot =0;
			depthStepping = 50;
			cameraView = new vector3D( 0,-300,-800);
			
			cameraView.rotation = 0;
			cameraView.upAngle =0;
			rotatingSpeed = 0;
			cameraView.focalLength = baseFocalLength = 380;
			
			cameraView.stageCenterX = _x
			cameraView.stageCenterY = _y
			
			
			
			_findScreenCordsRef.setupCameraRef (cameraView);
			
			
			cameraView.focalLength = 620
				
				cameraView.z = 6000
			cameraView.y = 0
			//addEventListener (Event.ENTER_FRAME, playingLoop);
			inited = true;
			try {
				
			//stage.addEventListener (KeyboardEvent.KEY_DOWN, keyDownHandler);
			//stage.addEventListener (KeyboardEvent.KEY_UP, keyUpHandler);
			}catch (e) {
				
			}
			if (Math.random() < .5) {
				axisRotations.x = _rotationSpeed
			}else {
				axisRotations.x =- _rotationSpeed
			}
			if (Math.random() < .5) {
				axisRotations.y = _rotationSpeed
			}else {
				axisRotations.y =- _rotationSpeed
			}
			if (Math.random() < .5) {
				axisRotations.z = _rotationSpeed
			}else {
				axisRotations.z =- _rotationSpeed
			}
			cameraBaseCord = new vector3D(0,0,0)
			var xrad:int
			 n = 20;
			
			var phi:Number
			var theta:Number
			
			//var radius:Number = 2500
			radius = _radius
			var offS:Number = -radius*.5
			for (var i:int = 0; i<maxNodes; i++) {
				phi = Math.acos(-1+(2*i-1)/maxNodes);
				theta = Math.sqrt(maxNodes*Math.PI)*phi;
				var particle:Object = new Object()
				// Coordinate conversion
				// radius - radius of the sphere
				particle.x = radius*Math.cos(theta)*Math.sin(phi);
				particle.y = radius*Math.sin(theta)*Math.sin(phi);
				particle.z = radius * Math.cos(phi);
				createNode(particle.x,particle.y,particle.z)
			}
			_lineRenderColour = _col
			
			//addChild(_bmp)
			findCloseNodes()
			
			// tally up the amount of nodes for 
			var totalNodes:int = 0
			
			var m:int = objectArray.length
			while (m--){
				var testNode:vector3D = objectArray [m] 
				var childNodes:Array = testNode.nearArray
				var o:int = childNodes.length
				while (o--) {
					var _vec2:vector3D = childNodes [o]
					_vec2.removeIfContains(testNode)
				}
				
			}
			/**/
			n = objectArray.length
			while (n--) {
				_vec2 = objectArray [n]
				totalNodes += _vec2.getNodeAmount()
			}
			
			//trace("totalNodes = " + totalNodes)
			
			
			renderShape = new Shape()
			addChild(renderShape)
			renderXOffset = _xoff
			renderYOffset = _yoff
			renderShape.x= _xoff
			renderShape.y = _yoff
			shakeCameraAmount = 0
			cameraShaking = false
			return renderShape
		}
		public function startSphere():void {
			//trace(" *** STARTING SPHERE")
			addEventListener (Event.ENTER_FRAME, playingLoop);
		}
		public function stopSphere():void {
			//trace(" *** STOPPING SPHERE")
			removeEventListener (Event.ENTER_FRAME, playingLoop);
		}
		private var cameraBaseCord:vector3D
		private var shakeCameraAmount:Number = 0
		private var cameraShaking:Boolean
		public function shakeCamera(_num:Number):void {
			shakeCameraAmount = _num
			cameraShaking = true
			cameraBaseCord.x = cameraView.x
			cameraBaseCord.y = cameraView.y
			cameraBaseCord.z = cameraView.z
		}
		
		private function findCloseNodes():void {
			// find neighbours for all nodes
			//closeness = radius*.45
			var n:int = objectArray.length
			while (n--) {
				var _vec:vector3D = objectArray [n]
				var k:int = objectArray.length
				while (k--) {
					var _vec2:vector3D = objectArray [k]
					if (_vec2 != _vec) {
						var vectorIsClose:Boolean = isClose(_vec, _vec2)
						//trace(vectorIsClose)
						if (vectorIsClose) {
							_vec.nearArray.push(_vec2)
						}
					}
				}
				
			}
		}
		public var _lineRenderColour:uint
		private var renderShape:Shape
		private var closeness:int = 550
		private function isClose(__vec,__vec2):Boolean {
			var xd:uint = Math.abs(__vec.x - __vec2.x)
			var yd:uint =  Math.abs(__vec.y - __vec2.y)
			var zd:uint =  Math.abs(__vec.z - __vec2.z)
			
			//if (xd < closeness && yd < closeness && zd < closeness) {
			if (xd < closeness && yd < closeness && zd < closeness) {
				return true
			}
			
			return false
		}
		private var _bmp:Bitmap
		private var _bmpData:BitmapData 
		private var axisRotations:Object = new Object()
		
		private function createNode(__x, __y, __z):void {
			var _vector3D:vector3D = new vector3D(__x, __y, __z)
			objectArray.push (_vector3D);
		
		}
		public function keyDownHandler (event:KeyboardEvent):void {

			//trace(event.keyCode)
			switch (event.keyCode) {
				case 32 :
					trace ("cameraView.focalLength = "+cameraView.focalLength);
					trace ("cameraView.x = "+cameraView.x);
					trace ("cameraView.y = "+cameraView.y);
					trace ("cameraView.z = "+cameraView.z);
					trace ("cameraView.upAngle= "+cameraView.upAngle);
					break;
				case 90 :
					zoomIn = true;
					break;
				case 88 :
				
					zoomOut = true;
					break;
				case 81 :
					movingForward = true;
					break;
				case 69 :
				//trace("movingBack")
					movingBack = true;
					break;
				case 68 :
					movingRight = true;
					break;
				case 87 :
					moveCameraUp = true;
					break;
				case 83 :
					moveCameraDown = true;
					break;
				case 65 :
					movingLeft = true;
					break;
				case 38 :
					movingUp = true;
					break;
				case 40 :
					movingDown = true;
					break;
			}
		}
		public function keyUpHandler (event:KeyboardEvent):void {

			//trace(event.keyCode)
			//switch(event.keyCode) {
			//case 39:
			movingBack = false;
			movingForward = false;
			movingRight = false
			;
			zoomIn = false
			;
			zoomOut = false
			;
			//case 37:
			movingLeft = false;
			//break
			//case 38:
			movingUp = false;
			//break
			//case 40:
			movingDown = false;
			//break
			//case 87:
			moveCameraUp = false;
			moveCameraDown = false;
			//break
			//}

		}
		public function playingLoop (e:Event) {
			//trace("inited:"+inited)
			if (inited) {
				if (cameraShaking) {
					
					//cameraView.x = cameraBaseCord.x + Math.random()*shakeCameraAmount - shakeCameraAmount*.5
					cameraView.y = cameraBaseCord.y + Math.random()*shakeCameraAmount - shakeCameraAmount*.5
					//cameraView.z = cameraBaseCord.z + Math.random() * shakeCameraAmount - shakeCameraAmount * .5
					shakeCameraAmount *= .95
					if (shakeCameraAmount < 5) {
						shakeCameraAmount = 0
						cameraShaking = false
					}
				}
				manageObjects ();
			}
		}
		private var _vector3D:vector3D
		public function manageObjects () {
				var x,y,z, xy,xz, yx,yz, zx,zy, scaleFactor;
			
			
				
				
			
			if (zoomIn) {
				cameraView.focalLength++;
			}
			if (zoomOut) {
				cameraView.focalLength--;
			}
			if (movingForward) {
				cameraView.z+=30
				;
			}
			if (movingBack) {
				cameraView.z -= 30
				;
			}
			if (moveCameraUp) {
				cameraView.y-=10;
			}
			if (moveCameraDown) {
				cameraView.y+=10;
			}
			if (movingUp) {
				cameraView.upAngle -=1/180*Math.PI;
			}
			if (movingDown) {
				cameraView.upAngle +=1/180*Math.PI;
			}
			if (movingLeft) {
				cameraView.x +=10;
			}
			if (movingRight) {
				cameraView.x -=10;
			}
			_findScreenCordsRef.setupCameraRef (cameraView);

			renderArray = [];

			objRot += rotSpeed;

			if (  objRot > 360) {
				objRot -= 360;
			}
			if (objRot < 0) {
				objRot += 360;
			}
			//axisRotations.y += 1 / 180 * Math.PI
			//axisRotations.z += 1 / 180 * Math.PI
			
			var sx = Math.sin(axisRotations.x);
			var cx = Math.cos(axisRotations.x);
			var sy = Math.sin(axisRotations.y);
			var cy = Math.cos(axisRotations.y);
			var sz = Math.sin(axisRotations.z);
			var cz = Math.cos(axisRotations.z);
	
	
			var m:int = objectArray.length;
			for (n =0; n < m; n++) {


				_vector3D = objectArray[n];
				
				x = _vector3D.x;
				y = _vector3D.y;
				z = _vector3D.z;
				// rotation around x
				xy = cx*y - sx*z;
				xz = sx*y + cx*z;
				// rotation around y
				yz = cy*xz - sy*x;
				yx = sy*xz + cy*x;
				// rotation around z
				zx = cz*yx - sz*xy;
				zy = sz*yx + cz*xy;
				
				_vector3D.x = zx
				_vector3D.y = zy
				_vector3D.z = yz;
				
				
				renderArray.push ( { obj:_vector3D, depth: Math.floor(_vector3D.z) } );
			}
			//renderArray.sortOn ("depth", Array.NUMERIC);

			n= objectArray.length;
			for (m =0; m < n; m++) {
				_vector3D = objectArray[m]
				display3DObject (_vector3D);
			}
			renderShape.graphics.clear()
			n= objectArray.length;
			for (m =0; m < n; m++) {
				_vector3D = objectArray[m]
				renderVectors (_vector3D);
			}
		}
		private var renderRect:Object = new Object()
		public function renderVectors(_vector3D:vector3D):void {
			// go through this objects friends and render them all
			var baseX:Number = _vector3D.renderX
			var baseY:Number = _vector3D.renderY
			
			if (baseX+renderXOffset >-50 && baseX+renderXOffset <690) {
				if (baseY+renderYOffset >-50 && baseY+renderYOffset <530) {
					var _rendArray:Array = [];
					_rendArray = _vector3D.nearArray;
					var c:int = _rendArray.length;
					//if (c>1){
						while (c--) {
							var _v:vector3D = _rendArray[c];
							if (_v.z>zRenderCutoff){
							if (Math.abs(_v.renderX) >0 && Math.abs(_v.renderY)>0) {
								
								renderShape.graphics.lineStyle(1,_lineRenderColour)
								renderShape.graphics.moveTo(baseX, baseY)
								renderShape.graphics.lineTo(_v.renderX, _v.renderY)
								
							}
							}
						
					}
				}
			}
		}
		public function display3DObject (_vector3D:vector3D):void {
			_tempArray = _findScreenCordsRef.translateCords (_vector3D);
			_tempPoint = new Point(_tempArray[0].screenx,_tempArray[0].screeny);
			_vector3D.renderX = _tempPoint.x
			_vector3D.renderY = _tempPoint.y
		}
		//private var myMatrix:Matrix = new Matrix();
		private var rotatingSpeed :Number;
		private var inited :Boolean = false;
		private var userInteracting :Boolean = false;
		private var mouseIsInteracting :Boolean = false;
		private var n:int;
		private var currentIntroPhoneImage:int =1;
		//private var _starClipRef:starClip;
		private var rotatingMaxSpeed:Number = -1;
		private var objRot:Number = 10;
		private var movingRight:Boolean;
		private var movingLeft:Boolean;
		private var movingUp:Boolean;
		private var movingDown:Boolean;
		private var moveCameraUp:Boolean;
		private var movingForward:Boolean;
		private var movingBack:Boolean;
		private var moveCameraDown:Boolean;
		private var zoomIn:Boolean;
		private var zoomOut:Boolean;
		private var _tempPoint:Point;
		private var windowLoc:Point;
		private var renderArray:Array = new Array();
		private var _tempArray:Array = new Array();
		private var objectArray:Array = new Array();
		private var worldObject:Object;
		private var totalTilesCount:int;
		private var _tempX:int;
		private var _tempY:int;
		private var amountOfCaveWalls:int;
		private var _tempScale:Number;
		private var xVelocity:Number;
		private var zVelocity:Number;
		private var yVelocity:Number;
		private var _gameWindowRef:MovieClip;
		private var _playerClipRef:MovieClip;
		private var _tempPoint1:Point;
		private var _tempPoint2:Point;
		private var angle:Number;
		private var radians:Number;
		private var baseFocalLength:Number;
		private var distanceFromPlayer:Number;
		private var dx:Number;
		private var dy:Number;
		private var depthStepping:int;
		private var distanceFromCamera:Number;
		private var dist:Number;
		private static  var gamePlayWidth:Number =320;
		private static  var gamePlayHeight:Number =240;
		private var _tunnelObjectClipRef:MovieClip;
		public var cameraView:vector3D;
		private var hitTestWallObject:Object;
		private var _findScreenCordsRef:FindScreenCords;
		private var rad:Number;
		private var rot:Number;
	}
}