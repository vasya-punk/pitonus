package commands{
	
		public class EditElement implements ICommand {
			
		private var receiver:*;
		private var param:String;
		
		public function EditElement(rec:*):void {
			this.receiver = rec;
		}	
		
		public function execute():void {
			receiver.editElement();
		}
	}
}