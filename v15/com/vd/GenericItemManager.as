package com.vd {
	import com.vd.*
	import flash.geom.Point
	import com.terrypaton.events.PlayingLoopEvent
	import com.terrypaton.utils.Broadcaster
	import com.terrypaton.effect.particleManagerClass
	public class GenericItemManager {
		public function GenericItemManager():void {
			_instance = this
			itemArray = new Array()
			itemCount = 0
		}
		
		public function dispose():void {
			itemCount = 0
			itemArray = []
		}
		public static function getInstance ():GenericItemManager {
			return _instance;
		}
		public function addItem(_startLoc:Point, _itemType:int, _itemSubtype:int = -1):ItemClass {
			//var itemType:int = _itemType
			itemCount++
			var startLoc:Point = new Point(_startLoc.x, _startLoc.y)
			// depending on the type of item, adjust it's life
			switch(_itemType) {
				case settings.ITEM_POWER_UP:
					trace("ITEM_POWER_UP")
				
				break
				case settings.ITEM_MULTI_HIT:
					//trace("ITEM_MULTI_HIT")
				
				break
				case settings.ITEM_SATELITE:
					// add a random satelite
					
				break
				case settings.ITEM_BLOCKER:
					// add a random satelite
					
				break
			}
			
			var _ItemClassRef:ItemClass = new ItemClass(startLoc,life,_itemType,_itemSubtype)
			itemArray.push(_ItemClassRef)
			return _ItemClassRef
		}
		private var n:int 
		public function manageItems():void {
			n = itemArray.length
			
			while (n--) {
				_ItemClassRef = itemArray[n]
				_ItemClassRef.manageItem()
				//trace(_ItemClassRef.getitemType())
				if (_ItemClassRef.kill) {
					itemArray.splice(n, 1)
					_ItemClassRef = null
				}
			}
		}
		public function getItemArray():Array {
			return itemArray
		}
		private var itemArray:Array 
		private var _ItemClassRef:ItemClass 
		private static var _instance:GenericItemManager;
		
		private var itemCount:int
		private var life:int
	}
	
}