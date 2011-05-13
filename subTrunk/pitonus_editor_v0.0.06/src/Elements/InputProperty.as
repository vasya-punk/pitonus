package Elements 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	
	import	com.sibirjak.asdpc.textfield.*;
	
	import Utils.*;
	import Elements.*;
	import Configuration.*;
	
	public class InputProperty extends Element implements IElement
	{
		private var input:TextInput;
		private var label:Label;		
										
		public function InputProperty() {

		}
		
		public function getValue():String { 
			return String( input.text ); 
		}
		
		override public function init(obj:Object):void {
			
			_properties = obj;
			// essential properties
		
			var properties:Object =  new Object();
			properties["label"] 	= Attributes.INPUT
			properties["value"]		= Attributes.INPUT;

			if (this.validateProperties(properties)) {	
				
				addBounds(0xC0C0C0);
				setPosition();
				
				label = new Label();
				label.text = obj['label'];
				addChild(label);
				
				input = new TextInput();
				input.text = obj['value'];
				input.x = 50;
				addChild(input);


			}
		}
	}

}