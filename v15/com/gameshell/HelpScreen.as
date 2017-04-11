package com.gameshell {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.ButtonEvent;
	import flash.display.*;
	import com.terrypaton.utils.Broadcaster;
	import flash.events.MouseEvent;
	import com.gs.*;
	import com.gameshell.GameShellEvents;
	import com.gs.easing.*;
	import flash.events.*;
	
	import com.vd.RotatingSphere
	import com.vd.StarField
	public class HelpScreen extends MovieClip {
		public function HelpScreen():void {
			_instance = this
			//Broadcaster.dispatchEvent(new GeneralEvents(GeneralEvents.REVEAL_MAIN_MENU))
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			Broadcaster.addEventListener (GameShellEvents.GO_HELP_SCREEN, restart);
			addEventListener (Event.REMOVED_FROM_STAGE, hideHelp);
			
			
			/*_RotatingSphere = new RotatingSphere()
			_StarFieldRef = new StarField()
			starFieldBitmap= _StarFieldRef.init(640,480,1,2)
			//sphereShape = _RotatingSphere.init(0xFF0000)
			sphereShape = _RotatingSphere.init(0x1D6C8D, 0, 0, 600, 160, 320, 240)
			_RotatingSphere.cameraView.focalLength = 380
			_RotatingSphere.cameraView.z = 0
			_RotatingSphere.cameraView.y = 100
			
			_RotatingSphere.cameraView.z = 1200
			_RotatingSphere.cameraView.y = 200
			_RotatingSphere.cameraView.x= 300
			
			//_RotatingSphere.startSphere()
			//_StarFieldRef.startEffect()
			sceneBack.addChild(starFieldBitmap)
			
			sceneBack.addChild(sphereShape)*/
		}
		/*private var starFieldBitmap:Bitmap
		private var _StarFieldRef:StarField
		private var sphereShape:Shape
		public var _RotatingSphere:RotatingSphere*/
		private function btnDownHandler(e:ButtonEvent):void {
			switch(e.data.name) {
				case "leftHelpArrow":
				if (leftHelpArrow.buttonMode){
					helpPage--
					evalHelp ()
				}
				break
				case "rightHelpArrow":
				if (rightHelpArrow.buttonMode){
					helpPage++
					evalHelp ()
				}
				break
			}
		}
	
		private function evalHelp ():void {
			helpClipData.gotoAndStop(helpPage)
			if (helpPage <2) {
				leftHelpArrow.buttonMode = false
				TweenLite.to(leftHelpArrow,.5,{x:-42})
			}else {
				leftHelpArrow.buttonMode = true
				TweenLite.to(leftHelpArrow,.5,{x:38.5})
			}
			if (helpPage >1) {
				rightHelpArrow.buttonMode = false
				rightHelpArrow.alpha = .5
					TweenLite.to(rightHelpArrow,.5,{x:685})
			}else {
				rightHelpArrow.buttonMode = true
				rightHelpArrow.alpha = 1
				TweenLite.to(rightHelpArrow,.5,{x:598})
			}
				
		}
		public function restart (e:GameShellEvents):void {
			//trace ("restarting help screen")
			leftHelpArrow.x = -42
			rightHelpArrow.x = 685
			evalHelp ()
			//_StarFieldRef.startEffect()
			//_RotatingSphere.startSphere()
		}
		private function hideHelp(event:Event):void {
			//_StarFieldRef.stopEffect()
			//_RotatingSphere.stopSphere()
		}
		public static function getInstance():HelpScreen {
			return _instance
		}
		private static var _instance:HelpScreen
			private var helpPage:int = 1
		
		
	}
}