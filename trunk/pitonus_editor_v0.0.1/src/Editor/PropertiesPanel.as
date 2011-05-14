package Editor
{

    import com.greensock.easing.Strong;
    import fl.controls.ComboBox;
    import flash.display.DisplayObject;
    import flash.events.Event;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFieldAutoSize;

    import com.sibirjak.asdpcbeta.selectbox.SelectBox;
    import com.sibirjak.asdpc.listview.ListItemEvent;


    import Utils. * ;
    import Managers. * ;
    import Elements. * ;
    import Configuration. * ;
    import Controls. * ;

    import org.as3commons.ui.layout.Display;
    import org.as3commons.ui.layout.HLayout;
    import org.as3commons.ui.layout.shortcut. * ;
    import org.as3commons.ui.layout.debugger.LayoutDebugger;
    import org.as3commons.ui.layout.HGroup;
    import org.as3commons.ui.layout.VGroup;

    public class  PropertiesPanel extends Panel
    {      
        // store attributes canvas Object to get properties back onUpdate
        private var _attributesElements : 				Array;

        // reference to element, needed when updating element properties
        private var _currentElement : 					ActiveElement;

        private var _reciver : 					 * ;

        public function PropertiesPanel( node : Node ) {
            super( node );
        }

        public function updateElementProperties() : void {
            trace( "  PropertiesPanel method executed. " );

			for (  var i : uint = 0; i < _canvas.canvases[0].elements.length; i++ ) {
				var input:InputProperty = _canvas.canvases[0].elements[i] as InputProperty;
				//trace("xyi" + input + input.getValue() + input.getProperty('label') );
				_currentElement.setProperty( input.getProperty('label'), input.getValue() );
			}
			_reciver.update();
            //this.element = Manager.testElement;
        }

        public function set reciver( rec : * ) : void{
            _reciver = rec;
        }

		public function removeElement():void {
			if (_reciver) {
				
				_reciver.removeElement(_currentElement);
			}
		}
		
		public function addElement(obj:Object):void {		
			if (_reciver) {
				//traceObject(obj);
				_reciver.addElement(obj);
			}
		}
		
		private function getAttributes( ) : Object{
			var attributeElements:Object = new Object();
           /* for (  var i : uint = 0; i < _canvas.canvases[0].elements.length; i++ ) {
				var prop:InputProperty = _canvas.canvases[0].elements[i] as InputProperty;
				//attributeElements[prop.getProperty('label')][prop.getValue()];
				_currentElement.setProperty( prop.getProperty('label'), prop.getValue() );
            }*/
           return attributeElements;
        }
		
        public function set element( element : ActiveElement ) : void {
         
			_currentElement = element;
			var _attributesCanvasObject : 		Object;
            _attributesCanvasObject = new Object();
            _attributesCanvasObject['elementType'] 	= "Canvas";
            _attributesCanvasObject['name'] 		= 'Element Properties';
            _attributesCanvasObject['identifier'] 	= 'ELEMENT_PROPERTIES_CANVAS';
            _attributesCanvasObject['w'] 			= '180';
            _attributesCanvasObject['h'] 			= '250';
            _attributesCanvasObject['elements'] 	= buildAttributes( _currentElement );
            _attributesCanvasObject['x']  	 		= "25";
            _attributesCanvasObject['y'] 	 		= "0";

            if ( _canvas.canvasObject['elements'].length > 3 )
				_canvas.canvasObject['elements'].pop();
				
            _canvas.canvasObject['elements'].push( _attributesCanvasObject );
            addCanvas(_canvas.canvasObject); 

        }

        private function removeAttributesCanvasElement() : void {
            trace( "!!!! " );
            var canvasLayout = _canvas.canvasLayout;
            var d : Display = canvasLayout.getLayoutItem( "ELEMENT_PROPERTIES_CANVAS" ) as Display;

            if ( d ) {
                var canvas : Canvas = d.displayObject as Canvas;
                canvas.width -= 0.25;
                canvasLayout.remove( canvas );
                trace( "!!!! remove" + canvas.width );
            }


        }

        private function buildAttributes( element : ActiveElement ) : Array {

            _attributesElements = new Array();

            var properties : Object = element.getEditableProperties();

            // temp variables
            var elementPropObject : Object ;
            var propType : String;

            var i : uint = 0;
            for ( var property : String in properties ) {
                propType = properties[ property ];
                switch ( propType ){
                    default :
                    case Attributes.INPUT :
                        elementPropObject = new Object();
                        elementPropObject["elementType"] = "InputProperty";
                        elementPropObject["label"] = property;
                        elementPropObject["value"] = element.getProperty( property );
                        elementPropObject["w"] = "150";
                        elementPropObject["h"] = "25";
                        break;

                }
                _attributesElements.push( elementPropObject );
                i ++ ;
            }
            return _attributesElements;
        }

    }
}