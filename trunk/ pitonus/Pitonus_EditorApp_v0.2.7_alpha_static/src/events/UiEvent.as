package events 
{
	
	import flash.events.Event;
	
	public class UiEvent extends Event
	{
		public static const DOCUMENT_READY:String = "DOCUMENT_READY";
		public static const NODE:String = "NODE";
		public static const SELECTION:String = "SELECTION";
		public static const SELECT_IMAGE:String = "SELECT_IMAGE";
		public static const REMOVE_IMAGE:String = "REMOVE_IMAGE";
	
		
		
		public var data:*;
		
		public function UiEvent(type:String, param:*){
			super(type, true, true);
			this.data = param;
		}
	}
}



