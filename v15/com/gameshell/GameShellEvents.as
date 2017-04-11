package com.gameshell{
	import flash.events.*;
	public class GameShellEvents extends Event {
		public static const OPEN_EXIT:String = "GameShellEvents.OPEN_EXIT";
		public static const SHOW_LEVEL_COMPLETE_MESSAGE:String = "GameShellEvents.SHOW_LEVEL_COMPLETE_MESSAGE";
		public static const SET_LEVEL:String = "GameShellEvents.SET_LEVEL";
		public static const EXPLOSION:String = "GameShellEvents.EXPLOSION";
		public static const MEDAL_UNLOCKED:String = "GameShellEvents.MEDAL_UNLOCKED";
		public static const DISPLAY_LEVEL_COMPLETE:String = "GameShellEvents.DISPLAY_LEVEL_COMPLETE";
		
		// screens
		public static const GO_GAME_OVER:String = "GameShellEvents.GO_GAME_OVER";
		public static const GO_HELP_SCREEN:String = "GameShellEvents.GO_HELP_SCREEN";
		public static const GO_MEDALS:String = "GameShellEvents.GO_MEDALS";
		public static const SHOW_LEVEL_CHOOSER:String = "GameShellEvents.SHOW_LEVEL_CHOOSER";
		public static const GO_GAME_SCREEN:String = "GameShellEvents.GO_GAME_SCREEN";
		public static const GO_GAME_COMPLETE:String = "GameShellEvents.GO_GAME_COMPLETE";
		public static const GO_LEVEL_COMPLETE:String = "GameShellEvents.GO_LEVEL_COMPLETE";
		public static const GO_MAIN_MENU:String = "GameShellEvents.GO_MAIN_MENU";
		public static const GO_HIGHSCORES:String = "GameShellEvents.GO_HIGHSCORES";
		
		public var data:*;
		public function GameShellEvents( custom_type:String,custom_bubbles:Boolean = true,custom_data:Object = null ) {
			super( custom_type,custom_bubbles);
			this.data = custom_data;
		}
		public override function clone():Event {
			return new GameShellEvents(type,bubbles,data );
		}
	}
}