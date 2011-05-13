package Commands{
	
	
	import Controls.*;
	
	public class GetElementProperties implements ICommand {
			
		private var receiver:*;
		private var element:*;
		
		public function GetElementProperties(rec:*, trg:*):void {
			this.receiver = rec;
			element = trg;
			
		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("\nGetElementProperties Command Executed.");

			receiver.getElementProperties(element);
		}
	}
}