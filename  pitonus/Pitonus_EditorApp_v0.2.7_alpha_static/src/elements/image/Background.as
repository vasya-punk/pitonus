


package elements.image 
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import utils.*;
	import managers.*;
	import configuration.*;
	import data.*;
	import elements.*;
	
	public class Background extends Image implements IElement
	{
		
		public function Background( node:DataNode = null) {	
			if(node)
				super( node );
		}
		
		override public function init():void { 
			
			var editableProperties:Object 	=  new Object();
			editableProperties["src"]		= Attributes.UPLOAD;
			editableProperties["alignment"]	= Attributes.INPUT;

			setEditableProperties( editableProperties );	
			
			super.init();
		}
		

		override public function draw():void {

			_image = new Sprite();
			drawSquare(image, new Rectangle(0, 0, w, h));
			addChild(image);


			var load:LoadFromURL = ( w && h )? 
			new LoadFromURL( image, src, w, h, "stretch") : new LoadFromURL(  this, src );

			load.addEventListener(  Event.COMPLETE, addToLayout);
		
		}
		

		private function addToLayout(e:Event = null ):void {
			//trace("[i][e] Background - addToLayout() : " + this);
			DataManager.layout.addToLayout(this, alignment );
		}
		
		
		//============================= Element GETTERS  ===================================

		
		
		public function set alignment( val:* ):void {
			trace("Background. alignment");
			setProperty( "alignment", String(val),true );
			addToLayout();
		}
		
		public function get alignment(  ):*{
			return getProperty('alignment');
		}
		
	}

}