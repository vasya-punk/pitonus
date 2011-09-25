package commands{

	import Configuration.*;
	
	public class AddElement implements ICommand {
			
		private var receiver:*;
		private var elementType:String;
		
		public function AddElement(rec:*, type:String):void {
			this.receiver = rec;
			this.elementType = type;
		}	
		
		public function execute():void {

			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("... AddElement Command Executed.");

			receiver.addElement(elementType);
		}
	}
}