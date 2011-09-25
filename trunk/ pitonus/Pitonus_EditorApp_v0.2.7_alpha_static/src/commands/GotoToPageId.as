package commands{
	
	
	import flash.text.TextField;

	public class GotoToPageId implements ICommand {
			
		private var receiver:*;
		private var pageId:uint;
		
		public function GotoToPageId(rec:*, id:uint):void {
			this.receiver = rec;
			pageId = id;
			
		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("... GotoToPageNum Command Executed - pageID: " + pageId);

			receiver.gotoPage(pageId);
		}
	}
}