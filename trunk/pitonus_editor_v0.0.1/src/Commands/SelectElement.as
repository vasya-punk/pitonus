package Commands{
	
	
	import Controls.*;
	
	public class SelectElement implements ICommand {
			
		private var receiver:*;
		private var element:*;
		
		public function SelectElement(rec:*, trg:*):void {
			this.receiver = rec;
			element = trg;
			
		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("... SelectElement Command Executed.");

			receiver.selectElement(element);
		}
	}
}