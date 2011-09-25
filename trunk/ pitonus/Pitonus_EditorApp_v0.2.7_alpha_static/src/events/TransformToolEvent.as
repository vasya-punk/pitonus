package events 

{
	import flash.events.Event;
	public class TransformToolEvent extends Event
	{
		public static const SELECT_ELEMENT:String = "SELECT_ELEMENT";
		public static const DOUBLE_CLICK:String = "DOUBLE_CLICK";
		public static const UPDATE_ELEMENT:String = "UPDATE_ELEMENT";
		
		public var element:*;
		
		public function TransformToolEvent(type:String,  param:*){
			super( type, true, true );
			this.element = param;
		}
	}
}



