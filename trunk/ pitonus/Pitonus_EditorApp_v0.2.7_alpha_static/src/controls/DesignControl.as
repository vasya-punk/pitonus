
package controls 
{
	import controls.*;
	import data.DataNode;
	import data.Node;
	import data.utils.*;
	import elements.image.Background;
	import utils.*;
	import flash.events.Event;
	import managers.*;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class DesignControl extends Control
	{
		private var _backgroundSrc:String; 
		private var _backgroundAlign:String = Config.ALIGN_TOP_LEFT;
		
		public function DesignControl ( node:DataNode, commands:Object, rec:* = null ) {
			super(node, commands, rec);
		}
		
		public function backgroundAlign(value:String):void {
			//var src:String = backgroundSrc;
			_backgroundAlign = value;
			if (background) {
				canvas.removeChild(background);
				(background as Background).alignment = _backgroundAlign;
				DataManager.receiver.site.drawPage();	
			}
		}
		
		public function set backgroundSrc(value:*):void {
			
			trace("Bingo! " + value);
			
			var found:Boolean = false;
			
			_backgroundSrc = value;
			
			if ( background) {
					found = true;
					if (value) {
						background.src = value;
					}else {	
						removeBackground(findElementRecursive(canvas, background.node));
					}
			}

			if (!found && value) {
				createBackground(value);
			}
			
		}
		
		private function get background():* {

			var found:Boolean = false;

			for (var i:int = 0; i < canvas.elements.length; i++) {
				if ( canvas.elements[i].elementType == "Background") {
					return canvas.elements[i]
				}
			}
			return null;
			
		}
		
		private function createBackground(value:*):void{
			canvas.node.addNodeFromObject(
				{
					"elementType": "Background",
					"src": value,
					"w": "550",
					"h": "500",
					"alignment":_backgroundAlign
				  }
				);
				DataManager.receiver.site.drawPage();	
		}
		
		private function removeBackground(bg:*):void{
			if ( canvas ) {
				canvas.removeChild( bg );
				for ( var i:uint = 0; i < canvas.elements.length; i++) {
					if (canvas.elements[i] == bg ) {
						canvas.elements.splice(i, 1);	
					}
				}
				canvas.node.removeNode( bg.node );
			}
			else {
				trace( "[Warning] Element to delete not found!" );
			}
		}
		
		public function get backgroundSrc():* {
			var bgSrc:*;
			
			var found:Boolean = false;
			
			for (var i:int = 0; i < canvas.elements.length; i++) {
				if ( canvas.elements[i].elementType == "Background") {
					found = true;
					bgSrc = canvas.elements[i].src;
				}
			}
			if(found)
				return bgSrc;
			else
				return null;
		}
	
		
	}

}