package Elements
{
    import com.sibirjak.asdpc.button.Button;
	import org.as3commons.ui.layout.Display;
	import org.as3commons.ui.layout.HLayout;
    import org.as3commons.ui.layout.shortcut. * ;
    import org.as3commons.ui.layout.debugger.LayoutDebugger;
    import org.as3commons.ui.layout.HGroup;
    import org.as3commons.ui.layout.VGroup;


    import flash.display. * ;
	import flash.display.Graphics;
    import flash.text.TextField;
    import flash.utils.getDefinitionByName;
    import flash.display.Sprite;

    import Configuration. * ;
    import Utils. * ;
    import Managers. * ;

    public class Canvas extends Element implements IElement
    {
   	
		protected var _aviableElements		:Object;

        protected var _elements 		 	: Array;
        protected var _activeElements	 	: Array;
		protected var _canvases	 			: Array;
        protected var _canvasLayout	 		: VGroup;

        protected var _foreground 	 		: Sprite;
        protected var _background 			: Sprite;

        private var initialized : Boolean = false;

		public function Canvas( node:Node) {	
			super( node );
		}

        override public function init() : void {
		

			_aviableElements = Manager.getSiteElementClasses();

            var editableProperties : Object =  new Object();
            // properties["pageId"] 	 	 = Attributes.NUMBER;
            //editableProperties["name"] 	 		 = Attributes.INPUT
            editableProperties["elementType"] 	 = Attributes.INPUT
            //editableProperties["elements"] 	 	 = Attributes.SYSTEM;

            if( validateProperties( editableProperties ) ){
				_foreground = new Sprite();
				_background = new Sprite();
				this.addChild( _background );
				this.addChild( _foreground );
				initialized = true;

				setPosition();
				//addBounds();
				draw();
			}else {
					trace("missed properties");
			}
        }
		
/*		public function addElementTo(elementData:Node , identifier:String ) : void {
            //var n:Node = new Node("addElementToCanvas");
			var element:Element = selectElementByIdentifier(identifier);
			element.node.addNode(elementData);
			draw();
        }*/
		
        public function get elements() : Array {
            return _elements;
        }
		public function get canvases() : Array {
            return _canvases;
        }

        public function get activeElements() : Array {
            return _activeElements;
        }
		
		public function selectElementByIdentifier( identifier:String ) : * {
			for each( var element:Element in _elements) {
				if (element.getProperty('identifier') == identifier)
					return element;
				else
					return null;
			}
        }

        private function draw(  ) : void {

			
            if ( initialized ) {
				
				//trace("drawing canvas " + _node);
				
                // new array to hold references to Elements instatnces on Page
                _elements = new Array();
                _activeElements = new Array();
				_canvases = new Array();

                var elementObjects : Array = new Array();
				
                for each( var elementNode : Node in _node.childNodes ){//['elements'] ) {
					
         			var elementType:String = elementNode.properties['elementType'];
					
                    var elementTypeNum : int =  _aviableElements['names'].indexOf( elementType );
                    if ( elementTypeNum != - 1 ) {
						
						/*var r:Number = randomRange(10,20);
						elementObj['w'] = String(   int(elementObj['w']) + r  - 15 );*/
						
                        var element : * = createElement( _aviableElements['runtimeClassRefs'][elementTypeNum], elementNode );

						_elements.push(element);
						
						if ( elementType == 'Canvas' ){
							_canvases.push(element);
						}
						
						
                        if ( element.isProperty( "action" ) ) {
							_activeElements.push( element );
						}
						
						_foreground.addChild( element );
						

                    }

                    //elementObjects.push( elementObj );
                }


				_canvasLayout = vgroup();

				var hl:HLayout = hlayout("maxContentWidth", uint( getProperty( "w" ) ) , "marginX", 10, "marginY", 10, "hGap" , 10, "vGap" , 10);
		
				for each(var e:* in _elements) {
					if ( e.getProperty('identifier') ) {
						//trace("identifier found: "  + e.getProperty('identifier'));
						hl.add( display("id", e.getProperty('identifier'), e ,  "marginY", 5) );
					}else{
						hl.add(  e );
					}
				}

				_canvasLayout.add(hl);

                _canvasLayout.layout( this );
				
				  
				  drawSquare(this, _canvasLayout.visibleRect);



                if ( Config.DEBUG && Config.DEBUG_LEVEL > 4 ) {
                    var debugger : LayoutDebugger = new LayoutDebugger();
                    addChild( debugger );
                    debugger.debug( _canvasLayout );
                }
            
			}
			
        }



        public function get foreground() : * {
            return _foreground;
        }
        public function get background() : * {
            return _background;
        }
		
/*		public function get canvasObject() : Object {
            return _canvasObject;
        }*/
		
		public function get canvasLayout() : VGroup {
            return _canvasLayout;
        }
		
        public function removeElements() : void {
			
			if ( elements.length) {
				
				//trace( "Canvas.removeElements() _foreground: " + _foreground.numChildren);
				for (var i:uint = 0; i < _foreground.numChildren ; i++ ) {
					_foreground.removeChild(elements[i]);		
				}
				
				//trace( "Canvas.removeElements() _background: " + _background.numChildren);
				for (var i:uint = 0; i < _background.numChildren ; i++ ) {
					_background.removeChild(elements[i]);		
				}
				//trace("inside Canvas::removeElements() " + _node.properties['elementType'] );
				_elements = null;
				_canvasLayout = null;
				
			}

        }
    }

}