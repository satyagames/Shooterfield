package com.terrypaton.media{
	import flash.media.*
	import flash.utils.*
	public class SoundManager {
	   public function SoundManager() {
		   //trace("sound manager init")
		   trans = new SoundTransform(1,0);
	   }
	   public static function adjustVolume(_newVolume:Number):void {
	
		   trace(_newVolume)
		      //trace( " trans = "+ trans)
		   trans.volume = _newVolume
		
	   }
	   public static function playSound(_soundLinkageRef:String):void {
		   //trace("PLAY SOUND: " + _soundLinkageRef);
		 var ClassReference:Class = getDefinitionByName(_soundLinkageRef) as Class;
		  mysoundobj = new ClassReference();
		   //mysoundobj.play(0,0,trans)
		   //trace(trans)
		   mysoundobj.play(0,0,trans)
	   }
	
	   private static var mysoundobj:Sound;
	   public static var trans:SoundTransform
   }
}