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
			
			_commands =  Manager.getCommands();
			_activeElements = new Array();
			_node = node;
			this.addCanvas(_node.properties);


		}

			
		public function addCanvas( canvasObject:Object ):void {
			if(_canvas)
				removeCanvas();

			var canvas:Canvas = new Canvas();
			//canvas.addEventListener(SimpleEvent.SIMPLE_EVENT, mergeActiveElementsArrays );
			canvas.init( canvasObject );

			addChild(canvas);

			_canvas = canvas;
			
			attachActions();
		}

			
		private function mergeActiveElementsArrays(e:SimpleEvent):void {
			_activeElements = arrConcatUnique(_activeElements, e.data);
			try{
				trace("mergeActiveElementsArrays(): " + _activeElements.length + " " + e.data.length);
			}catch (e) {
					trace(e);
			}
		}
		
		public function attachActions():void {
			//trace("attachActions()");
			
			var elementsOnPage : Array = getActiveElementsRecursive(_canvas);
			
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
			
			_initialized = true;
		}
		
		// CANVAS  -  GETTER / SETTER
		public function get canvas():* {
			return _canvas;	
		}
		
		public function removeActions():void {
			var elementsOnPage:Array = _canvas.activeElements;
			var nSlot:uint = 0;
			for each( var element:* in elementsOnPage) {
				this.removeButton(element);
			}
		}
		
		public function removeCanvas( canvas:Canvas = null):void {
			
			// REMOVE LISTNERS!!!
			if(canvas == null){
				if(_canvas){
					try { 
						removeActions();
						_canvas.removeElements();	
						removeChild( _canvas );
						_canvas = null;
									
					} catch (e:Error) {
						if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
							trace("Error deleting page, or page not exist... " + e);
					}
				}
				_initialized = false;
			}else {
				try { 
						removeActions();
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

