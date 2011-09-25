


package elements.iconsbar 
{

	import controls.Control;
	import controls.ControlWrapper;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;

	import utils.*;
	import data.utils.*;
	import elements.utils.*;
	import managers.*;
	import configuration.*;
	import data.*;
	import elements.*;
	import events.*;
	
	
	public class IconsBar extends Element implements IElement
	{
		private var menuClip:Sprite;
		//private var _items:Array;
		
		public function IconsBar( node:DataNode = null) {	
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
			
			var obj:Object =
			{
				  "elementType": "Canvas",
				  "name":"MySite",
				  "pages": {
							

								"Page_2": {
								  "elementType": "Canvas","layout":"inlineH",
								  "elements": {
									
									"0": {
									  "w": "75",
									  "elementType": "Image",
									  "h": "50",
									  "src": "editor/icon1.png","action":"Select","actionParam":"0"
									},
									"1": {
									  "w": "75",
									  "elementType": "Image",
									  "h": "50",
									    "src": "editor/icon1.png","action":"Select","actionParam":"1"
									},
									"2": {
									  "w": "75",
									  "elementType": "Image",
									  "h": "50",
									    "src": "editor/icon1.png","action":"Select","actionParam":"2"
									}
								  },
								  "defaultPage": "true",
								  "h": "50","w":"550"
								}
							}
			}
		
			;
			
			var _control:Control = new Control(parseTreeRecursive(obj), DataManager.getCommands(),this);
			_control.addEventListener( ControlEvent.CONTROL_ACTIONS_ATTACHED, onCanvasReady );
			addChild(_control);

			function onCanvasReady(e:ControlEvent):void {
				e.stopPropagation();
				trace("IconsBar.onCanvasReady()");
			}
			
			

		}
		
		public function select(param:String):void {
				//trace("IconsBar.onMenuClick() " + e.currentTarget + " " + e.currentTarget.name);
				dispatchEvent(new ControlEvent(ControlEvent.MENU_CLICK, uint(param)));
		}
		
		override public function update():void {
			
		}
		
		/*override public function get w():uint {
			return uint( 100 );
		}
		
		override public function get h():uint {
			return uint( 30 );
		}*/
		
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