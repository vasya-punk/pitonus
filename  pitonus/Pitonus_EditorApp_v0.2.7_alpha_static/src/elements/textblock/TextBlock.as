package elements.textblock 
{

	import flash.display.Sprite;
	import flash.text.TextField;
	
	import data.*;
	import utils.*;
	import managers.*;
	import configuration.*;	
	import elements.*;
	import elements.utils.*;
	
	
	public class TextBlock extends ActiveElement implements IElement
	{

		private var _header:TextField;
		private var _fullText:TextField;
											
		public function TextBlock( node:DataNode = null) {	
			if(node)
				super( node );
		}	
		
		override public function init():void { 
			
			var editableProperties:Object =  new Object();
			editableProperties["text"]	= Attributes.TEXT_AREA;
			editableProperties["fontSize"]	= Attributes.NUMBER;
			editableProperties["fontColor"]	= Attributes.NUMBER;
			editableProperties["header"]	= Attributes.TEXT_AREA;

			setEditableProperties( editableProperties );	
			
			super.init();

		}
		
		override public function draw():void {
			
				var fontSize:uint = this.fontSize;
				var fontColor:uint = this.fontColor;
				var textPaddingTop:uint = 0;
				
			
				if( this.header ){
					_header = createTextField( this.header, fontSize + 3, true, w, 20, this.fontColor , true);
					addChild(_header);
					textPaddingTop += 25;
				}
				
				if ( this.text ) {
					
					_fullText = createTextField( this.text, fontSize, false, w, h, 0x5C5C5C );
					_fullText.y += textPaddingTop;
					addChild(_fullText);
				}
				
				

		}
		
		override public function update():void {	
			
			// TODO Check if TextBlock header not drawn, but recieved value 
			if(_fullText){
				_fullText.width = this.w;
				_fullText.height = this.h;
				_fullText.htmlText =  this.text;
			}
			
			if(_header){
				_header.text = this.header;
				_header.width = this.w;
			}
		}
		
		//============================= Element SETTERS  ===================================

		public function set text( val:* ):void {
			setProperty( "text", String(val) );
			invalidate();
		}
		
		public function set header( val:* ):void {
			setProperty( "header", String(val) );
			invalidate();
		}

		
		public function set fontSize( val:* ):void {
			setProperty( "header", String(val) );
			invalidate();
		}
		
		public function set fontColor( val:* ):void {
			setProperty( "fontColor", String(val) );
			invalidate();
		}
		
		//============================= Element GETTERS  ===================================

		public function get text():String {
			if(this.isProperty('text'))
				return this.getProperty('text') ;
			else
				return null;
		}
		
		public function get header():String {
			if(this.isProperty('text'))
				return  this.getProperty('header');
			else
				return null;
		}
		
		public function get fontSize( ):uint {
			var fs:uint = (uint( this.getProperty('fontSize') )) ? (uint( this.getProperty('fontSize') )) : Config.DEFAULT_FONT_SIZE;
			return fs;
		}
		
		public function get fontColor(  ):uint {
			return uint( this.getProperty('fontColor') );
		}
	
	}

}