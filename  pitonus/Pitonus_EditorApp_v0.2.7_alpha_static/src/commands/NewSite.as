package commands{
	
	
	import flash.text.TextField;

	
	public class NewSite implements ICommand {
			
		private var receiver:*;
		
		public function NewSite(rec:*):void {
			this.receiver = rec;

		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("... NewSite Command Executed " );

			receiver.newSite();
		}
	}
}