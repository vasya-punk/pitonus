package Utils 
{
	import flash.display.Sprite;
    import flash.events.*;  
  	import com.adobe.serialization.json.*;
	import Utils.*;  
	
	public class GetJSONFile extends EventDispatcher {  
		
        private var mi:PhpInteract = new PhpInteract();  
		
        public function GetJSONFile (url:String) {  
			mi.loadFile(url);  
            mi.addEventListener(Event.COMPLETE, completeHandler);  
            mi.addEventListener(Event.OPEN, openHandler);  
            mi.addEventListener(ProgressEvent.PROGRESS, progressHandler);  
            mi.addEventListener(HTTPStatusEvent.HTTP_STATUS, HTTPHandler);  
            mi.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);  
        }  
  
        public function completeHandler(e:Event):void         {  	
            //file is completely loaded  
			var obj:Object = mi.content;	
			dispatchEvent(new EventLoadedJSON(EventLoadedJSON.FILE_LOADED_JSON, obj));
        }  
        public function openHandler(e:Event):void   {  
           if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("Download started");  
        }  
		
        public function progressHandler(e:ProgressEvent):void  {  
            //Handle Progress  
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("Loaded: " + mi.bytesLoaded + " Total:" + mi.totalBytes);  		
        }
		
        public function HTTPHandler(e:HTTPStatusEvent):void  {  
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("HTTP Status: " + mi.httpStatus);  
        }  
		
        public function errorHandler(e:SecurityErrorEvent):void   {  
            //Handle Security Error Here  
			if (Config.DEBUG && Config.DEBUG_LEVEL > 1)	
				trace("errorHandler: SecurityErrorEvent " + e);  
        }  
  
    }  

}