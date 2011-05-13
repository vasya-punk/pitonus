package Utils
{
	import flash.events.Event;
	
	public class EventLoadedJSON extends Event
	{
		public static const FILE_LOADED_JSON:String = "fileLoadedJSON";
		public var obj:Object;
		
		public function EventLoadedJSON(type:String, loadedObject:Object)
		{
			super(FILE_LOADED_JSON);
			this.obj = loadedObject;
		}
	}
}