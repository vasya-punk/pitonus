package Utils{
	
	import flash.display.*;
	import flash.events.*;
	import com.bit101.components.*;		
	
	public class MinCompComboBox extends Sprite {
		private var receiver:*;
		public  var selected:Boolean = false;
		private var list:List;
		public function MinCompComboBox(rec:*, items:Array = null) {
			
			this.receiver = rec;

			
			if (items)
			list = new List(this, 0, 0, items );
			else{
				list = new List(this, 0, 0 );
				//list.listItemClass = CheckListItem;
				for(var i:int = 0; i < 3; i++){
						list.addItem({label:"item " + i});
				}
			}
			list.addEventListener(Event.SELECT, onSelect);		
		}
		private function onSelect(event:Event):void	{
				//label.text = list.selectedItem.label;
				//trace("Item choosen: No " + list.selectedIndex);// as List;
				this.receiver.itemSelected(list.selectedIndex);
			}
		
	}
}

