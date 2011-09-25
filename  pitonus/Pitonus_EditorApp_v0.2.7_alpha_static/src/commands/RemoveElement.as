package commands{

	
	public class RemoveElement implements ICommand {
			
		private var receiver:*;

		public function RemoveElement(rec:*):void {
			this.receiver = rec;

		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("... RemoveElement Command Executed.");

			receiver.removeElement();
		}
	}
}