package ui.dialogs
{
	import data.DataNode;
	import controls.*;
	import events.ControlEvent;
	import events.UiEvent;
	import flash.display.Shape;
	import managers.*
	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import utils.*
	import data.utils.*;
	import flash.events.MouseEvent;
	import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.shortcut.vgroup;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.Event;
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	
	public class Dialog extends Sprite
	{
		protected var _control:ControlWrapper;
		protected var _rec:*;
		protected var _background:BackgroundSkin;
		protected var _mouseTarget:Sprite;
		protected var tabLayout : ILayout;
		
		private var _dragBounds : Rectangle;
		private var _mousePosition : Point;

		private var _windowControls:ControlWrapper;
		
		private	var _border:Shape;
			
		private var _w:uint = 350;
		private var _h:uint = 450;
		
		protected static var CANCEL:String = "Dialog_Cancel";
		
		public function Dialog(rec:* = null) {
			
			_rec = rec;
			
            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        protected function init( e : Event = null ) : void 	{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			//drawWindowControls();
			drawPanel();			
		}
		
		protected function drawWindowControls():void {

			var fo:Object = 
				{
					"name": "ImageList",
					"elementType": "Canvas",
					"layout": "absolute"
				};
				
			fo['pages'] = new Object();
			fo['pages'][0] = { 
							"elementType": "Canvas",
							"w": "350",
							"layout": "inlineH",
							 "elements" : {

							/*	"1" : {
									"w" : "35",
									"elementType" : "TextButton",
									"h" : "35",
									"action" : "Select",
									"actionParam" : "Dialog_Cancel",
									"label" : "X"

								}*/
							}
			};
			_windowControls = new ControlWrapper(parseTreeRecursive(fo, "windowControls"),DataManager.getCommands(),this);
			addChildAt(_windowControls, 0);

		}
		
		public function select(param:String) : void {
			trace(">>>select: Dialog " + param);
			if(param == "Dialog_Cancel")
				cleanUp();
			
			dispatchEvent( new ControlEvent( ControlEvent.ELEMENT_UPDATE, DataManager.selectedElement ) )	;
		}
			
		protected function drawPanel():void {
	
		}
	
		public function cleanUp() : void {
			if (this.numChildren > 0)
				removeChildAt(0);
			if ( _control.stage ) {
				_control.removeEventListener( ControlEvent.CONTROL_READY, setSize );
                _control.destroy();
                removeChild( _control );
            }
			
			for (var i:int = 0; i < this.numChildren; i++) {
				removeChild(this.getChildAt(i));
			}
			
         

        }
		
		protected function setSize( e : ControlEvent = null ) : void 	{
			
			
                tabLayout = vgroup(
					_control
                );
                tabLayout.layout( this );
        
			
				dispatchEvent(new Event(Event.COMPLETE, true));
			
			//trace("Dialog.setSize() " + tabLayout.visibleRect.width + " x " + tabLayout.visibleRect.height);
				
			/*var debugger : LayoutDebugger = new LayoutDebugger();
			addChild( debugger );
			debugger.debug( tabLayout );*/
			
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }
		

		
		public function get w():uint{
			return tabLayout.visibleRect.width;
		}
		
		public function get h():uint{
			return tabLayout.visibleRect.height;
		}
		
	/*	protected function mouseDownHandler(event : MouseEvent) : void {
			trace("mouseDownHandler");
			_mousePosition = new Point(mouseX, mouseY);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}

		protected function mouseUpHandler(event : MouseEvent) : void {
			trace("mouseUpHandler");
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		protected function mouseMoveHandler(event : MouseEvent) : void {
			
			//trace("mouseMoveHandler");
			
			var point : Point = new Point(event.stageX, event.stageY);
			point.x -= _mousePosition.x;
			point.y -= _mousePosition.y;
			point = parent.globalToLocal(point);

			point.x = Math.max(_dragBounds.left, point.x);
			point.x = Math.min(_dragBounds.right - width, point.x);
			point.y = Math.max(_dragBounds.top, point.y);
			point.y = Math.min(_dragBounds.bottom - height, point.y);

			x = point.x;
			y = point.y;
			
			dispatchEvent(new Event("sourceposition", true));
		}*/
	}

}