package com.vd {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import com.vd.*
	public class Game extends MovieClip {
		public function Game():void {
			addEventListener(Event.ADDED_TO_STAGE,initGame)
			addEventListener(Event.REMOVED_FROM_STAGE, clearGame)
			
			_instance = this
			_DataManager = new DataManager()
			_RenderManager = new RenderManager()
			_PlayingLoopManager = new PlayingLoopManager()
			_BulletManager = new BulletManager()
			_EnemyManager = new EnemyManager()
			_GenericItemManager = new GenericItemManager()
			
		}
		
		private function loop(e:Event):void 
		{
			_PlayingLoopManager.manageLoop()
		}
		
		private function clearGame(e:Event):void 
		{
			trace("CLEAR GAME")
			removeEventListener(Event.ENTER_FRAME, loop)
			_DataManager.dispose()
			_RenderManager.dispose()
			_PlayingLoopManager.dispose()
			_BulletManager.dispose()
			_EnemyManager.dispose()
			_GenericItemManager.dispose()
		}
		
		private function initGame(e:Event):void 
		{
			
			//_DataManager.setup()
			//_RenderManager.setup()
			_PlayingLoopManager.gameState = settings.GS_SETUP_NEW_GAME
			addChild(_RenderManager)
			addEventListener(Event.ENTER_FRAME, loop)
		}
		
		
		private static var _instance:Game
		public static function getInstance():Game {
			return _instance
		}
		
		private var _RenderManager:RenderManager
		private var _DataManager:DataManager
		private var _PlayingLoopManager:PlayingLoopManager
		private var _BulletManager:BulletManager
		private var _EnemyManager:EnemyManager
		private var _GenericItemManager:GenericItemManager
		
		
	}
}