package elements.activeimage
{
	import com.sibirjak.asdpc.textfield.Label;
	import flash.display.Sprite;
	
	import utils.*;
	import managers.*;
	import configuration.*;
	import data.*;
	import elements.*;
	
	public class ActiveImage extends ActiveElement implements IElement
	{
		
		private var AIClip:Sprite;
		private var label:Label = new Label();
		
		
		public function ActiveImage( node:DataNode = null) {	
			if(node)
				super( node );
		}
		
	
		override public function init():void { 
			
			var editableProperties:Object =  new Object();
			editableProperties["caption"] 	= Attributes.INPUT
			editableProperties["src"]		= Attributes.UPLOAD;

			setEditableProperties( editableProperties );	
			
			super.init();
		}
		
		override public function draw():void {

			var loadTarget:Sprite = new Sprite();
			loadTarget.x = 5; 
			loadTarget.y = 5;

			var load:LoadFromURL = new LoadFromURL( loadTarget, src,  w - 10, h - 25);
			
			label = new Label();
			label.y = h - 20;
			label.x = 10;
			label.setSize( w - 20, 20);
			label.text = caption;
			
			AIClip  = new drawRoundBox( w, h, 0xbcbcbc, 1, 0xb1b1b1, 2);
			AIClip.addChild(label);	
			AIClip.addChild(loadTarget);
			addChild(AIClip);
		
		}
		
		override public function update():void {

			// CleanUp display list
			var i:uint;
			for ( i = 0; i < AIClip.numChildren; i++ ) {
				AIClip.removeChildAt(i);
			}

			cleanUp();
			
			label = null;
			AIClip = null;
			
			
			var loadTarget:Sprite = new Sprite();
			loadTarget.x = 5; 
			loadTarget.y = 5;
	
			var load:LoadFromURL = new LoadFromURL( loadTarget, src,  w - 10, h - 25 );
			
			label = new Label();
			label.y = h - 20;
			label.x = 10;
			label.setSize( w - 20, 20);
			label.text = caption;
			
			AIClip  = new drawRoundBox( w, h, 0xbcbcbc, 1, 0xb1b1b1, 2);
			AIClip.addChild(label);	
			AIClip.addChild(loadTarget);
			addChild(AIClip);
		}
		
		//============================= Element SETTERS  ===================================
		
		public function set caption( val:* ):void {
			setProperty( "caption", String(val) );
		}
		
		public function set src( val:* ):void {
			setProperty( "src", String(val) );
		}
		
		//============================= Element GETTERS  ===================================
		
		public function get caption():String {
			return String( this.getProperty('caption') );
		}
		
		public function get src():String {
			return String( this.getProperty('src') );
		}
	}

}