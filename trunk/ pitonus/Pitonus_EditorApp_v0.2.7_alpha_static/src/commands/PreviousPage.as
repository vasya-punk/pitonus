package commands{

	import flash.text.TextField;

	public class PreviousPage implements ICommand {
		
				
		private var receiver:*;
		
		public function PreviousPage(rec:*):void {
			this.receiver = rec;
		}	

		
		 public function execute():void {
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("... PreviousPage Command Executed");
			receiver.previousPage();
		}
	}
}