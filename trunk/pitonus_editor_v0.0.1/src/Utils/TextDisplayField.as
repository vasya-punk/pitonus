package Utils {
	
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class TextDisplayField extends TextField {
		
		public function TextDisplayField(labelText:String = "", fontSize:int = 8, showborder:Boolean = true) {
			autoSize = TextFieldAutoSize.LEFT;
			border = showborder;
			var format:TextFormat = new TextFormat("Tahoma");
			format.size = fontSize;
			setTextFormat(format);
			text = labelText;
		}
	}
}
