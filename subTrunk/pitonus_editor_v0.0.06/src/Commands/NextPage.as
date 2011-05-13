package Commands{
	
	
	import flash.text.TextField;
	import Controls.*;
	
	public class NextPage implements ICommand {
		
		private var receiver:*;
		
		public function NextPage(rec:*):void {
			this.receiver = rec;
		}
		
		 public function execute():void {
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("NextPage Command Executed");
			receiver.drawPage(1);
		}
	}
}