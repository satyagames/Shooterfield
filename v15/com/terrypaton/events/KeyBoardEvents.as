package com.terrypaton.events{
	import flash.events.*;
	public class KeyBoardEvents extends Event {
		public static const UP_PRESSED:String = "UP_PRESSED";
		public static const UP_RELEASED:String = "UP_RELEASED";
		
		public static const DOWN_PRESSED:String = "DOWN_PRESSED";
		public static const DOWN_RELEASED:String = "DOWN_RELEASED";
		
		public static const LEFT_PRESSED:String = "LEFT_PRESSED";
		public static const LEFT_RELEASED:String = "LEFT_RELEASED";
		
		public static const RIGHT_PRESSED:String = "RIGHT_PRESSED";
		public static const RIGHT_RELEASED:String = "RIGHT_RELEASED";
		
		public static const SPACE_PRESSED:String = "SPACE_PRESSED";
		public static const SPACE_RELEASED:String = "SPACE_RELEASED";
		
		public static const KEY_PRESS:String = "KeyBoardEvents.KEY_PRESS";
		public static const KEY_RELEASE:String = "KeyBoardEvents.KEY_RELEASE";
		
		public var data:*;
		public function KeyBoardEvents( controlType:String,bubbles:Boolean = true,data:Object = null ) {
			super( controlType,bubbles);
			this.data = data;
		}
	}
}