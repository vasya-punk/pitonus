package Elements
{

	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import org.as3commons.ui.layout.HGroup;
	import org.as3commons.ui.layout.VGroup;

	import org.as3commons.ui.layout.HLayout;
	import org.as3commons.ui.layout.shortcut.* ;
	
	
	import flash.display.*;
	import flash.events.*;
		
	import Commands.*;
	import Elements.*;

	import Utils.*;
	import Managers.*;
	
	public class CanvasLayout extends Sprite{
		

		protected var _canvas:Canvas;
	 	protected var _canvasLayout	: VGroup;
   
		protected var _initialized:Boolean = false;
		  
		public function CanvasLayout( obj:Object = null ) {
		
			super();
			
			if (obj){
				this.canvas = obj;
				addCanvas(obj)
			}
		}

		public function addCanvas( canvasObject:Object ):void {

			removeCanvas();

			var canvas:Canvas = new Canvas();
			canvas.init( canvasObject );
			
			addChild(canvas);
		
			_canvas = canvas;
			
			_initialized = true;
		}

		// CANVAS  -  GETTER / SETTER
		public function get canvas():* {
			return _canvas;	
		}
		

		
		private function setLayout():void{
				/*var layout : HGroup = new HGroup();
				layout.addAll(_canvas.foreground);
				layout.layout(_canvas);*/
			_canvasLayout = vgroup();
									/*"marginX", 10,"marginY", 10,
									hgroup("marginX", 0, "marginY", 0,
										tf
									),*/
			
			_canvasLayout.add(						hlayout(
										"maxContentWidth", uint(_canvas.getProperty("w")) , "marginX", 10, "marginY", 10, "hGap" , 10, "vGap" , 10,
										_canvas.elements, _canvas.activeElements
									));
								
								
			_canvasLayout.layout( this );
			
			
			if ( Config.DEBUG && Config.DEBUG_LEVEL > 4 ) {
					var debugger : LayoutDebugger = new LayoutDebugger();
					addChild( debugger );
					debugger.debug( _canvasLayout );
                }
		}
		public function removeCanvas():void {
			
			// REMOVE LISTNERS!!!
			
			if(_canvas){
				try { 
					_canvas.removeElements();	
					removeChild( _canvas );
					_canvas = null;
								
				} catch (e:Error) {
					if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
						trace("Error deleting page, or page not exist... " + e);
				}
			}
		}


	}
}

