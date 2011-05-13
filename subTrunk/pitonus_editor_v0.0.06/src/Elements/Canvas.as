package Elements
{
    import com.sibirjak.asdpc.button.Button;
    import org.as3commons.ui.layout.HLayout;
    import org.as3commons.ui.layout.shortcut. * ;
    import org.as3commons.ui.layout.debugger.LayoutDebugger;
    import org.as3commons.ui.layout.HGroup;
    import org.as3commons.ui.layout.VGroup;

    import flash.display. * ;
    import flash.text.TextField;
    import flash.utils.getDefinitionByName;
    import flash.display.Sprite;

    import Configuration. * ;
    import Utils. * ;
    import Managers. * ;

    public class Canvas extends Element implements IElement
    {
        protected var _canvasObject 	 : Object;
        protected var _elements 		 : Array;
        protected var _activeElements	 : Array;
        protected var _canvasLayout	 : VGroup;

        protected var _foreground 	 : Sprite;
        protected var _background 	 : Sprite;

        private var initialized : Boolean = false;


        override public function init( obj : Object ) : void {

            _properties = obj;


            var properties : Object =  new Object();
            // properties["pageId"] 	 	 = Attributes.NUMBER;
            properties["name"] 	 		 = Attributes.INPUT
            properties["elementType"] 	 = Attributes.INPUT
            properties["elements"] 	 	 = Attributes.SYSTEM;

            // if( validateProperties( properties ) ){

            _canvasObject = obj;
            _foreground = new Sprite();
            _background = new Sprite();
            this.addChild( _background );
            this.addChild( _foreground );
            initialized = true;

            setPosition();
            addBounds();
            draw( _properties );
        }

        public function get elements() : Array {
            return _elements;
        }

        public function get activeElements() : Array {
            return _activeElements;
        }


        public function draw( obj : Object ) : void {


            if ( initialized ) {
                // new array to hold references to Elements instatnces on Page
                _elements = new Array();
                _activeElements = new Array();


                // PAGE NAME HERE

                /* var tf : TextField = createTextField( this.getProperty( 'name' ), 20, true );

                var bounds : Sprite = new drawSquareBox(  tf.width , tf.height , 0xFF0000, 0.1 );
                bounds.mouseEnabled = false;
                bounds.addChild( tf );

                _foreground.addChild( bounds );

                _elements.push( bounds ); */

                // Objects containing data for elements initialization
                var elementObjects : Array = new Array();
                for each( var elementObj : * in _canvasObject['elements'] ){

                    // list of classNames of aviable elements in application
                    var aviableElements : Object = Manager.getSiteElementClasses();

                    // if ( elementObj['elementType'] != "Canvas" ){
                    trace( " .. drawing element" );
                    // check if element exist is aviable elements array
                    var elementTypeNum : int =  aviableElements['names'].indexOf( elementObj['elementType'] );
                    if ( elementTypeNum != - 1 ) {
                        // if()
                        var element : * = createElement( aviableElements['runtimeClassRefs'][elementTypeNum], elementObj );

                        _foreground.addChild( element );

                        // array of phisical sprites ( dispalay list )
                        var curElementTypeArray : Array = ( element.isProperty( "action" ) ) ? _activeElements : _elements;
                        curElementTypeArray.push( element );

                    }

                    // 	}

                    // array of objects, reference of whole site tree
                    elementObjects.push( elementObj );
                }




                _canvasLayout = vgroup();
                /* "marginX", 10, "marginY", 10,
                hgroup( "marginX", 0, "marginY", 0,
                tf
                ), */

                _canvasLayout.add( 		hlayout(
                "maxContentWidth", uint( getProperty( "w" ) ) , "marginX", 10, "marginY", 10, "hGap" , 10, "vGap" , 10,
                _elements, _activeElements
                ) );


                _canvasLayout.layout( this );


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
        public function removeElements() : void {
            trace( "::: REMOVING: " );
            for ( var i : uint = 0; i < _background.numChildren;
            i ++ ){
                _background.removeChild( _background.getChildAt( i ) );
            }
            for ( var i : uint = 0; i < _foreground.numChildren; i ++ ){
                _foreground.removeChild( _foreground.getChildAt( i ) );
            }
            _elements = null;
            _activeElements = null;
            /* for each( var element : Element in _elements ) {
            trace( "!!! [Error] Element is not dele" + element + " : " + element.getProperty( 'elementType' ) );
            // this.removeChild( element );
            } */

        }
    }

}