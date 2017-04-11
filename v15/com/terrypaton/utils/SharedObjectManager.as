package com.terrypaton.utils {
	import com.terrypaton.utils.Debug
	import flash.net.SharedObject
	public class SharedObjectManager {
		public function SharedObjectManager():void {
			Debug.log("SharedObjectManager")
			_instance = this
		}
		public function setupSharedObject(_string:String):void {
			Debug.log("setupSharedObject: "+_string)
			// setup the shared object if it doesn't exist already
			so = SharedObject.getLocal (_string)
			//so.clear();
			Debug.log("so.size = "+so.size)
		}
		public function getData(_string:String) {
			try {
				var _data = so.data[_string]
				Debug.log(_data)
				return _data
			}catch (e:Error) {
				Debug.error("DATA NOT FOUND!")
			}
			return null
		}
		public static function getInstance():SharedObjectManager {
			return _instance
		}
	
		public function setData(_key:String,_val:*):void {
			trace("setting data sharerd object data,"+_key+","+_val)
			so.data[_key] = _val
			save()
		}
		public function save():void {
			// save the shared object
			//so.flush()
		}
		public static var _instance:SharedObjectManager
		public var so:SharedObject
		public var storage:Object
		
	}
}