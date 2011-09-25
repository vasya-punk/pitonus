package elements.input 
{
	import com.sibirjak.asdpc.button.Button;
	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpc.textfield.TextInput;
	import flash.display.Sprite;
	import flash.text.TextField;
	
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
	public class Input extends Element implements IElement
	{		

		private var _input:TextInput;
		private var _label:Label;
		private var _labelWidth:uint = 45;
												
		public function Input( node:DataNode = null) {	
			if(node)
				super( node );
		}	
		
		override public function init():void { 
			
			var editableProperties:Object =  new Object();
			editableProperties["text"]	= Attributes.TEXT_AREA;
			setEditableProperties( editableProperties );	
			
			super.init();

		}
		
		override public function draw():void {
			
			
				
			_input = new TextInput();
			_input.text = text;	
			_input.setSize( this.w, this.h );
			addChild(_input);
			
			if (label){
				_label = new Label();
				_label.x = _input.width + 5;
				_label.setSize(_labelWidth,h);
				_label.text = label;
				addChild(_label)
			}
		}
		
		override public function update():void {	
			_input.text = this.text;	
			_input.setSize( this.w, this.h );
			if (label)	_label.text = label;
		}
		
		//============================= Element SETTERS  ===================================

		public function get inputText():String {
			return _input.text;
		}

		public function set text( val:* ):void {
			setProperty( "text", String(val) );
			_input.text = val;
			invalidate();
		}

		public function get text():String {
			return String( this.getProperty('text') );
		}
		
		public function set label( val:* ):void {
			setProperty( "text", String(val) );
			invalidate();
		}

		public function get label():String {
			return String( this.getProperty('label') );
		}
		
		public function set val( val:* ):void {
			setProperty( "val", String(val) );
			invalidate();
		}

		public function get val():String {
			return String( this.getProperty('val') );
		}
		
	
	}

}