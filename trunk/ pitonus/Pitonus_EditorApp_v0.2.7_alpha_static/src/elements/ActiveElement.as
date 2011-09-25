package  elements
{
	import flash.display.Sprite;
		
	import utils.*;
	import elements.utils.*;
	import data.*;
	import data.utils.*;
	
	public class ActiveElement extends Element implements IElement
	{
		public var clickTarget:*;
		
		public function ActiveElement( node:DataNode ) {	
			super( node );
		}
		
		public function addClickTarget():void {
			clickTarget = new ClickTarget( this, w, h, 0.2 );
		}
		
	}

}

