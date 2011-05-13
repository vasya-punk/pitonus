package Controls
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
	
	public class CanvasControl extends Control {
		
		protected var _commands:Object;
		protected var _canvas:Canvas;
	 	protected var _canvasLayout	: VGroup;
   
		protected var _initialized:Boolean = false;
		  
		public function CanvasControl( obj:Object = null ) {
			_commands = Manager.getCommands( );
			super();
			
			if (obj)
				this.canvas = obj;
		}

		public function addCanvas( canvasObject:Object ):Canvas {

			removeCanvas();

			var canvas:Canvas = new Canvas();
			canvas.init( canvasObject );
			
			addChild(canvas);

			return canvas;
		}

			
		public function attachActions():void {
			
			var elementsOnPage:Array = _canvas.activeElements;
			
			var nSlot:uint = 0;
			var runtimeClassRef:Class;
			var command:*;
			for each( var element:* in elementsOnPage) {
				
				for ( var position:uint = 0;  position < _commands['names'].length; position++ ) {
					
					if ( _commands['names'][position] == element.getProperty("action")) {
						
							runtimeClassRef = _commands['runtimeClassRefs'][position];
							if (element.getProperty("actionParam"))
								command = new runtimeClassRef( this, element.getProperty("actionParam") );
							else
								command = new runtimeClassRef( this );		// Pass this as reciver for command execute

							this.setButton(nSlot,  element as ActiveElement);
							this.setCommand(nSlot, command );
							
							nSlot++;
						
					}
					
				}
				
			}
		}
		
		// CANVAS  -  GETTER / SETTER
		public function get canvas():* {
			return _canvas;	
		}
		
		public function set canvas( canvasObject:Object ):void {
			
			_canvas = addCanvas( canvasObject );
			
			setLayout();
			
			attachActions();
			
			_initialized = true;
			
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
		
		public function execute( param:String = ""):void {
			trace("  CanvasControl method executed. param: " + param);
		}

	}
}

