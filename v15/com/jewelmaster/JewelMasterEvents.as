package com.jewelmaster{
	import flash.events.*;
	public class JewelMasterEvents extends Event {
		public static const OPEN_EXIT:String = "JewelMasterEvents.OPEN_EXIT";
		public static const SHOW_LEVEL_COMPLETE_MESSAGE:String = "JewelMasterEvents.SHOW_LEVEL_COMPLETE_MESSAGE";
		public static const SET_LEVEL:String = "JewelMasterEvents.SET_LEVEL";
		public static const EXPLOSION:String = "JewelMasterEvents.EXPLOSION";
		public static const MEDAL_UNLOCKED:String = "JewelMasterEvents.MEDAL_UNLOCKED";
		
		
		
		public var data:*;
		public function JewelMasterEvents( custom_type:String,custom_bubbles:Boolean = true,custom_data:Object = null ) {
			super( custom_type,custom_bubbles);
			this.data = custom_data;
		}
		public override function clone():Event {
			return new JewelMasterEvents(type,bubbles,data );
		}
	}
}