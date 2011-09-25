package utils
{	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;

	public function createTextField(txt:String, fontSize:uint = 14, bold:Boolean = false, w:Number = -1, h:Number = 25, color:uint = 0x2D2D2D, embedd:Boolean = false):TextField 
	{

			var gft:String = "GridFitType.NONE";
			var fm:TextFormat = new TextFormat();
			
			if(embedd){
				var embeddFont:*;
				embeddFont = (bold) ? new CalibriFontBold() : new  CalibriFont();
				fm.bold = (bold) ? true : false;
				
				fm.font = embeddFont.fontName;
			
			}
			fm.size = fontSize;
			
				
		
		var result:TextField = new TextField();
		result.wordWrap = true;
		result.border = false;
		result.multiline = true;
		
		if (w != -1)
			result.width = w;
		
		result.height = h;
		result.selectable = false;
		if(embedd)	result.embedFonts=true;
		result.antiAliasType = AntiAliasType.NORMAL;
		result.autoSize = TextFieldAutoSize.LEFT;
		result.textColor = color;
		result.gridFitType = gft;
		result.defaultTextFormat = fm;
		result.setTextFormat(fm);

		result.htmlText = txt;

		return result;
		
		
	}
}