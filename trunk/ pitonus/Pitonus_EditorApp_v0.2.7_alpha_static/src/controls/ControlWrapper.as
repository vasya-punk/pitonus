package controls 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
		
	import commands.*;
	import elements.*;
	import elements.canvas.*;
	import com.adobe.serialization.json.*;
	import utils.*;
	import data.*;
	import data.utils.*;
	import managers.*;
	import events.*;
	
	public class ControlWrapper  extends Sprite
	{
		
		
		protected var _data:DataNode;
		protected var _commands:Object;
		protected var _rec:*;
		protected var _drec:*;

		protected var _currnetPageId:uint = 0;
		protected var _pages:Array;
		protected var _designData:DataNode;
		
		
		protected var _canvas:Canvas;
		protected var _design:DesignControl;
		protected var _control:Control;
		
		private var _initialized:Boolean = false;
		
		public function ControlWrapper( data:DataNode, commands:Object, rec:* , drec:* = null) {
			
			if(data){
				
				
				_data		= data;
				_commands	= commands;
				_rec		= rec ;
				_drec 		= (drec) ? drec : _rec;
				
				if (stage) init();
				else addEventListener(Event.ADDED_TO_STAGE, init);
			}else {
				trace("[ERROR] ControlWrapper. Empty dataNode!");
			}
		}
		
		
		private function init(e:Event = null):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			if (!_rec)
				_rec = this;
				
			setStructure();
		}
		
		public function setStructure():void {
			_pages = _data.childNodes;
			for (var i:int = 0; i <  _data.childNodes.length; i++) {
							
				if (toBoolean(_data.childNodes[i].properties['defaultPage'])){
					_currnetPageId = i;
				}
					
			}
			if(_data.design)
				_designData = _data.design;
				
			tuneUp();
			drawPage();
		}
		
		//prepairMenuData();	
		protected function tuneUp():void { 
			
		}
		
		public function drawDesign():void {
			if(_designData){
				_design = new DesignControl( _designData, _commands, _drec);
				// dispatchEvent(new ControlEvent( ControlEvent.CONTROL_ACTIONS_ATTACHED, canvas)); from Control
				_design.addEventListener(ControlEvent.MENU_CLICK, onMenuClick);
				addChild(design);
			}
		}
		

		
		public function onMenuClick( e:ControlEvent):void {
			//DataManager.transformTool.deselect();
			var id:uint =  uint(e.data);
			trace( "[a] ControlWrapper - onMenuClick: " + id + " - reDrawingPage");
			if ( id > _pages.length - 1 )
				id = _pages.length - 1;
			_currnetPageId = id;	
			
			drawPage();
			
		}
		
		public function drawPage():void {
			//traceObject(_pages[_currnetPageId].properties);
			
			
			destroy();
			destroyDesign();

			drawDesign();
			_control = new Control( _pages[_currnetPageId], _commands, _rec);
			_control.addEventListener( ControlEvent.CONTROL_ACTIONS_ATTACHED, onCanvasReady )
			addChild(_control);
		}
		
		public function onCanvasReady(e:ControlEvent):void {
					
			for each (var item1:* in canvas.canvases) {
				//trace(" ... warapper canvases" + item1 + " " + item1.id);
			}
			for each (var item2:* in canvas.elements) {
				//trace(" ... warapper elements" +item2);
			}

			canvas.update();
			
			//_control.removeEventListener( ControlEvent.CONTROL_ACTIONS_ATTACHED, onCanvasReady );
			if (_initialized){
				dispatchEvent( new ControlEvent( ControlEvent.PAGE_CHANGED, this ));
			}else {
				_initialized = true;
				dispatchEvent( new ControlEvent( ControlEvent.CONTROL_READY, this ));
			}
		}

		public function nextPage():void {
			if(_currnetPageId < _pages.length - 1)
				_currnetPageId++;
			drawPage();
		}
		
		public function previousPage ():void { 
			if(_currnetPageId > 0)
				_currnetPageId--;
			drawPage();
		}
		
		public function gotoPage (id:uint):void { 

			if(DataManager.transformTool)
				DataManager.transformTool.deselect();
			if( id > _pages.length - 1)
				id = _pages.length - 1;
			_currnetPageId = id;
			drawPage();
		}
		
		
		public function get size():Rectangle {
			//trace("get size x: " + _control.canvas.w +  " - " + design.canvas.w );
			//trace("get size y: " + _control.canvas.h +  " - " + design.canvas.h );
			var wx:uint = _control.canvas.w;// (_control.canvas.w > design.canvas.w)? _control.canvas.w : design.canvas.w;
			var hy:uint = _control.canvas.h//(_control.canvas.h > design.canvas.h)? _control.canvas.h : design.canvas.h;
			
			return new Rectangle(0,0,wx,hy);
		}
		
		
		public function get canvas():Canvas {
			return _control.canvas;
		}
		
		public function get design():DesignControl{
			return _design;
		}
		
		public function get pages():Array {
			return _pages;
		}
		
		public function destroy():void {
			if (_control) {
				if (_control.stage) {
					_control.addEventListener( ControlEvent.CONTROL_ACTIONS_ATTACHED, onCanvasReady );
					_control.removeCanvas();
					removeChild(_control);
					_control = null;
				}
			}
		}	
		
		public function destroyDesign():void {
			if(_design){
				if (_design.stage) {
					_design.removeEventListener(ControlEvent.MENU_CLICK, onMenuClick);
					_design.removeCanvas();
					removeChild(_design);
					_design = null;
				}
			}
		}	
	
	}

}