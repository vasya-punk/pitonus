package managers.communication 
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import utils.*;
	import data.utils.*;
	import managers.*;
	import configuration.*;
	import flash.utils.setTimeout;
	import com.adobe.serialization.json.*;
	/*
	 * jsPitLoadRequest()
	*/
	
	public class JSBridge extends EventDispatcher
	{
		
		public function JSBridge() {
			
			/*if (ExternalInterface.available) {

				//wait for call from javascript
				ExternalInterface.addCallback("pitTrace", 			pitTrace		);
				ExternalInterface.addCallback("pitGetData", 		pitGetData		);
				ExternalInterface.addCallback("pitLoad", 			pitLoad			);
				ExternalInterface.addCallback("pitLoadFromUrl", 	pitLoadFromUrl	);
				//ExternalInterface.addCallback("pitImagesList", 		pitImagesList	);
				
						
				callJs("jsPitReady", DataManager.flashVars['htmlMovieId']);
	
			}else {*/
				trace("[Fault] ExternalInterface is not available. Simulating ...");	
				setTimeout(fakeSimulation, 500);
				
			//}
		}
		
		
		
		public  function fakeSimulation():void { 
			pitLoad( Templates.TEST_PAGE_DATA_STRING );
		}
		


		
	
		// ==========================================================================================
		
		public function traceToJs(str:String, param:String = ""):void { 
			callJs("jsPitConsoleLog",  "AS3. #" 
						+ DataManager.flashVars['htmlMovieId'] + " > " + str + ": " + param);	
		}
		
		// dispatchEvent ========================================================================
			
		public function pitLoad(  str:String ):void {
			if (DataManager.flashVars) {
				traceToJs("pitLoad(), flashVars OK ", str);
			}else {
				traceToJs("pitLoad(), flashVars Missing ", str);
			}
			dispatchEvent( new JSBridgeEvent( JSBridgeEvent.SITE_STRUCTURE_RECIEVED, str ) );
		}
		
		
		
		public function pitLoadFromUrl(  str:String ):void {	
			traceToJs("pitLoadFromUrl.url:", str);
			
			//Create the URLLOader instance
			var myLoader:URLLoader = new URLLoader()
			//the data will come as URL-encoded variables
			myLoader.dataFormat = URLLoaderDataFormat.TEXT;
			//Load using an URLRequest, even beeing local
			myLoader.load(new URLRequest(str))
			//add a listener for the complete event
			myLoader.addEventListener(Event.COMPLETE, onLoad)
			
			function onLoad(e:Event):void {
				//trace ("ev.target.data: " + e.target.data);
				
				if (DataManager.flashVars) {
					traceToJs("pitLoadFromUrl.data RECIEVED OK, flashVars OK " + DataManager.flashVars);
				}else {
					traceToJs("pitLoadFromUrl.data RECIEVED OK, flashVars Missing ");
				}
				
				dispatchEvent( new JSBridgeEvent( JSBridgeEvent.SITE_STRUCTURE_RECIEVED, 
				/*Templates.TEST_PAGE_DATA_STRING*/  e.target.data ) );
			}			
			
		}
		
		/*public function pitImagesList(  str:String ):void {
			traceToJs("pitImagesList", str);
			dispatchEvent( new JSBridgeEvent( JSBridgeEvent.ELEMENTS_LIST_RECIEVED, str ) );
		}*/
			
		public function pitTrace(  str:String):void {
			traceToJs("pitTrace", str);
		}	

		
		public function pitGetData( str:String = null):String {
			callJs("jsPitConsoleLog",   "AS3. #" + DataManager.flashVars['htmlMovieId'] + " > pitGetData: " );
			var siteObject:Object = saveTreeRecursive(DataManager.applicationData);
			return  JSON.encode(siteObject);
		}
		
		public function sendJSON( obj:*):void {	
			DataManager.jsBridge.callJs("jsPitSave", JSON.encode(obj) );
		}
		
		public function callJs(func:String, param:* = null):void {	
			
			//trace("JSBridge.callJs - " + func + "( " +  param + " )");
			
			if(ExternalInterface.available){
				ExternalInterface.call( func, param );
			}else {
				//trace("\n[Fault] ExternalInterface is not available.\n");	
			}

		}
		public function getMediaList(type:String):* {	
			//traceToJs("getMediaList", type);
			var result:String = 
			<![CDATA[	

{
  "images": [
    {
      "id": "1",
      "file_name": "house_img01.jpg",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "4kb",
      "thumb_src": "userfiles/usermedia/house_img01.jpg"
    },
    {
      "id": "2",
      "file_name": "house_img02.jpg",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/house_img02.jpg"
    },
    {
      "id": "3",
      "file_name": "house_img03.jpg",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/house_img03.jpg"
    },
	 {
      "id": "3",
      "file_name": "house_img08.jpg",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/house_img08.jpg"
    },
    {
      "id": "4",
      "file_name": "house_img04.jpg",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/house_img04.jpg"
    },
    {
      "id": "5",
      "file_name": "house_img05.jpg",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/house_img05.jpg"
    },
    {
      "id": "6",
      "file_name": "house_img06.png",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/house_img06.png"
    },
    {
      "id": "8",
      "file_name": "house_img07.png",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/house_img07.png"
    },
    {
      "id": "9",
      "file_name": "background_black.gif",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/background_black.gif"
    },
    {
      "id": "10",
      "file_name": "logo.png",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/logo.png"
    },
	{
      "id": "11",
      "file_name": "background_grayNoise.jpg",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/background_grayNoise.jpg"
    },
	{
      "id": "11",
      "file_name": "background_gray.gif",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/background_gray.gif"
    },
	{
      "id": "11",
      "file_name": "background_darkBlue.gif",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/background_darkBlue.gif"
    },
    {
      "id": "12",
      "file_name": "pic02.jpg",
      "file_type": "Image",
      "file_cat": "userImages",
      "user_id": "1",
      "project_id": "8",
      "size": "93kb",
      "thumb_src": "userfiles/usermedia/pic02.jpg"
    }
  ]
}	
				]]>;
			
	/*		if(ExternalInterface.available){
				result = ExternalInterface.call( "jsPitMediaListRequest", DataManager.flashVars['htmlMovieId'],"Image",0,1000 );
			}else {
				trace("\n[Fault] ExternalInterface is not available.\n");	
			}
			*/

			return result;
		}

	}

}