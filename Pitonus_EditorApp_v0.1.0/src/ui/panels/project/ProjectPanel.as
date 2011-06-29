package ui.panels.project
{
	import data.DataNode;
	import controls.*;
	import managers.*
	import data.utils.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
		
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class ProjectPanel extends Sprite
	{
		private var _control:CanvasControl;
		private var _editor:*;
		
		public function ProjectPanel(rec:*) {
			
			_editor = rec;
			
            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        private function init( e : Event = null ) : void 	{
			
			var background : BackgroundSkin = new BackgroundSkin();
			background.setSize( 200, 200);
			addChild(background);
			
			
			var elementNode:DataNode = parseTreeRecursive(
				{
					"elementType": "Canvas",
					"w": "200",
					"h": "450",
					"valid":true,
					"identifier": "CANVAS_ON_PAGE",
					"name": "TestCanvas",
					"backgroundStretch" : "true",
					"marginX" : "10", "marginY" : "10", 
					"elements": 
						[
						
						
						
							{
							"elementType" 	: "TextBlock",
							"text" 		: "PROJECT:",
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
							"label"			: "New Project",
							"marginY"		: "20",
							"w" 			: "180",
							"h" 			: "30", 
							"action" 		: "NewSite",
							"inline"		: "true"
							},
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "Load Default Project",
							"marginY"		: "10",
							"w" 			: "180",
							"h" 			: "30", 
							"action" 		: "LoadSite",
							"inline"		: "true"
							},
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "Save Project",
							"marginY"		: "10",
							"w" 			: "180",
							"h" 			: "30", 
							"action" 		: "SaveSite",
							"inline"		: "true"
							}

							
						]
				});
				
			_control = new CanvasControl( elementNode, DataManager.getCommands(), _editor);
			addChild(_control );


		}
		public function removeControl( ) : void 	{
			_control.removeActions();
			_control.removeCanvas();
		}
	}

}