package ui.windows {


	import com.sibirjak.asdpcbeta.slider.Slider;
	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpcbeta.selectbox.SelectBox;
	import elements.canvas.Canvas;
	import events.ControlEvent;
	import events.UiEvent;
	import org.as3commons.ui.layout.Display;
	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import org.as3commons.ui.layout.framework.IDisplay;
	import org.as3commons.ui.layout.framework.IDynTable;
	import org.as3commons.ui.layout.framework.IGroupLayout;
	import org.as3commons.ui.layout.framework.IHLayout;
	import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.framework.IMultilineLayout;
	import org.as3commons.ui.layout.framework.ITable;
	import org.as3commons.ui.layout.framework.IVLayout;
	import org.as3commons.ui.layout.shortcut.hgroup;
	import org.as3commons.ui.layout.shortcut.hlayout;
	import org.as3commons.ui.layout.shortcut.vgroup;
	import ui.*;	
	import utils.*;	
	import managers.*;	
	import controls.*;		
	import ui.panels.project.ProjectPanel;
	import ui.panels.QuickToolbarPanel;

	import flash.display.Sprite;

	/**
	 * @author Jens Struwe 29.03.2011
	 */
	public class QuickToolbarWindow extends Sprite {

		private var _element : *;
		private var _receiver:*;
		private var _w:uint;
		private var _h:uint;
		private var _toolbar:*;
			
		public function QuickToolbarWindow( rec:* ) {
			_receiver 	= rec;	
		}
		
		private function drawContnet( ):void {
			
			
			/*var dialog:EditElementProperties = new EditElementProperties( DataManager.selectedElement, DataManager.getCommands(), null);
			dialog.addEventListener(ControlEvent.CANVAS_ONDRAW, onDraw);
	
			function onDraw(e:ControlEvent):void { 
				trace("\n>--------------- Editor. onDraw ---------------\n");
				(DataManager.overlayManager as OverlayManager).createDialog( dialog, "Yooo");
				
			}
			
			addChild(dialog);
			DataManager.elementProperties = dialog;*/

			var _toolbar:QuickToolbarPanel = new QuickToolbarPanel( this);
			_toolbar.addEventListener(ControlEvent.PAGE_READY, onDraw);
			addChild(_toolbar);
		}
		
		private function onDraw(e:ControlEvent):void { 
			trace(e.data);
			trace("\n>--------------- Toolbar.onDraw ---------------\n");
			dispatchEvent(new UiEvent( UiEvent.DOCUMENT_READY, _toolbar));
				
		}
	
	
		//============================= GETTERS/SETTERS  ===================================
		

		
		public function get element( ):* {
			return _element;
		}
		
		

		
		public function set element(value:*):void 	{
			_element = value;
			
			if (_toolbar) {
				_toolbar.destroy();
				removeChild(_toolbar);
			}
			trace(element);
			
			_toolbar = new QuickToolbarPanel( this);
			_toolbar.addEventListener(ControlEvent.PAGE_READY, onDraw);
			addChild(_toolbar);
			
		}
		
	
		

	
	}

}