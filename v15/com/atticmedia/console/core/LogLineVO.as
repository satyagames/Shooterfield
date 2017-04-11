/*
* 
* Copyright (c) 2008 Atticmedia
* 
* @author 		Lu Aye Oo
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
* 
* 
*/
package com.atticmedia.console.core {

	/**
	 * @author lu
	 */
	public class LogLineVO {
		public var text:String;
		public var c:String;
		public var p:int;
		public var time:int;
		public var r:Boolean;
		public var s:Boolean;
		public function LogLineVO(t:String, c:String, p:int, repeating:Boolean = false, skipSafe:Boolean = false, time:int = 0){
			this.text = t;
			this.c = c;
			this.p = p;
			this.time = time;
			this.r = repeating;
			this.s = skipSafe;
		}
	}
}
