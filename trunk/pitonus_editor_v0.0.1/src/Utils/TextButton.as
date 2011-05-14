package Utils {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;


	public class TextButton extends SimpleButton {
		
		public var selected:Boolean = false;
		public function TextButton(txt:String, w:uint = 125, h = 30 ) {
			upState = new TextButtonState(0xFFFFFF, txt, w, h);
			downState = new TextButtonState(0x999999, txt, w, h);
			overState = new TextButtonState(0xCCCCCC, txt, w, h);
			hitTestState = upState;
		
		}
		public function changeLabel(txt:String):void {
			var format:TextFormat = new TextFormat("Verdana");
			
			
			var labelsamplebtn:TextField
			
			//-----mous Up ---- 
			var samplebtn_doc:DisplayObjectContainer = upState as DisplayObjectContainer; 
			var labelsamplebtn:TextField = samplebtn_doc.getChildAt(1) as TextField; 
			labelsamplebtn.setTextFormat(format);
			labelsamplebtn.text = txt;	
			
			samplebtn_doc = downState as DisplayObjectContainer; 
			var labelsamplebtn:TextField = samplebtn_doc.getChildAt(1) as TextField; 
			labelsamplebtn.setTextFormat(format);
			labelsamplebtn.text = txt;	
			
			samplebtn_doc = overState as DisplayObjectContainer; 
			var labelsamplebtn:TextField = samplebtn_doc.getChildAt(1) as TextField; 
			labelsamplebtn.setTextFormat(format);
			labelsamplebtn.text = txt;	
		}
	}
}

import flash.display.*;
import flash.text.TextFormat;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import Utils.*;

class TextButtonState extends Sprite {
	
    public function TextButtonState(color:uint, labelText:String, w:uint, h:uint) {
        var label:TextField = createTextField(labelText, 15, 0, 0);

        var background:Shape = new Shape();
        background.graphics.beginFill(color);
        background.graphics.lineStyle(2, 0x000000);
        background.graphics.drawRoundRect(0, 0, w, h , 5);
        addChild(background);
        addChild(label);
    }
}