package com.terrypaton.events{
	import flash.events.*;
	public class ButtonEvent extends Event {
		public static const OVER:String = "ButtonEvent.over";
		public static const DOWN:String = "ButtonEvent.down";
		public static const OUT:String = "ButtonEvent.out";
		public static const GET_LANGUAGE:String = "ButtonEvent.get language";
		public var data:*;
		public function ButtonEvent( controlType:String,bubbles:Boolean = true,data:Object = null ) {
			super( controlType,bubbles);
			this.data = data;
		}
	}
}