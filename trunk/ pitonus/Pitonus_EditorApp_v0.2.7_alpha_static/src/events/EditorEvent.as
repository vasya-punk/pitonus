package events 

{
	import flash.events.Event;
	public class EditorEvent extends Event
	{
		public static const GENERIC:String = "GENERIC";
		public static const PAGE_ADD:String = "PAGE_ADD";
		public static const PAGE_REMOVE:String = "PAGE_REMOVE";
		public static const PAGE_SELECT:String = "PAGE_SELECT";
		public static const SHOW_ELEMENT_PROPERTIES:String = "SHOW_ELEMENT_PROPERTIES";
		public static const ADD_LINK:String = "ADD_LINK";
		public var data:* = null;
		public var event:*;
		
		public function EditorEvent(type:String, event:*, data:* = null){
			super(type, true, true);

			this.event = event;
			this.data = data;
			
		}
	}
}



