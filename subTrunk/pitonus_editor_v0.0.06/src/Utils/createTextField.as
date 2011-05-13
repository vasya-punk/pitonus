package Utils
{	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;

	public function createTextField(txt:String, fontSize:uint = 14, bold:Boolean = false, x:Number = 0, y:Number = 0, color:uint = 0x2D2D2D):TextField 
	{
			var gft:String = "GridFitType.NONE";
			var fm:TextFormat = new TextFormat();
			
			var embeddFont:*;
			embeddFont = (bold) ? new CalibriBold() : new CalibriRegular();
			fm.bold = (bold) ? true : false;
			
			fm.font = embeddFont.fontName;
			fm.size = fontSize;
			

		
		var result:TextField = new TextField();
		result.x = x;
		result.y = y;
		result.selectable = false;
		result.embedFonts=true;
		result.antiAliasType = AntiAliasType.NORMAL;
		result.autoSize = TextFieldAutoSize.LEFT;
		result.textColor = color;
		result.gridFitType = gft;
		result.defaultTextFormat = fm;
		result.setTextFormat(fm);
		result.text = txt;

		return result;
		
		
	}
}