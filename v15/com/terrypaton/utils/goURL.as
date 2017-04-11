package com.terrypaton.utils {
	public class goURL {
		
		public function launchURLinBrowser(_url:String):void {
			request=new URLRequest("http://www.soap.com.au");
					navigateToURL(request, "_blank");
		}
	}
}