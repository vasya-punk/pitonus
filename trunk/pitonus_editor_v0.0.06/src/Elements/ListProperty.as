package Elements 
{
	import fl.controls.ComboBox;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	
	import	com.sibirjak.asdpc.textfield.*;
	
	import Utils.*;
	import Elements.*;
	import Config.*;
	
	public class ListProperty extends Element implements IElement
	{

		private var label:Label;		
										
		public function ListProperty(obj:Object = null) {
			
			if(obj != null){
				super(obj);
				this.init(obj);
			}	
		}
		
		public function getValue():String { 
			return String( "input.text" ); 
		}
		
		private function init(obj:Object):void {
			
			// essential properties
			var properties:Array =  new Array("values" );
										
			if(this.validateProperties(properties)){	
				var cb:ComboBox = new ComboBox();
				cb.x = 20;
				cb.y = 25 * i + 28;
				cb.setSize(150,22);
				
				var i:uint = 0;
				for (var val:String in Attributes.URL_VALUES) {
					i++;
					cb.addItem( { label: Attributes.URL_VALUES[val], data:i } );
				}
				cb.addEventListener(Event.CHANGE, cardSelected);      
				addChild(cb);

				function cardSelected(e:Event):void {
					trace( "You have selected: ");
					trace( cb.selectedItem.label);
				}

			}
		}
	}

}