package com.gameshell{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.net.*;
	import flash.utils.*;
	import com.terrypaton.utils.SharedObjectManager
	import com.terrypaton.media.SoundManager
	public class Preloader extends MovieClip {
		private var MENU_ITEM_1:String="zopy.in";
		private var MENU_ITEM_2:String="ZOPY GAMES";
		private var MENU_ITEM_3:String="LOW Quality";
		private var MENU_ITEM_4:String="HIGH Quality";
		public var languageFrame:String;
		public var myUID:String;
		public var canUseHighscore:Boolean;
		public var myContextMenu:ContextMenu;
			private var _SharedObjectManagerRef:SharedObjectManager
			private var _SoundManagerRef:SoundManager
		public function Preloader () {
			//var _mochiads_game_id:String = "";
			addEventListener(Event.ADDED_TO_STAGE,init)
		}
		private function init (e:Event):void {
			var debugHolder:Sprite = new Sprite()
			removeEventListener (Event.ADDED_TO_STAGE, init)
			myContextMenu = new ContextMenu();
			addCustomMenuItems ();
			stage.stageFocusRect = false
			//loaded ()
			var mytime:uint = setTimeout(loaded,20)
			var mytime2:uint = setTimeout (goMain, 3200)
			//var mytime2:uint = setTimeout (goMain, 30)
			_SharedObjectManagerRef = new SharedObjectManager ()
			_SoundManagerRef = new SoundManager ()
			_SharedObjectManagerRef.setupSharedObject ("treasurecaves2")
			
			// start playing music
			 
		}
		private function loaded () {
				this.gotoAndStop (3);
		}
		private function goMain () {
			this.gotoAndStop (4);
			// start playing the music
			
			if (SharedObjectManager.getInstance ().getData ("musicState") == false) {
				//SoundManager.adjustVolume(0)
			}
			
		}
		private function addCustomMenuItems ():void {
			myContextMenu.hideBuiltInItems();
			var defaultItems:ContextMenuBuiltInItems=myContextMenu.builtInItems;
			defaultItems.print=false;
			var item1:ContextMenuItem=new ContextMenuItem(MENU_ITEM_1);
			myContextMenu.customItems.push(item1);
			var item3:ContextMenuItem=new ContextMenuItem(MENU_ITEM_3);
			myContextMenu.customItems.push(item3);
			var item4:ContextMenuItem=new ContextMenuItem(MENU_ITEM_4);
			myContextMenu.customItems.push(item4);
			item1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			item3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			item4.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			contextMenu=myContextMenu;
		}
		
		private function menuItemSelectHandler(event:ContextMenuEvent):void {
			var request:URLRequest;
			switch (event.target.caption) {
				case MENU_ITEM_1 :
					request=new URLRequest("http://www.zopy.in/?=shootersfield");
					navigateToURL(request, "_blank");
					break;
				case MENU_ITEM_3 :
					//change quality to low
					stage.quality="LOW";
					break;
				case MENU_ITEM_4 :
					//change quality to high
					stage.quality="HIGH";
					break;
			}
		}
	}
}