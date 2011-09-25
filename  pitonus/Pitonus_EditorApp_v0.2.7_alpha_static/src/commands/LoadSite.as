package commands{

	public class LoadSite implements ICommand {
		
		private var _receiver:*;

		public function LoadSite(rec:*):void {
			_receiver = rec;
		}
		
		 public function execute():void {
			_receiver.loadSite();	
		}
	}
}