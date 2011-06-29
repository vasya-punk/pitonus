package ui.panels.elements
{
	import data.DataNode;
	import controls.*;
	import managers.*
	import data.utils.*;
	import org.as3commons.ui.layout.framework.ILayout;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
		
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class ElementsPanel extends Sprite
	{
		private var _control:ElementsControl;
		private var _site:*;
		private var _background:BackgroundSkin;
		
		public function ElementsPanel(rec:*) {
			
			_site = rec;
			trace( "ProjectPanel." + _site + " " + typeof(_site) );
            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        private function init( e : Event = null ) : void 	{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var elementNode:DataNode = parseTreeRecursive(
				{
					"elementType": "Canvas",
					"w": "200",
					"h": "250",
					"valid":true,
					"identifier": "CANVAS_ON_PAGE",
					"name": "TestCanvas",
					"backgroundStretch" : "true",
					"marginX" : "10", "marginY" : "10", 
					"elements": 
						[

							
							{
							"elementType" 	: "TextBlock",
							"text" 		: "ELEMENTS:",
							"w"				: "180",
							"h"				: "450",
							"marginX"		: "0",
							"marginY"		: "0",
							"fontColor"		: "0x00974B",
							"inline"		: "true"
							},
							
							
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "Add Text",
							"marginY"		: "20",
							"w" 			: "180",
							"h" 			: "30", 
							"action" 		: "AddElement",
							"actionParam" 	: "TextBlock",
							"inline"		: "true"
							},
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "Add Image",
							"w" 			: "180",
							"marginY"		: "10",
							"h" 			: "30", 
							"action" 		: "AddElement",
							"actionParam" 	: "Image",
							"inline"		: "true"
							},
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "Add CaptionImage",
							"w" 			: "180",
							"h" 			: "30", 
							"marginY"		: "10",
							"action" 		: "AddElement",
							"actionParam" 	: "ActiveImage",
							"inline"		: "true"
							},
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "Remove Element",
							"marginY"		: "20",
							"w" 			: "150",
							"h" 			: "30", 
							"action" 		: "RemoveElement",
							"inline"		: "true"
							}
							
						]
				});
			
			trace(">>>> " + this.stage);
			
			_background = new BackgroundSkin();
			_background.setSize( 200, 250);
			addChild(_background);	
			
			_control = new ElementsControl( elementNode, DataManager.getCommands(), _site);
			_control.addEventListener(ControlEvent.CANVAS_ONDRAW, onCanvasReady);
			addChild(_control );

			
		

		}
		
		private  function onCanvasReady( e:ControlEvent ) : void 	{

			var layout:ILayout = _control.canvas.layout as ILayout;
			var h:uint = uint(layout.visibleRect.height);

			_background.setSize( 200, h+40);

		}
		
		public function removeControl( ) : void 	{
			_control.removeEventListener(ControlEvent.CANVAS_ONDRAW, onCanvasReady);
			_control.removeActions();
			_control.removeCanvas();
		}
	}

}