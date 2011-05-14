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
		protected var _node:Node;
		protected var _activeElements:Array;
	 
		protected var _initialized:Boolean = false;
		  
		public function CanvasControl( node:Node ) {
			
			//traceObject(node.properties);
			
			// Control Class holds only command interface
			
			super();
			
			_node = node;
			this.canvas = _node.properties;


		}
		public function set commands(commands:Object):void {
			trace("set commands");
			_commands = commands;
			attachActions(); 
		}
			
		public function addCanvas( canvasObject:Object ):Canvas {

			removeCanvas();

			var canvas:Canvas = new Canvas();
			canvas.addEventListener(SimpleEvent.SIMPLE_EVENT, mergeActiveElementsArrays );
			canvas.init( canvasObject );
			
			addChild(canvas);

			return canvas;
		}

			
		private function mergeActiveElementsArrays(e:SimpleEvent):void {
			_activeElements = arrConcatUnique(_activeElements,e.data)
			trace("! " + _activeElements.length);
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
		
		public function set canvas( canvasObj:Object ):void {
			_canvas = addCanvas( canvasObj);
			_activeElements = new Array();
			_initialized = true;
			trace("canvas set");
		}
		
		
		public function removeCanvas( canvas:Canvas = null):void {
			
			// REMOVE LISTNERS!!!
			if(canvas == null){
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
			}else {
				try { 
						canvas.removeElements();	
						removeChild( canvas );
						canvas = null;
									
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

