package ui.dialogs 
{

	import controls.*;
	import data.*;
	import elements.canvas.Canvas;
	import elements.textblock.TextBlock;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import org.as3commons.ui.layout.framework.ILayout;
	import ui.dialogs.Dialog;
	import ui.dialogs.selection.ChooseFromDialog;
	import ui.panels.Panel;
	import utils.*;
	import events.*;
	import data.utils.*;
	import flash.events.Event;
	import flash.text.TextField;
	import managers.*;
	import flash.display.Sprite;
	import controls.*;
	import flash.events.MouseEvent;
	import managers.utils.TraceNode;
	import com.adobe.serialization.json.*;
	import org.as3commons.ui.layout.shortcut.vgroup;
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;	


	public class TextAlertDialog extends Dialog 
	{
		//private var _con:Canvas ;
		private var _messageText:String;
		private var _header:String;
		private var _icon:Sprite;
		private var _width:uint = 300;
		private var _height:uint = 200;

		public function TextAlertDialog(txt:String) {

			
            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        override protected function init( e : Event = null ) : void 	{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			
			
			var node:Object =
				
			 {
                "pages" : {
                    "page0" : {
				  "w": "300", "h": "300",
				  "marginY":"5","marginX":"5",
				  "elementType": "Canvas",
				  
				  "elements": {
					  
							"1": {
							  "header": "PAGE2",
							  "fontSize": "16",
							  "w": "200","h": "200",
							  "elementType": "TextBlock",
							  "text": "No Information on the lower bo processles, roll call vote records, ...",
							  "fontColor": "0x004080"
							  
							},
							"2": {
							  "header": "PAGE2",
							  "fontSize": "16",
							  "w": "200","h": "200",
							  "elementType": "TextBlock",
							  "text": "No Information on the lower bo processles, roll call vote records, ...",
							  "fontColor": "0x004080"
							  
							}
							,
							"3": {
							  "elementType": "Image",
							  "w": "100", "h": "20",
							  "src": "userfiles/usermedia/pic11.jpg"
							}
				  }
				  
				}
                }
                ,
                "elementType" : "Canvas",
				"w": "300", "h": "300"
            }
			
			

			
			
			_control = new ControlWrapper( parseTreeRecursive( node ), DataManager.getCommands(), this );
		  _control.addEventListener( ControlEvent.CONTROL_READY, onCanvasDraw );
		   //_control.addEventListener( ControlEvent.PAGE_CHANGED, update );
		   addChild( _control );
			
		/*	_canvas = new Canvas(node);
			_canvas.addEventListener(  CanvasEvent.ONDRAW, onCanvasDraw );
			addChild(_canvas);*/
		}
		
		public function onCanvasDraw(e:ControlEvent):void { 
				//trace((_control.canvas.canvasLayout as ILayout).visibleRect.width
				//+ "x" + (_control.canvas.canvasLayout as ILayout).visibleRect.height);
				_width = (_control.canvas.canvasLayout as ILayout).visibleRect.width + 50;
				_height = (_control.canvas.canvasLayout as ILayout).visibleRect.height + 50;
				
				var separator : Sprite = dashHorizontal( 0, 0, _width );
				addChild( separator );
			
				dispatchEvent(new Event(Event.COMPLETE, true));
		}
	
		override public function get w():uint{
			return _width;
		}
		
		override public function get h():uint{
			return _height;
		}
	}

}