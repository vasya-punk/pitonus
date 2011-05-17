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
			
			_commands =  Manager.getCommands();
			_activeElements = new Array();
			
			this.addCanvas( _node );

		}
		
		public function addElement( elementObject:Object ):void{

			// Select canvas for insert element
			//var attributesCanvas:Canvas = _canvas;// selectElementOnCanvas("ATTRIBUTES_PANEL")
			//var n:Node = attributesCanvas.node;
			
			// remove existing elements in Attributes Panel
			//n.properties['elements'] = new Array();
	
			//var properties :Array = element.getProperties();
			//var elementObject:Object = new Object();

/*			elementObject["elementType"] = "InputProperty";
			elementObject["label"] = "property";
			elementObject["value"] = "value";
			elementObject["w"] = "150";
			elementObject["h"] = "25";
*/
			// Add element to elements
			
			//traceObject( elementObject);
			
			var n:Node = new Node("NewElement");
			
			n.properties = elementObject;

			_canvas.node.properties['elements'].push(elementObject);
			
			//trace("::: " + n + " " + _node);
			
			// update Canvas Node, from updated Node properties 
			_node.addNode(n);//  =   parseTreeRecursive( _node.properties );
			
			update();
		
		}
		

		
		public function selectElementOnCanvas( identifier:String ):*{
			return _canvas.selectElementByIdentifier(identifier);
		}
			
		public function addCanvas( node:Node ):void {
			//trace("       CanvasControl::addCanvas() " + node.properties['elementType']);
			
			if(_canvas)
				removeCanvas();

			var canvas:Canvas = new Canvas( node );
			addChild(canvas);
			_canvas = canvas;
			
			//_canvas.addEventListener(SimpleEvent.SIMPLE_EVENT, mergeActiveElementsArrays );
			
			attachActions();
		}


		public function attachActions():void {
			//trace("attachActions()");
					
			var elementsOnPage : Array = getActiveElementsRecursive( _canvas );
			var nSlot:uint = 0;
			var runtimeClassRef:Class;
			var command:*;
			for each( var element:* in elementsOnPage) {
				
				for ( var position:uint = 0;  position < _commands['names'].length; position++ ) {
					//trace("_commands['names'][position] " + _commands['names'][position] + " : " + element.getProperty("action"));
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
		
		public function update() : void {
            this.addCanvas( _node );
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

