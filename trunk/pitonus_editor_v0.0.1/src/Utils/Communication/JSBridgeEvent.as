package Utils.Communication 

{
	import flash.events.Event;
	public class JSBridgeEvent extends Event
	{
		public static const STRUCTURE_RECIEVED:String = "Structure_recieved_form_JS";
		public static const ELEMENTS_LIST_RECIEVED:String = "Elements_recieved_form_JS";
		public static const TEMPLATES_LIST_RECIEVED:String = "Templates_recieved_form_JS";
		
		public var data:String;
		
		public function JSBridgeEvent(type:String, str:String){
			super(STRUCTURE_RECIEVED);
			this.data = str;
		}
	}
}



