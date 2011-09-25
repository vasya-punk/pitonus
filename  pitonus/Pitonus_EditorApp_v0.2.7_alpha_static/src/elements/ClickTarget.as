package elements 
{
	import flash.display.SimpleButton;

	import utils.*;
	
	public class ClickTarget extends SimpleButton 
	{
		
		//public var selected:Boolean = false;
		
		public function ClickTarget( parentMc:*, w:uint, h:uint , alpha:Number = 0.2) {
			upState = new drawRoundBox( w, h, 0xC0C0C0, 0);
			downState = new drawRoundBox(w-1, h-1 , Config.COLOR_SELECT_BLUE, alpha + 0.05, 0x0080C0, 2 );//new drawRoundBox( w, h, 0xC0C0C0, 0.2);
			overState = new drawRoundBox(w-1, h-1 , Config.COLOR_SELECT_BLUE, alpha - 0.05, 0x0080C0, 2 );//new drawRoundBox( w, h, 0xC0C0C0, 0.2);
			hitTestState = upState;
			parentMc.addChild(this);
		}
		
	}

}

