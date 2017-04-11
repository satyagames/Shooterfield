package com.terrypaton.events{
	import flash.events.*;
	
	public class HighscoreEvent extends Event {
		
		public static const CLOSE_HIGHSCORES:String = "HighscoreEvent.CLOSE_HIGHSCORES";
		public static const HIDE_SUBMIT_SCORE:String = "HighscoreEvent.HIDE_SUBMIT_SCORE";
		public static const SHOW_HIGH_SCORES:String = "HighscoreEvent.SHOW_HIGH_SCORES";
		public static const SUBMIT_HIGH_SCORE:String = "HighscoreEvent.SUBMIT_HIGH_SCORE";
		
		public var data:*;
	
		public function HighscoreEvent( controlType:String,bubbles:Boolean = true,data:Object = null ) {
			super( controlType,bubbles);
			this.data = data;
		}
	}
}