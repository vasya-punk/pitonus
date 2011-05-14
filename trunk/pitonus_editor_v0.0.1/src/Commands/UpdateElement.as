package Commands{
	
	
	import Controls.*;
	
	public class UpdateElement implements ICommand {
			
		private var receiver:*;
		
		public function UpdateElement(rec:*):void {
			this.receiver = rec;
		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("\nUpdateElement Command Executed.");

			receiver.updateElementProperties();
		}
	}
}