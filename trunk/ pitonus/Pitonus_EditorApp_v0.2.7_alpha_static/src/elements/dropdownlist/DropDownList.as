

package elements.dropdownlist 

{
	import com.sibirjak.asdpc.button.Button;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import utils.*;
	import managers.*;
	import configuration.*;
	import data.*;
	import elements.*;
	import elements.utils.*;
	
	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpcbeta.selectbox.SelectBox;
	
	public class DropDownList extends ActiveElement implements IElement
	{		
		private	var _label : Label;
		private	var _selectBox : SelectBox;
		private var _dataSource: Array;
									
		public function DropDownList( node:DataNode = null) {	
			if(node)
				super( node );
		}	
		
		override public function init():void { 
			
			var editableProperties:Object 	=  new Object();
			editableProperties["label"]			= Attributes.TEXT_AREA;
			editableProperties["caller"]		= Attributes.TEXT_AREA;
			editableProperties["dataSource"]	= Attributes.LIST;
			
			setEditableProperties( editableProperties );	
			
			super.init();

		}
		
		override public function draw():void {

		
			_selectBox = new SelectBox();
			_selectBox.dataSource = this.dataSource;// ["a", "b", "c", "d", "e", "f"];
			_selectBox.selectItemAt(0);
			_selectBox.setSize(w,h);
			_selectBox.setStyle(SelectBox.style.maxVisibleItems, 6);
			_selectBox.setStyle(SelectBox.style.listItemSize, 20);
			_selectBox.bindProperty(
				SelectBox.BINDABLE_PROPERTY_SELECTED_ITEM, itemSelected
			);
			
			addChild(_selectBox);

			_label = new Label();
			_label.text = "No item selected";
			_label.moveTo(0, -15);
			addChild(_label);
	
			function itemSelected(item : String) : void {
				if (_label) {
					_label.text = (
						item + " is selected"
						+ " at " + _selectBox.selectedIndex
					);
				}
				dispatchEvent(new DropDownListEvent(DropDownListEvent.ON_SELECT, caller, item));
			}
			
		
		}
		
		override public function update():void {	
			_label.text = this.label;	
		}
		
		//============================= Element GETTERS/SETTERS  ===================================

		public function set label( val:* ):void {
			setProperty( "label", String(val) );
			invalidate();
		}

		public function get label():String {
			return String( this.getProperty('label') );
		}
		
		public function set dataSource( val:* ):void {
			setProperty( "_dataSource", val );
			invalidate();
		}

		public function get dataSource():Array {
			var arr:Array = (this.getProperty('dataSource') as String).split(",")
			return arr;
		}
		
		public function get caller():String {
			return String( this.getProperty('caller') );
		}
	
	}

}
