package elements.dropdownlist 
{
	
	import flash.events.Event;
	
	public class DropDownListEvent extends Event
	{
		public static const ON_SELECT:String = "ON_SELECT";
		public static const ON_OK:String = "ON_OK";
		public var value:*;
		public var caller:*;
		
		public function DropDownListEvent(type:String, call:*, val:*){
			super(type, true, true);
			this.caller = call;
			this.value = val
		}
	}
}



