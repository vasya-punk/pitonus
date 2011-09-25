package utils
{
	import flash.events.Event;
	public class EventReady extends Event
	{
		public static const READY:String = "JOB_DONE";
		public var obj:Object;
		
		public function EventReady(type:String, readyObject:Object){
			super(READY);
			this.obj = readyObject;
		}
	}
}