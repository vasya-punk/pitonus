package Utils 
{
	import flash.display.Shape;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.as3commons.ui.layout.constants.Align;
	
	import flash.geom.Matrix;
	
	import org.as3commons.ui.layout.HLayout;
    import org.as3commons.ui.layout.shortcut.* ;
    import org.as3commons.ui.layout.debugger.LayoutDebugger;
    import org.as3commons.ui.layout.HGroup;
    import org.as3commons.ui.layout.VGroup;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class UiWindow extends Sprite
	{
		private static const WINDOW_TITLEBAR_HEIGHT:Number = 16;	
		
		protected var _windowContainer:Sprite; 
		
		protected var _windowTitleBar:Sprite; 
		protected var _windowBody:Sprite; 
		
		protected var _windowIconClose:Sprite; 
		protected var _windowIconToggle:Sprite;
		
		protected var _windowContent:*;
		protected var _w:uint;
		protected var _h:uint;
		
		private var _minimized:Boolean = false;
		
		public function UiWindow( contnet:* = null, w:uint = 200, h:uint = 100, posx:uint = 0, posy:uint = 0 ) 
		{
			_windowContent = contnet;
			_w = w;
			_h = h;
			
			this.x = posx;
			this.y = posy;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			this.show();
		}
		
		public function show():void {
			
			addEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
			
			_windowTitleBar = new Sprite();
			_windowBody = new Sprite();
			
			_windowBody.addChild (drawWindowBody( _w, _h  ));	
			_windowTitleBar.addChild ( drawWindowTitleBar() );	
			
			_windowContainer = new Sprite();
			_windowContainer.addChild(_windowBody);
			_windowContainer.addChild(_windowTitleBar);
			addChild(_windowContainer);
			
			addListners();
			//trace(_windowTitleBar.hasEventListener(MouseEvent.MOUSE_DOWN ));	
			
		}
		
		//-- Listners -----------------------------------------------------------------------------------------------
		private function addListners():void { 
			
			_windowTitleBar.addEventListener(MouseEvent.MOUSE_DOWN, dragWindow, false, 0, true);
				
			_windowTitleBar.addEventListener(MouseEvent.MOUSE_UP, dropWindow, false, 0, true);
			_windowTitleBar.addEventListener(MouseEvent.MOUSE_OUT, dropWindow, false, 0, true);
			
			_windowIconClose.addEventListener(MouseEvent.MOUSE_DOWN, closeWindow, false, 0, true);
			_windowIconToggle.addEventListener(MouseEvent.MOUSE_DOWN, toggleWindow, false, 0, true);
			
		}
		private function removeListners():void { 
			_windowTitleBar.removeEventListener(MouseEvent.MOUSE_DOWN, dragWindow, false);
			_windowTitleBar.removeEventListener(MouseEvent.MOUSE_UP, dropWindow, false);
			_windowTitleBar.removeEventListener(MouseEvent.MOUSE_OUT, dropWindow, false);
			_windowIconClose.removeEventListener(MouseEvent.MOUSE_DOWN, closeWindow, false);
			_windowIconToggle.removeEventListener(MouseEvent.MOUSE_DOWN, toggleWindow, false);
			
		}
		
		private function cleanUp (event:Event = null):void {
			removeListners();
		}
		
		private function dragWindow (event:MouseEvent):void {
			_windowContainer.startDrag(false, new Rectangle(0,0,1000,500));
		}
		
		private function dropWindow (event:MouseEvent):void {
			_windowContainer.stopDrag();
		}
		
		private function closeWindow (event:MouseEvent):void {
			trace("closeWindow: " + _windowBody.visible);
			removeWindow();
			dispatchEvent( new SimpleEvent(SimpleEvent.SIMPLE_EVENT , "<Event> Window's contnets removed" ) );
		}
		
		private function toggleWindow (event:MouseEvent):void {
			trace("toggleWindow: " + _windowBody.visible);	
			_minimized = !_minimized ;
			redrawWindowTitleBar();
			if (_minimized)
				minimize();
			else
				maximize();
		}
		
		//-----------------------------------------------------------------------------------------------------------
		private function redrawWindowTitleBar():void {   
			removeListners();
			cleanDisplayChildren(_windowTitleBar);
			_windowTitleBar.addChild( drawWindowTitleBar() );
			addListners();
		}

		public function removeWindow():void {   
			removeListners();
			cleanDisplayChildren(_windowTitleBar);
			cleanDisplayChildren(_windowBody);
			cleanDisplayChildren(this);
		}
		
		private function drawWindowTitleBar():Sprite{   
			
			var _radius:Number = 3;
			//var _margin:Number = 15;
			var _width:Number = _w;
			var _height:Number =  WINDOW_TITLEBAR_HEIGHT;

			//Type of Gradient we will be using
			var fType:String = GradientType.LINEAR;
			//Colors of our gradient in the form of an array
			var colors:Array = [ 0x3e3e3e,  0x595959 ];
			//Store the Alpha Values in the form of an array
			var alphas:Array = [ 1, 1 ];
			//Array of color distribution ratios.  
			//The value defines percentage of the width where the color is sampled at 100%
			var ratios:Array = [ 0, 255 ];
			//Create a Matrix instance and assign the Gradient Box
			var matr:Matrix = new Matrix();
			matr.createGradientBox( 200, 17, toRad(-90) , 0, 0 );
			//SpreadMethod will define how the gradient is spread. Note!!! Flash uses CONSTANTS to represent String literals
			var sprMethod:String = SpreadMethod.REPEAT;
			//Start the Gradietn and pass our variables to it
			//var sprite:Sprite = new Sprite();
			//Save typing + increase performance through local reference to a Graphics object
			
			var shape:Shape = new Shape();
			
			var g:Graphics = shape.graphics;
			g.beginGradientFill( fType, colors, alphas, ratios, matr, sprMethod );
			g.lineStyle(1, 0x303030);
            g.drawRoundRectComplex( 0.5,  0.5,
                _width, _height,
                _radius, _radius,
                0, 0);
            g.endFill();
			
			
			
			var windowBar:Sprite = new Sprite();
			windowBar.addChild(shape);
			
			_windowIconClose = new IconWindowClose();
			_windowIconToggle = (_minimized) ? new IconWindowMaximize() : new IconWindowMinimize();
			//var _windowIconMaximize:Sprite = new IconWindowMaximize();
				
			var iconLayout:HGroup = new HGroup();
			iconLayout.minWidth = _w - 1;
			iconLayout.hAlign = Align.RIGHT;
			iconLayout.gap = 1;
			iconLayout.marginY = 1;

			//iconLayout.add(  _windowIconMaximize);
			iconLayout.add( _windowIconToggle);
			iconLayout.add( _windowIconClose );
			iconLayout.layout(windowBar);

			return windowBar;
			
			
		}
		
		private function drawWindowBody(  w:uint, h:uint ):Shape {   
			
			var shape:Shape = new Shape();
			var g:Graphics = shape.graphics;
//			g.beginFill(0xcacaca, 1);
			g.lineStyle(1, 0x303030);
            g.drawRect( 0, 0, w, h);
			
			g.beginFill(0xcacaca, 1);
			g.lineStyle(1, 0xE1E1E1);
            g.drawRect( 1, 0, w-2, h-1);
			
            g.endFill();
			shape.y = WINDOW_TITLEBAR_HEIGHT;
			return shape;
		}
		
		public function maximize(  ):void {   
			_windowBody.visible = true;
			_minimized = false;	
		}
		
		public function minimize(  ):void {  			
			_windowBody.visible = false;
			_minimized = true;
		}
		
/*		public function set minimized( state:Boolean ):void {   
			if ( state == true && _minimized == false)
				minimize();
			if ( state == false && _minimized == true)
				maximize();
			_minimized = state;
		}
		*/
		public function get minimized():Boolean {   
			return _minimized;
		}
		
		//-----------------------------------------------------------------------------------------------------------

		
	}

}