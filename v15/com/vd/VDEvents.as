package com.vd{
	import flash.events.*;
	public class VDEvents extends Event {

		public static const UPDATE_HUD:String = "VDEvents.UPDATE_HUD";
		public static const REVEAL_HUD:String = "VDEvents.REVEAL_HUD";
		public static const HIDE_HUD:String = "VDEvents.HIDE_HUD";
		public static const REVEAL_PLAYER:String = "VDEvents.REVEAL_PLAYER";
		
		public var data:*;
		public function VDEvents( custom_type:String,custom_bubbles:Boolean = true,custom_data:Object = null ) {
			super( custom_type,custom_bubbles);
			this.data = custom_data;
		}
		public override function clone():Event {
			return new VDEvents(type,bubbles,data );
		}
	}
}