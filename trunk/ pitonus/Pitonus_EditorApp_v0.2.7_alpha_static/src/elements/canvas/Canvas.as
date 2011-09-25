package elements.canvas
{
    import com.sibirjak.asdpc.button.Button;
	import flash.geom.Rectangle;
	import org.as3commons.ui.layout.Display;
	import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.HLayout;
    import org.as3commons.ui.layout.shortcut.*;
    import org.as3commons.ui.layout.debugger.LayoutDebugger;
    import org.as3commons.ui.layout.HGroup;
    import org.as3commons.ui.layout.VGroup;
	
    import flash.display.*;
	import flash.display.Graphics;
    import flash.text.TextField;
    import flash.utils.getDefinitionByName;
    import flash.display.Sprite;

    import configuration. * ;
    import utils. * ;
	import data.*;
	import data.utils.*;
    import managers.* ;
	import elements.* ;
	import elements.utils.* ;
	import events.*;

    public class Canvas extends Element implements IElement
    {
		// Avivable Elements types 
		protected var _aviableElements		:Object;
		
        protected var _elements 		 	:Array;
		protected var _canvases	 			:Array;
       
		protected var _canvasLayout	 		:ILayout = null;
		
		// TODO Elements arrays in Canvas
		/*protected var _inlinePositionElements		:Array;
		protected var _absolutePositionElements		:Array;*/
	
		public function Canvas( node:DataNode) {
			super( node );
		}

		//============================= Element Override Methods ===================================
		
        override public function init() : void {
			
			var editableProperties:Object =  new Object();
			editableProperties["backgroundImage"] 	= Attributes.UPLOAD;
			editableProperties["layout"] 			= Attributes.LIST;
			setEditableProperties( editableProperties );	
			
			_aviableElements = DataManager.getAviableElementClasses();
        }
		
		override public function draw() : void {
			
			var debug:Boolean = false;
			if (Config.DEBUG && Config.DEBUG_LEVEL > 3) {
				debug = true;
			}
		
			if(debug) trace("\n[Canvas]0 draw()  " + layout + " - " +  id);
		
			
			_elements = new Array();
			_canvases = new Array();

			for each( var elementNode : DataNode  in _node.childNodes ){//['elements'] ) {
				
				var elType:String = elementNode.properties['elementType'];
				var elementTypeNum : int =  _aviableElements['names'].indexOf( elType );
				
				if ( elementTypeNum != - 1 ) {				
					var element : * = createElement( _aviableElements['runtimeClassRefs'][elementTypeNum], elementNode);

					if ( elType == 'Canvas' ) 	{
						_canvases.push(element);
						//trace("... Canvas found in Canvas" + element);
					}
					
					_elements.push(element);
					
				}
				
			}
			
			var mY:int;
			var mX:int;
			if( layout != Attributes.MARKUP_LAYOUT_ABSOLUTE ){

				switch ( layout ) {
					
					case Attributes.MARKUP_LAYOUT_INLINE_VERTICAL:
						canvasLayout = vlayout("maxContentHeight", h, "hGap" , 0, "vGap" , 0);
					break;
					
					default:
						layout = Attributes.MARKUP_LAYOUT_INLINE_HORIZONTAL;
					case Attributes.MARKUP_LAYOUT_INLINE_HORIZONTAL:
						canvasLayout = hlayout("maxContentWidth", w, "hGap" , 0, "vGap" , 0);
					break;
				}

				canvasLayout.marginY = marginY;
				canvasLayout.marginX = marginX;	

				var e:* = null;
					
				for each(e in _elements) {

				/*	
					mY =  ( e.marginY )  ? e.marginY : 0;
					mX =  ( e.marginX )  ? e.marginX : 0;

				*/	/*if ( e.getProperty('identifier') ) 
						canvasLayout.add( display( "id", e.identifier, e , "marginY" , e.marginY, "marginX" , e.marginX) );
					else*/

					canvasLayout.add( display(e , "marginY" , e.marginY , "marginX" , e.marginX));	
				}

				if ( Config.DEBUG && Config.DEBUG_LEVEL > 4 ) {
					var debugger : LayoutDebugger = new LayoutDebugger();
					addChild( debugger );
					debugger.debug( _canvasLayout );
				}
				
			}else {

				for each(e in _elements) {

					mY =  ( e.marginY )  ? e.marginY : 0;
					mX =  ( e.marginX )  ? e.marginX : 0;

					e.x = mX
					e.y = mY;
					addChild(e);

					this.x = marginX;
					this.y = marginY;
					
				}
			}
			
			
			if(debug) trace("[Canvas]1 draw() : " + id + " layout: " + layout + " " + elementType);
			
			
			if(  canvasLayout ){
				//drawSquare( this, _canvasLayout.visibleRect, 0.15 );
				this.w = canvasLayout.visibleRect.width;
				if(debug) trace("  --> visibleRect. " + _canvasLayout.visibleRect);
			}else {
				var rect:Rectangle = new Rectangle(0,0,w,h)
				if(debug) trace("  --> this. " + rect);
				//drawSquare( this,  rect, 0.15 );
			}
			
			updateLayout();
			
			//trace("[Canvas]2 draw() - finished. dispatchEvent");	
			// Let Control know when Canvas is ready, bubbles = true
			dispatchEvent( new CanvasEvent( CanvasEvent.ONDRAW, this ) );
			
        }
		
		public function updateLayout() : void {
			
			if(_canvasLayout){
				canvasLayout.layout( this );
				w = canvasLayout.visibleRect.width;
				h = canvasLayout.visibleRect.height;
			}else {
				
			}
			//trace("             [TODO] Canvas. Not only liquid layouts should be updated");
			//trace("Canvas: " + this.id + " " + layout + " " + w + "x"+ h);
			
		}
		
		override public function update() : void {
			updateLayout();
		}
		
		public function reDraw() : void {
			removeElements();
			draw();
		}
				
		
		//========================== GETTER/SETTER ====================================================================
		
		/*
			override public function get w() : uint {
           //drawSquare( this, _canvasLayout.visibleRect, 0.15 );
			if( layout != Attributes.MARKUP_LAYOUT_ABSOLUTE ){	
				return canvasLayout.visibleRect.width;
			}else{
				return node.properties[];
			}
        }
		
		override public function get h() : uint {
            if( layout != Attributes.MARKUP_LAYOUT_ABSOLUTE ){	
				canvasLayout.visibleRect.height;
			}else{
				return canvas.h;
			}
        }*/
		
        public function get elements() : Array {
            return _elements;
        }

		public function get canvases() : Array {
            return _canvases;
        }
	
		public function get canvasLayout() : * {
            return _canvasLayout;
        }
		
		public function set canvasLayout(value:*) : void {
            _canvasLayout = value;
        }
		
		public function set backgroundImage( val:* ):void {
			setProperty( "backgroundImage", String(val) );
		}
		
			
		public function get backgroundImage():String {
			return String( this.getProperty('backgroundImage') );
		}
		
		
		public function get layout() : * {
            return String( this.getProperty('layout'));
        }
		
		public function set layout( val:* ):void {
			setProperty( "layout", String(val) );
		}
		
		
		//========================== Utils ====================================================================
		
		public function selectElementByIdentifier( identifier:String ) : * {
			for each( var element:Element in _elements) {
				if (element.getProperty('identifier')) {
					
					if (element.getProperty('identifier') == identifier)
						return element;
					
				}
			}
			return null;
        }
		
		public function selectElementById( identifier:String ) : * {
			for each( var element:Element in _elements) {
				if (element.id) {
					
					if (element.id == identifier)
						return element;
				}
			}
			return null;
        }
		
		public function removeElements() : void {
			
			var i:uint;
			
			for ( i = 0; i < _elements.length ; i++ ) {		
				LifeCycleManager.unregisterComponent( _elements[i] );
				this.removeChild( 	_elements[i] );	
			}
			
			for ( i = 0; i < this.numChildren ; i++ ) {
				// TODO CleanUp inner canvases properly
				this.removeChild( this.getChildAt(i));		
			}	
			
			_elements = null;

        }
		
		override public function getMinimalProperties():Object {
			var minimalProperties:Object =  new Object();
			minimalProperties["layout"] = Attributes.INPUT;
			return minimalProperties;
		}

    }

}