package commands{
	
		public class Select implements ICommand {
			
		private var receiver:*;
		private var param:String;
		
		public function Select(rec:*, p:String):void {
			this.receiver = rec;
			param = p;
			
		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("... Select Command Executed - param: " + param);

			receiver.select(param);
		}
	}
}