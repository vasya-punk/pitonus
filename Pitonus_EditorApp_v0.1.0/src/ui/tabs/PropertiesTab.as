package ui.tabs {


	import com.sibirjak.asdpcbeta.slider.Slider;
	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpcbeta.selectbox.SelectBox;
	import elements.canvas.Canvas;
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

	import flash.display.Sprite;

	/**
	 * @author Jens Struwe 29.03.2011
	 */
	public class PropertiesTab extends ControlPanelBase {

		private var _element : *;
		private var _canvas : Canvas;
		private var _receiver:*;
		public var tabLayout : ILayout;
		
		public function PropertiesTab(element:*, canvas:Canvas, rec:* ) {
			_element 	= element;
			_canvas	 	= canvas;
			_receiver 	= rec;	
			drawContnet();
		}
		
		private function drawContnet( ):void {
			
			//if(element){
				tabLayout = hlayout(
				"offsetX", 4,
				"offsetY", 8,
				"maxItemsPerRow", 2,
				"maxContentWidth", 150,
				"hGap", 8,
				"vGap", 4,
				
				headline("Properties", 150),
			
				label("Width:", -20),
				sliderWithLabel( {
						id: "widthSlider",
						width: 50,
						minValue: 50,
						maxValue: 800,
						value: element.w,
						snapInterval: 5,
						change: function( width : uint) : void {
							updateElement( "width", width );
						}
				}),

				label("Height:", -20),
				sliderWithLabel({
						width: 50,
						id: "heightSlider",
						minValue: 50,
						maxValue: 800,
						value: element.h,
						snapInterval: 5,
						change: function( height : uint) : void {
							updateElement( "height", height );
						}
						})
				
				);
				
				tabLayout.layout(this);
			//}
		}
		
	
	
		//============================= GETTERS/SETTERS  ===================================
		
		public function set element( trg:* ):void {
			_element = trg;
			updateSlider();
		}
		
		public function get element( ):* {
			return _element;
		}
		
		public function set canvas( trg:* ):void {
			_canvas = trg;
		}
		
		public function updateSlider( ):void {
			
			if(tabLayout){
	
				var box : Slider = Display(tabLayout.getLayoutItem("widthSlider")).displayObject as Slider;
				if (box.value != _element.w) {
					if(_element.w > 10 && _element.w < 600)
						box.value = _element.w;
				}
				
				box = Display(tabLayout.getLayoutItem("heightSlider")).displayObject as Slider;
				if (box.value != _element.h) {
					//trace(_element.h);
					if(_element.h > 10 && _element.h < 400)
						box.value = _element.h;
				}
		
				
			}
		}

		
		public function updateElement( property:String, val:Number ) : void {

			switch (property) {
				case "width":
					element.w = val;
				break;
				case "height":
					element.h = val;
				break;
			}
			_canvas.update();
			
			if (_receiver)
				_receiver.updateTransformSelection();
		
		}
		
		
	/*	public function openOptions(  ) : void {
			
			var ce:Element = element as Element;
			var ep:Object = ce.getEditableProperties();
			
			//traceObject(ep);
			
			var prop:String;
			for ( prop in ep) {
				if( prop in Attributes.DEFAULT_EDITABLE_PROPERTIES) {
					//trace("yes");
				}else {
					
				}
			}	
			
	
		
		}*/
	}

}