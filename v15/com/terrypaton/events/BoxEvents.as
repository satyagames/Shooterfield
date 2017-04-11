package com.terrypaton.events{
	import flash.events.*;
	public class BoxEvents extends Event {
		public static const OBJECT_COLLIDED:String = "OBJECT_COLLIDED";
		
		public var data:*;
		public function BoxEvents( controlType:String,bubbles:Boolean = true,data:Object = null ) {
			super( controlType,bubbles);
			this.data = data;
		}
	}
}