package controls
{

	import flash.display.*;
	import flash.events.*;
		
	import commands.*;
	import elements.*;
	import elements.canvas.*;

	import utils.*;
	import events.*;
	import data.*;
	import data.utils.*;
	import managers.*;
	
	public class Control extends LifeCycleable {
		
		private var _commandList:Array;
		private var _buttonList:Array;
		
		protected var _selectedElement:*;	//TODO : Current selected element in Control
		protected var _canvas:*;
	
				
		protected var _commands:Object;
		protected var _canvasesList:Array;
		protected var _node:DataNode;
	    protected var _receiver :  * = null;	
		
		public 	var _activeElements:Array;
		private var _ic:uint = 0;
		private var _tic:uint = 0;
			  
		public function Control( node:DataNode , commands:Object, rec:* = null ) {
			
			if(node != null){
					
				_commandList = new Array();
				_buttonList = new Array();
				_canvasesList = new Array();
				_commands = commands;

				
				_node = node;
				_tic = getInnerCanvasesRecursive(node);

				_receiver = (rec) ? rec : this;
				//trace( "Control.constructor - rec: " + _receiver + " ic: "  +_tic);
				super(); 
				
			}else {
				trace("[Error] Control: Node is 'null'")
			}
			
		}
		
		//============================= Override functions  ===================================
		
		// initial preparations, called by LifeCycle before Element was added to display list
		//override public function init():void {validateNow();}

		// called by LifeCycle after Element propety was changed by _lcAdapter.invalidate(); called
		override public function update() : void {
			trace ( "Control.update() ... doing nothing");
		}
		
		// called by LifeCycle after init() by _lcAdapter.validateNow(); called
		override public function draw() : void {
	
			_canvas = new Canvas( _node );			
			_canvas.addEventListener(  CanvasEvent.ONDRAW, onCanvasDraw );
			addChild( _canvas );
			
		}

		
		//================================ Control ============================================
		
		private function setCommand(nSlot:int, c:ICommand):void {
			try{
				_commandList[nSlot] = c;
			}catch (e:Error) { trace('[Error] setCommand: Setting command'); }
		}
		
		private function setButton(nSlot:int, trg:ActiveElement):void {
			//trace(nSlot +  " : " + trg + " " + (trg is ActiveElement) + " " + trg.clickTarget);
			try {
				trg.addClickTarget();
				trg.clickTarget.addEventListener( MouseEvent.CLICK, buttonClicked, false, 0, true);
				_buttonList[nSlot] = trg;
			}catch (e:Error) { trace('[Error] setButton: Attaching listner'); }
	
		}
		
		private function removeButton( trg:* ):void {	
			if(trg){
				if(trg.clickTarget){
					trg.clickTarget.removeEventListener( MouseEvent.CLICK, this.buttonClicked);
				}else {
					trace("removeButton:trg.clickTarget - undefined");	
				}
			}else {
				trace("removeButton:trg - undefined");
				
			}
		}
		
		private function buttonClicked(e:Event):void {
			
			for (var i:int = 0; i < _buttonList.length; i++) {
				if (_buttonList[i].clickTarget === e.target) {
					_selectedElement = i;
					_commandList[i].execute();
					break;
				}
			}
		}
		
		//=============================================================================================


		public function onCanvasDraw(e:CanvasEvent):void { 
			_ic++;
			
			if (_ic > _tic) { 
				//trace("Control.onCanvasDraw() - attaching actions.. " + e.data.id + " ic: " + _ic);
				attachActions();
			}
			
			/*if(  canvasLayout ){
				drawSquare( this, _canvasLayout.visibleRect, 0.15 );
				this.w = canvasLayout.visibleRect.width;
				trace("  --> visibleRect. " + _canvasLayout.visibleRect);
			}else {
				var rect:Rectangle = new Rectangle(0,0,w,h)
				trace("  --> this. " + rect);
				drawSquare( this,  rect, 0.15 );
			}*/
			
			
			
			// TODO not to dispatch every inner Canvas draw
			
		}
		
		
		private function attachActions():void {
						
			
			
			var elementsOnPage : Array = getActiveElementsRecursive( _canvas as Canvas );
			if (elementsOnPage.length > 0 ){
			
				_activeElements = new Array();
					
				try {
		
					var nSlot:uint = 0;
					var runtimeClassRef:Class;
					var command:*;
					for each( var element:* in elementsOnPage) {
						
						// TODO optimal loops number in commands assign
						for ( var position:uint = 0;  position < _commands['names'].length; position++ ) {
							
							if ( _commands['names'][position] == element.getProperty("action") ) {
									
									element.addClickTarget();	

									//trace(element.getProperty("action") + " : " + element.getProperty("actionParam"));
									runtimeClassRef = _commands['runtimeClassRefs'][position];
									if (element.getProperty("actionParam")) {
										command = new runtimeClassRef( _receiver, element.getProperty("actionParam") );
									}else {
										// Pass this as reciver for command execute
										command = new runtimeClassRef( _receiver );		
									}
									

									
									this.setButton(nSlot,  element as ActiveElement);
									this.setCommand(nSlot, command );
									
									nSlot++;
									
									_activeElements.push(element);
							}		
						}
					}
					
				}catch (error:Error) {
					trace("[Attach Actions in Control Failed] - " + error);
				}
			}
			
			//trace("Control dispatchEvent > ACTIONS_ATTACHED id:" + canvas.id);
			dispatchEvent(new ControlEvent( ControlEvent.CONTROL_ACTIONS_ATTACHED, canvas));
			
		}

		
		public function removeActions():void {
			var elementsOnPage:Array = _activeElements;
			var nSlot:uint = 0;
			for each( var element:* in elementsOnPage) {
				if( element.clickTarget )
					removeButton(element);
			}
		}
		
		
		
		public function removeCanvas():void {
			
			if(_canvas){
				try { 
					
					_canvas.removeEventListener(  CanvasEvent.ONDRAW, onCanvasDraw );	
					removeActions();
					_canvas.removeElements();	
					this.removeChild( _canvas );
					
					_canvas = null;
					_canvasesList = new Array();
					
				} catch (e:Error) {
					if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
						trace("Error deleting page, or page not exist... " + e);
				}
			}
			
		}
		
		public function execute( param:String = ""):void {
			trace("[i] Control.execute() : " + param);
		}
		
		//============================= Control GETTERS/SETTERS  ===================================
	
		public function get canvas():Canvas{
			return _canvas;
		}
		
		
		public function get node():DataNode{
			return _node;
		}
		
		public function set canvas(c:Canvas):void {
			
			if (c == null) 
				removeCanvas();

			_canvas = c;
		}
		
		
		
	}
}

