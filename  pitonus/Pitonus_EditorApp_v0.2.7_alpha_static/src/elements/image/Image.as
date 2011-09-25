


package elements.image 
{

	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import utils.*;
	import managers.*;
	import configuration.*;
	import data.*;
	import elements.*;
	
	public class Image extends ActiveElement implements IElement
	{
		protected var _image:Sprite;
		
		public function Image( node:DataNode = null) {	
			if(node)
				super( node );
		}
		
		override public function init():void { 
			
			var editableProperties:Object =  new Object();
			editableProperties["src"]		= Attributes.UPLOAD;

			setEditableProperties( editableProperties );	
			
			super.init();
		}
		

		override public function draw():void {
			
			_image = new Sprite();
			drawSquare(image, new Rectangle(0, 0, w, h));
			addChild(image);

			
			DataManager.jsBridge.traceToJs("Inside _image >>>>>>>>>>>>> " + src);
			
			
			var load:LoadFromURL = ( w && h )? 
			new LoadFromURL( _image, src, w, h, "stretch") : new LoadFromURL(  this, src );

		}
		
		override public function update():void {
			image.width = w;
			image.height = h;
		}
		
		//============================= Element SETTERS  ===================================

		public function set src( val:* ):void {
			setProperty( "src", String(val), false );
			
			var i:uint;
			for ( i = 0; i < image.numChildren; i++ ) {
				image.removeChildAt(i);
			}

			for ( i = 0; i < this.numChildren; i++ ) {
				this.removeChildAt(i);
			}
			
			_image = new Sprite();
			drawSquare(image, new Rectangle(0, 0, w, h));
			addChild(image);
			
			var load:LoadFromURL = ( w && h )? 
				new LoadFromURL( image, src, w, h, "stretch") : new LoadFromURL(  this, src );
		}
		
		//============================= Element GETTERS  ===================================

		
		public function get src():String {
			return String( this.getProperty('src') );
		}
		
		public function get image():Sprite {
			return _image;
		}
		
		/*override public function getMinimalProperties():Object {
			//traceObject(_editableProperties);
			var minimalProperties:Object =  new Object();
			//minimalProperties["src"] = Attributes.UPLOAD;
			minimalProperties["w"] = Attributes.NUMBER;
			minimalProperties["h"]= Attributes.NUMBER;
			
			return minimalProperties;
		}*/
		
	}

}