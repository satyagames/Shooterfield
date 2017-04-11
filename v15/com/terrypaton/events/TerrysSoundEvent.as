package com.terrypaton.events{
	import flash.events.*;
	public class TerrysSoundEvent extends Event {
		public static const PLAY_SOUND:String = "play sound";
		public static const STOP_ALL_SOUNDS:String = "stop all sounds";
		public static const DRAGGING:String = "dragging";
		public static const STRETCHING_STARTED:String = "stretching started";
		public static const STRETCHING_STOPPED:String = "stretching stopped";
		public static const CREATE_NEW_SAMPLE_INSTANCE:String = "create_new_sample_instance";
		public static const DUPLICATE_SAMPLE:String = "DUPLICATE_SAMPLE";
		public static const PICK_UP_SAMPLE_CLIP:String = "pick_up_sample_clip";
		public static const DROP_SAMPLE_CLIP:String = "drop_sample_clip";
		public static const REMOVE_MOVIECLIP:String = "remove_movieclip";
		public static const PLAY_LIBRARY_PREVIEW:String = "play_library_preview";
		public static const UPDATE_SCROLL_BAR:String = "UPDATE_SCROLL_BAR";
		public static const MUTE_CHANNEL:String = "MUTE_CHANNEL";
		public static const DISPOSE_SAMPLE:String = "DISPOSE_SAMPLE";
		public static const SOLO_CHANNEL:String = "SOLO_CHANNEL";
		public static const VOLUME_EDIT_CHANNEL:String = "VOLUME_EDIT_CHANNEL";
		public static const UNSOLO_ALL:String = "UNSOLO_ALL";
		public var data:*;
		public function TerrysSoundEvent( controlType:String, bubbles:Boolean = true, data:Object = null ) {
			super( controlType,bubbles);
			this.data = data;
		}
	}
}
