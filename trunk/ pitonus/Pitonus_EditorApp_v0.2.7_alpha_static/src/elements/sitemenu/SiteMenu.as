


package elements.sitemenu 
{

	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;

	import utils.*;
	import elements.utils.*;
	import managers.*;
	import configuration.*;
	import data.*;
	import elements.*;
	import events.*;
	
	
	public class SiteMenu extends Element implements IElement
	{
		private var menuClip:Sprite;
		//private var _items:Array;
		
		public function SiteMenu( node:DataNode = null) {	
			if(node)
				super( node );
		}
		
		override public function init():void { 
			
			var editableProperties:Object =  new Object();
			editableProperties["items"]	  = Attributes.LIST;

			setEditableProperties( editableProperties );	
			
			super.init();
		}
		

		override public function draw():void {
			
			/*image = new Sprite();
			drawSquare(image, new Rectangle(0, 0, w, h));
			addChild(image);

			var load:LoadFromURL = ( w && h )? 
				new LoadFromURL( image, Config.IMAGES_PATH + src, w, h, "stretch") : new LoadFromURL(  this, src );*/
			
			var _aviableElements:Object =	DataManager.mcClasses;
			var elementTypeNum : int =  _aviableElements['names'].indexOf( "siteMenu" );
			var elementClass : * = null;
			var menuElements:Array = new Array();
			
			if ( elementTypeNum != - 1 ) {
				elementClass = _aviableElements['runtimeClassRefs'][elementTypeNum];
			}
			
			if (elementClass) {
				var element:* = null;
				for (var i:int = 0; i < items.length; i++) {
					element = new elementClass;
					element.x = element.width * i + i * 1;
					element.name = i;
					element.menuMC.label.text = items[i]; 
					
					//element.menuMC.over();
					element.addEventListener(MouseEvent.CLICK, onMenuClick);
					addChild(element);
					menuElements.push(element);
				}
				
			}
			function onMenuClick(e:MouseEvent):void {
				dispatchEvent(new ControlEvent(ControlEvent.MENU_CLICK, uint(e.currentTarget.name)));
			}
			
		}
		
		override public function update():void {
			
		}
		
		
		
		//============================= Element SETTERS  ===================================

		public function get items():* {
			return (this.getProperty('items') as String).split(",");
		}
		
		public function set items(value:Array):* {
			setProperty( "items", joinArray(value) );
			invalidate();
		}
		
		
	}

}