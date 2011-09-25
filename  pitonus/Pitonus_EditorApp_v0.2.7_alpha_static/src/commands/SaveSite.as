package commands{

	public class SaveSite implements ICommand {
		
		private var _receiver:*;

		public function SaveSite(rec:*):void {
			_receiver = rec;
		}
		
		 public function execute():void {
			_receiver.saveSite();	
		}
	}
}