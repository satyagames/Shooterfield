package com.jewelmaster{
	
	import com.terrypaton.events.PlayingLoopEvent;
	import flash.display.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	// Classes used in this example
	
	import com.jewelmaster.DataManager
	import com.jewelmaster.RenderManager
	import com.jewelmaster.PlayingLoopManager
	import com.jewelmaster.ObjectClass
	//
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.events.BoxEvents
	public class GameClipClass extends MovieClip{
	
		private var _clip:MovieClip
		
			private var _DataManagerRef:DataManager;
			private var _RenderManagerRef:RenderManager;
			private var _PlayingLoopManagerRef:PlayingLoopManager;
		
			public function  GameClipClass() {
				//trace ("new game class")
				_DataManagerRef = new DataManager(this)
				_RenderManagerRef = new RenderManager()
				_PlayingLoopManagerRef = new PlayingLoopManager ()
				
			}
			public function initGameplay () {
				//Broadcaster.dispatchEvent(new PlayingLoopEvent(PlayingLoopEvent.SETUP_NEW_GAME))
			}
			public var startOnLevel:int = 1
			
			
			private const itemNamesArray:Array = new Array("","dirt","boulder","diamond","rock","exit","treasure","wall")
		
		
		
		private var score:int = 0
		
		private var destroy:Boolean
		private var playerClip:MovieClip
		private var playerX:Number = 0
		private var playerY:Number = 0
		
		
		private var rightPressed:Boolean
		private var leftPressed:Boolean
		private var downPressed:Boolean
		private var upPressed:Boolean
		
			
		
		
		
	}

}