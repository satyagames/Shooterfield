package com.terrypaton.ui
{
	import flash.utils. *
	import flash.display. *
	import flash.events.*;
	import com.terrypaton.events.*
	import com.terrypaton.utils.Broadcaster
	import com.gameshell.DisplayManager
	public class BtnClass extends MovieClip
	{
		
		public function BtnClass ()
		{
			
			this.mouseChildren = false
			this.addEventListener (MouseEvent.MOUSE_DOWN, mouseDownBTNHandler);
			this.addEventListener (MouseEvent.MOUSE_OVER, mouseOverBTNHandler);
			this.addEventListener (MouseEvent.MOUSE_OUT, mouseOutBTNHandler);
			this.buttonMode = true
			data.name = this.name
			data.target = this
		}
		
		private function mouseDownBTNHandler (e : MouseEvent) : void
		{
			Broadcaster.dispatchEvent(new ButtonEvent(ButtonEvent.DOWN, true,data));
				DisplayManager.getInstance().playSound("mouseDown.wav")
		}
		private function mouseOutBTNHandler (e : MouseEvent) : void
		{
			
			if (useRollOver){
				this.gotoAndPlay ("out")
			}
			Broadcaster.dispatchEvent(new ButtonEvent(ButtonEvent.OUT, true,data));
		}
		
		private function mouseOverBTNHandler (e : MouseEvent) : void {
			if (useRollOver) {
				
				this.gotoAndPlay("over")
			}
			
			Broadcaster.dispatchEvent(new ButtonEvent(ButtonEvent.OVER, true, data));
		}
		private var data:Object = new Object()
		public var useRollOver:Boolean = useRollOver
		
	}
}
