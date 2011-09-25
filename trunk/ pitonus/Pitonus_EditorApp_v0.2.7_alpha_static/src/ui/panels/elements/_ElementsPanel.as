package ui.panels.elements
{
	import data.DataNode;
	import controls.*;
	import events.ControlEvent;
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
		private var _control:ControlWrapper;
		private var _site:*;
		private var _background:BackgroundSkin;
		
		public function ElementsPanel(rec:*) {
			
			_site = rec;
			
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
  "h": "480",
  "layout": "inlineH",
  "marginX": "0",
  "marginY": "0",
  "align": "center",
"pages":{
"page8":{
  "elements": {
    "0": {
      "elementType": "TextBlock",
      "text": "ELEMENTS:",
      "w": "180",
      "h": "450",
      "fontColor": "0x00974B"
    },
    "3": {
      "elementType": "TextButton",
      "label": "Add Text",
      "w": "180",
      "h": "30",
      "action": "AddElement",
      "actionParam": "TextBlock"
    },
    "4": {
      "elementType": "TextButton",
      "label": "Add Image",
      "w": "180",
      "h": "30",
      "action": "AddElement",
      "actionParam": "Image"
    },
    "5": {
      "elementType": "TextButton",
      "label": "Add CaptionImage",
      "w": "180",
      "h": "30",
      "action": "AddElement",
      "actionParam": "ActiveImage"
    },
    "10": {
      "elementType": "TextButton",
      "label": "Remove Element",
      "w": "150",
      "h": "30",
      "action": "RemoveElement"
    }
  },
 "elementType": "Canvas",
  "w": "200",
  "h": "480",
  "layout": "inlineH"}
}
}				
				);

			_control = new ControlWrapper( elementNode, DataManager.getCommands(), _site );
			_control.addEventListener(ControlEvent.CONTROL_READY, setSize );
			addChild(_control );

			
		

		}
		
		
		public function setSize(e:ControlEvent) : void 	{
			//trace("[o] ElementsPanel.as - setSize");

			_background = new BackgroundSkin();
			_background.setSize( 
						(_control.canvas.canvasLayout as ILayout).visibleRect.width , 
						(_control.canvas.canvasLayout as ILayout).visibleRect.height
					);
			addChildAt(_background, 0);
			
			DataManager.layout.addToLayout(this, Config.ALIGN_BOTTOM_LEFT);
		}
		
		public function get control():* {
					return _control;
		}
	}

}