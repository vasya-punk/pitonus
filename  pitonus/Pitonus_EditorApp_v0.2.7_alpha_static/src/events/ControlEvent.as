package events 
{
	
	import flash.events.Event;
	
	public class ControlEvent extends Event
	{
		public static const CONTROL_READY:String = "CONTROL_READY";
		public static const MENU_CLICK:String = "MENU_CLICK";
		public static const PAGE_CHANGED:String = "PAGE_CHANGED";
		public static const CANVAS_ONDRAW:String = "canvas_draw_complete";
		public static const CONTROL_ACTIONS_ATTACHED:String = "control_actions_attached";
		public static const PAGE_UPDATED:String = "PAGEUPDATED";
		public static const PAGE_READY:String = "PAGE_READY";
		public static const ELEMENT_UPDATE:String = "ELEMENT_UPDATE";
		public static const REMOVE:String = "REMOVE";
		public static const REMOVE_ELEMENT:String = "REMOVE_ELEMENT";
		
		
		
		public var data:*;
		
		public function ControlEvent(type:String, param:*){
			super(type, true, true);
			this.data = param;
		}
	}
}



