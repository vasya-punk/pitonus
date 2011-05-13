package Commands{
	
	
	import Controls.*;
	
	public class AddElement implements ICommand {
			
		private var receiver:*;
		private var element:*;
		
		public function AddElement(rec:*):void {
			this.receiver = rec;
		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("\nAddElement Command Executed.");

			receiver.addElement();
		}
	}
}