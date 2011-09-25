package commands{

	import flash.text.TextField;

	public class Settings implements ICommand {
		
		private var param:String;		
		private var receiver:*;
		
		public function Settings(rec:*, p:String):void {
			this.receiver = rec;
			param = p;
		}	

		
		public function execute():void {
			receiver.settings(param);
		}
	}
}