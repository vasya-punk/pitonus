package ui.tabs {

	import com.sibirjak.asdpcbeta.slider.Slider
	import elements.Element;
	import org.as3commons.ui.layout.Display;
	import org.as3commons.ui.layout.HLayout;
	import elements.canvas.Canvas;
	import ui.*;

	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import org.as3commons.ui.layout.framework.ILayout;

	import flash.display.Sprite;
	import utils.*;
	
	/**
	 * @author Jens Struwe 29.03.2011
	 */
	public class GenericTab extends ControlPanelBase {
		
		protected var _element : *;
		protected var _canvas : Canvas;
		
		private var _receiver:*;
		
		public var tabLayout : ILayout;

		public function GenericTab( targetElement:*, targetCanvas:Canvas, receiver:* ) {
			element = targetElement;
			canvas = targetCanvas;
			_receiver = receiver;
		}
		
	
		
		public function updateSlider( ):void {
			try { 
				if(_element.w < 10000){
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
			catch (err:Error){
				trace("GenericTab.updateSlider() + " + err);	
			}
		}

		
		protected function updateElement( property:String, val:Number ) : void {
			// TODO : val < 10000
			if(val < 10000){
				switch (property) {
					case "width":
						_element.w = val;
					break;
					case "height":
						_element.h = val;
					break;
				}
				_canvas.update();
				
				if (_receiver)
					_receiver.updateTransformSelection();
			}
		}
		
		//============================= GETTERS/SETTERS  ===================================
		
		public function set element( trg:* ):void {
			_element = trg;
			updateSlider();
		}
		
		public function set canvas( trg:* ):void {
			_canvas = trg;
		}
		
	}
}
