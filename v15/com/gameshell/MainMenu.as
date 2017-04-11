package com.gameshell {
	import com.terrypaton.events.GeneralEvents;
	import com.terrypaton.events.ButtonEvent;
	import flash.display.MovieClip
	import flash.display.Bitmap
	import com.terrypaton.utils.Broadcaster
	import com.gs.*
	import com.gs.easing.*
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import com.gameshell.GameShellEvents
	import com.vd.RotatingSphere
	import com.vd.StarField
	import com.vd.DataManager
	import flash.display.Shape
	public class MainMenu extends MovieClip {
		public function MainMenu():void {
			_instance = this
			addEventListener (Event.REMOVED_FROM_STAGE, hideMainMenu);
			Broadcaster.addEventListener (ButtonEvent.DOWN, btnDownHandler);
			
			/*_RotatingSphere = new RotatingSphere()
			_StarFieldRef = new StarField()
			starFieldBitmap= _StarFieldRef.init(640,480,1,2)
			//sphereShape = _RotatingSphere.init(0xFF0000)
			sphereShape = _RotatingSphere.init(0x00FF00, 0, 0, 600, 160, 320, 240)
			_RotatingSphere.cameraView.focalLength = 380
			_RotatingSphere.cameraView.z = 0
			_RotatingSphere.cameraView.y = 100
			
			_RotatingSphere.cameraView.z = 1200
			_RotatingSphere.cameraView.y = -300
			_RotatingSphere.cameraView.x= -300
			
			_RotatingSphere.startSphere()
			_StarFieldRef.startEffect()
			sceneBack.addChild(starFieldBitmap)
			
			sceneBack.addChild(sphereShape)*/
		}
		/*private var starFieldBitmap:Bitmap
		private var _StarFieldRef:StarField
		private var sphereShape:Shape*/
		private function btnDownHandler(e:ButtonEvent):void {
			//////trace(e.data.name)
	
			switch(e.data.name) {
				case "playGameBtn":
				DataManager.getInstance().score = 0
					Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.SHOW_LEVEL_CHOOSER))
					//Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_GAME_COMPLETE))
					//Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_GAME_OVER))
				break
				
				case "visitSiteBtn":
					//var request:URLRequest =new URLRequest("http://www.zopy.in");
					//navigateToURL(request, "_blank");
				break
				case "helpBtn":
					Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_HELP_SCREEN))
				break
				case "medalsBtn":
					var request1:URLRequest =new URLRequest("http://www.zopy.in");
					navigateToURL(request1, "_blank");
					//Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_MEDALS))
				break
				case "highscoresBtn":
					//Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_HIGHSCORES))
					Broadcaster.dispatchEvent(new GameShellEvents(GameShellEvents.GO_MEDALS))
				break
			}
		}
		//public var _RotatingSphere:RotatingSphere
		public function restart ():void {
			//sceneBack.startEffect()
			//_StarFieldRef.startEffect()
			//_RotatingSphere.startSphere()
		}
		private function hideMainMenu(event:Event):void {
			//_StarFieldRef.stopEffect()
			//_RotatingSphere.stopSphere()
		}
		
		public static function getInstance():MainMenu {
			return _instance
		}
		private static var _instance:MainMenu
		
		
		
	}
}