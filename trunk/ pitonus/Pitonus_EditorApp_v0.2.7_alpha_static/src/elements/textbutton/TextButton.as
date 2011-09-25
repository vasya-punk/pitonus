package elements.textbutton 
{
	import com.sibirjak.asdpc.button.Button;
	import flash.display.Sprite;
	import flash.text.TextField;
	import com.sibirjak.asdpc.textfield.Label;
	
	import utils.*;
	import managers.*;
	import configuration.*;
	import data.*;
	import elements.*;
	import elements.utils.*;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class TextButton extends ActiveElement implements IElement
	{		

		private var _button:Button;
											
		public function TextButton( node:DataNode = null) {	
			if(node)
				super( node );
		}	
		
		override public function init():void { 
			
			var editableProperties:Object =  new Object();
			editableProperties["label"]	= Attributes.TEXT_AREA;
			setEditableProperties( editableProperties );	
			
			super.init();

		}
		
		override public function draw():void {
			
			_button = new Button();
			_button.label = this.label;	
			_button.setStyle(Button.style.labelStyles, [
			 Label.style.color, 0x535353,
			 Label.style.bold, true,
			 Label.style.size, 13
			]);
			_button.setSize( this.w, this.h );
			addChild(_button);
		}
		
		override public function update():void {	
			_button.label = this.label;	
			_button.setStyle(Button.style.labelStyles, [
			 Label.style.color, 0xFF0000,
			 Label.style.bold, false,
			 Label.style.size, 10
			]);
			_button.setSize( this.w, this.h );
		}
		
		//============================= Element SETTERS  ===================================

		public function set label( val:* ):void {
			setProperty( "label", String(val) );
			invalidate();
		}
		

		
		//============================= Element GETTERS  ===================================

		public function get label():String {
			return String( this.getProperty('label') );
		}
		
	
	}

}