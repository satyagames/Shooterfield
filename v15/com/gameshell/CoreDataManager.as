package com.gameshell{
	import flash.display.*;
	
	import com.terrypaton.events.*
	import com.terrypaton.utils.Broadcaster

	public class CoreDataManager {
		private var holder:MovieClip
		public function CoreDataManager ():void {
			//trace("CoreDataManager")
			_instance = this;
			//setupListeners ();
		}
		
			
		public function clearUserData ():void {
			
		}
		public function dispose ():void {
			
		}
		//private function setupListeners () {
		//
		//}
		
		
		public static function getInstance ():CoreDataManager {
			//if (_instance ==undefined){
				//_instance = new CoreDataManager();
			//}
			return _instance;
		}
		private static var _instance:CoreDataManager;
	
		
		public var score:int = 0
		public var lastLevelCompleted:int = 0
		public var startLevel:int = 0
		public var camerax:int = 0
		public var cameray:int = 0
		public var cameraz:int = 0
		public var sfxState:int =1
		public var musicState:int = 1
		
		
		public var ENEMY_VECTORS_DESTROYED:int = 0
		public var BULLETS_FIRED:int = 0
		public var SATELITES_DESTROYED:int = 0
		public var PLANETS_DEFENDED:int = 0
		public var GAMES_PLAYED:int = 0
		
		
	}
}