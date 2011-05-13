package  Elements
{
	import flash.display.Sprite;
		
	import Utils.*;
	
	public class ActiveElement extends Element implements IElement
	{
		public var clickTarget:*;
		
		public function addClickTarget():void{
			clickTarget = new ClickTarget( this, int(this.getProperty('w')),int(this.getProperty('h')) );
		}
		
	}

}

