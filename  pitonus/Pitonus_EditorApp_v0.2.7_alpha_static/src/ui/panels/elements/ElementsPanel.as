package ui.panels.elements
{
	import data.DataNode;
	import controls.*;
	import events.ControlEvent;
	import flash.events.MouseEvent;
	import managers.*
	import data.utils.*;
	import org.as3commons.ui.layout.framework.ILayout;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
		
	//import com.sibirjak.asdpc.core.skins.BackgroundSkin;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class ElementsPanel extends Sprite
	{
		private var _control:ControlWrapper;
		private var _rec:*;
		//private var _background:BackgroundSkin;
		
		public function ElementsPanel(rec:*) {
			
			_rec = rec;
			
            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }


        
		
		private function init( e : Event = null ) : void 	{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			

			var _aviableElements:Object =	DataManager.mcClasses;
			var elementTypeNum : int =  _aviableElements['names'].indexOf( "addElement_Panel" );
			var elementClass : * = null;
			var menuElements:Array = new Array();
			
			if ( elementTypeNum != - 1 ) {
				elementClass = _aviableElements['runtimeClassRefs'][elementTypeNum];
			}
			
			if (elementClass) {
				var element:* = null;
				//for (var i:int = 0; i < items.length; i++) {
					element = new elementClass;
					//element.x = element.width * i + i * 1;
					//element.name = i;
					//element.menuMC.label.text = items[i]; 
					
					//element.menuMC.over();

					element.btn1.addEventListener(MouseEvent.CLICK, onMenuClick);
					element.btn2.addEventListener(MouseEvent.CLICK, onMenuClick);
					element.btn3.addEventListener(MouseEvent.CLICK, onMenuClick);
					element.btn4.addEventListener(MouseEvent.CLICK, onMenuClick);
					addChild(element);
					menuElements.push(element);
				//}
				
			}
			function onMenuClick(e:MouseEvent):void {
				trace("[a][p] ElementsPanel - onMenuClick() : " + e.currentTarget + " " + e.currentTarget.name);
				//dispatchEvent(new ControlEvent(ControlEvent.MENU_CLICK, uint(e.currentTarget.name)));
				switch (e.currentTarget.name) 
				{
					default:
					case "btn1":
						_rec.addElement("Image");
					break;
					case "btn2":
						_rec.addElement("TextBlock");
					break;
					case "btn3":
						_rec.addElement("ActiveImage");
					break;
					case "btn4":
						_rec.addElement("Button");
					break;
					
				}
			}
			setSize();
		}
		public function setSize(e:ControlEvent = null) : void 	{
			//trace("[o] ElementsPanel.as - setSize");

			/*_background = new BackgroundSkin();
			_background.setSize( 
						(_control.canvas.canvasLayout as ILayout).visibleRect.width , 
						(_control.canvas.canvasLayout as ILayout).visibleRect.height
					);
			addChildAt(_background, 0);*/
			
			DataManager.layout.addToLayout(this, Config.ALIGN_TOP_RIGHT,0,330);
		}
		
		public function get control():* {
					return _control;
		}
	}

}