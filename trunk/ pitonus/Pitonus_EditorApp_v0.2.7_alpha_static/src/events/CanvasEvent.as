package events 
{
	
	import flash.events.Event;
	
	public class CanvasEvent extends Event
	{
		public static const ONDRAW:String = "ONDRAW";
		public static const ONCHANGE:String = "ONCHANGE";
		
		public var data:*;
		
		public function CanvasEvent(type:String, param:*){
			super(type, true, true);
			this.data = param;
		}
	}
}



