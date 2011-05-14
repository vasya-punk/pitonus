package Elements 
{
	import flash.display.SimpleButton;

	import Utils.*;
	
	public class ClickTarget extends SimpleButton 
	{
		
		//public var selected:Boolean = false;
		
		public function ClickTarget( parentMc:*, w:uint, h:uint ) {

			upState = new drawRoundBox( w, h, 0xC0C0C0, 0);
			downState = new drawRoundBox( w, h, 0xC0C0C0, 0);
			overState = new drawRoundBox( w, h, 0xC0C0C0, 0.1);
			hitTestState = upState;
			parentMc.addChild(this);
		}
		
	}

}

