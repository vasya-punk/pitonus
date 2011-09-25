package Utils
{

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import com.adobe.serialization.json.*;
	
	public function encodeTree( obj:Object):void{
		
		var debug:Boolean = false;
		if (Config.DEBUG && Config.DEBUG_LEVEL > 2) {
			debug = true;
		}

		if(debug)
			trace("Sending Object : " + obj);


		var request:URLRequest = new URLRequest ("http://pitonus.com/demo.php"); 
		request.method = URLRequestMethod.POST; 
						 
		var variables:String =  JSON.encode( obj );
						 
		//variables.firstName = "FirstName"; 
		//variables.lastName = "LastName";             
		request.data = variables; 
						
	
		var loader:URLLoader = new URLLoader (request); 
		loader.addEventListener(Event.COMPLETE, onComplete); 
		loader.dataFormat = URLLoaderDataFormat.VARIABLES; 
		loader.load(request); 
						 
				 
		function onComplete (event:Event):void {
			trace( "Sending complete...");
			//statusTxt1.text = event.target.data; 
		} 
	}
}
