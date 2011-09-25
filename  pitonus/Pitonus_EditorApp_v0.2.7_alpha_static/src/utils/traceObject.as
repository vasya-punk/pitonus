package  utils
{
	import com.adobe.serialization.json.JSON;

		public function traceObject( obj:*, marker:String = "" ):void {
			if(obj is Array)
				trace("\n[ ______ traceObject: Array ______");
			else
				trace("\n[ ______ traceObject: Object _____");
			
			if (obj is Object) {
				// Object
				for ( var item:String in obj) {
					trace("   > " + marker + " : " + item + ", " + obj[item] /*+ ", String: " + (obj[item] is String)*/);
					
				}
			}else {
				// Array
				for ( var i:uint = 0; i < obj.length; i++ ) {
					trace("   > " + marker + " : " + i + ", " + obj[i])
					
				}
			}
			
			trace("] _________________________________");
		}


}