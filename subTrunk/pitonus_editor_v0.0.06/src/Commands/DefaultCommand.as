package Commands{
	
	
	import flash.text.TextField;
	import Controls.*;
	
	public class DefaultCommand implements ICommand {
		
		private var _receiver:*;
		private var _param:String = "";
		
		public function DefaultCommand(rec:*, param:String = ""):void {
			_receiver = rec;
			_param = param;

		}
		
		 public function execute():void {
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("DefaultCommand. Command Executed");

			_receiver.execute( _param );
				
		}
	}
}