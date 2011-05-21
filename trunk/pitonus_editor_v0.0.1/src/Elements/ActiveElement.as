package  Elements
{
	import flash.display.Sprite;
	import Managers.DataNode;
		
	import Utils.*;
	
	public class ActiveElement extends Element implements IElement
	{
		public var clickTarget:*;
		
		public function ActiveElement( node:DataNode ) {	
			super( node );
		}
		
		public function addClickTarget():void{
			clickTarget = new ClickTarget( this, int(this.getProperty('w')),int(this.getProperty('h')) );
		}
		
	}

}

