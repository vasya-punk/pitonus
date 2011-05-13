package Controls
{

	
	
	
	import flash.display.*;
	import flash.events.*;
		
	import Commands.*;
	import Elements.*;

	import Utils.*;
	import Managers.*;
	
	public class CanvasControl extends Control {
		
		protected var _commands:Object;
		protected var _canvas:Canvas;
	 
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
			
			
			attachActions();
			
			_initialized = true;
			
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

