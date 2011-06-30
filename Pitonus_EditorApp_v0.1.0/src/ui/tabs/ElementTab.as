package ui.tabs {


	import com.sibirjak.asdpc.button.Button;
	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpcbeta.selectbox.SelectBox;
	import elements.canvas.Canvas;
	import elements.Element;
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
	import configuration.*;

	import flash.display.Sprite;

	/**
	 * @author Jens Struwe 29.03.2011
	 */
	public class ElementTab extends ControlPanelBase {

		
		private var _element : *;
		private var _canvas : Canvas;
		private var _receiver:*;
		public var tabLayout : ILayout;
		//private var _contnet:Sprite;
		
		public function ElementTab(element:*, canvas:Canvas, rec:* ) {
			_element 	= element;
			_canvas	 	= canvas;
			_receiver 	= rec;	
			drawContent();
		}
		
		private function drawContent( ):void {

			
			tabLayout = vgroup(
				"offsetX", 4,
				"offsetY", 8,
			
				"hGap", 8,
				"vGap", 4,
				
				headline("Change", 150),
				button( 
					{
						id: "OptionsButton",
						w: 140,
						h: 30,
						label: "Configure",
						click: function( ) : void {
							openOptions();
						}
					})
			);
			
			tabLayout.layout(this);
			//trace(".............. " + tabLayout.visibleRect.width);
		}
		
		//============================= GETTERS/SETTERS  ===================================
		private function reDrawContent(  ):void {
			/*if(Display(tabLayout.getLayoutItem("OptionsButton")).displayObject as Button){
				var btn:Button = Display(tabLayout.getLayoutItem("OptionsButton")).displayObject as Button;
				trace("redrawContent " + this.numChildren);
				btn.label = element.name;
			}*/
		}
		
		public function set element( trg:* ):void {
			_element = trg;
			if(_element)
				reDrawContent();
		}
		
		public function get element( ):* {
			return _element;
		}
		
		public function set canvas( trg:* ):void {
			_canvas = trg;
		}
		
		public function openOptions( ):void {
			_receiver.openOptions();
		}
		
	}

}