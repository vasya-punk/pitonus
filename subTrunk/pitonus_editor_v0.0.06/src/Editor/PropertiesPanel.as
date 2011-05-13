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
	import Controls.*;

    public class  PropertiesPanel extends Panel 
    {
     	private var _attributesCanvas:	Canvas;
		private var _currentElement : 	ActiveElement;
		private var _canvasObject:		Object;
        
		public function PropertiesPanel( obj:Object = null ) {
			super(obj);
        }

		public function updateElementProperties():void {
				trace("  PropertiesPanel method executed. " );
				this.cleanPanel();
				this.element = Manager.testElement;
	
		}
		
		public function set element( element : ActiveElement ) : void {
            
			
			if (_currentElement )
				cleanPanel();
			_currentElement = element;
			
			
			var attributesCanvasObject:Object = new Object();
			attributesCanvasObject['elementType'] = "Canvas";
			attributesCanvasObject['name'] = 'Element Properties';
			attributesCanvasObject['w'] = '180';
			attributesCanvasObject['h'] = '250';
			attributesCanvasObject['elements'] = buildAttributes( _currentElement );
			attributesCanvasObject['x']  	= "25";
			attributesCanvasObject['y'] 	= "0";


			_canvasObject['elements'].push(attributesCanvasObject);

			this.canvas = _canvasObject;
		}

		
		private function buildAttributes( element : ActiveElement ) : Array {

            var attributeElements = new Array();

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
                        //trace( " current property: " + property + " " + properties[property] + " : " + element.getProperty( property ) );
                        elementPropObject = new Object();
						elementPropObject["elementType"] = "InputProperty";
						elementPropObject["label"] = property;
                        elementPropObject["value"] = element.getProperty( property );
						elementPropObject["w"] = "150";
						elementPropObject["h"] = "25";
                        break;

                }
				attributeElements.push(elementPropObject);
                i++ ;
            }
			return attributeElements;
        }
		
        public function get element() : ActiveElement {
            return _currentElement;
        }
		
		override public function set canvas( cObject:Object ):void {
			
			_canvasObject = cObject;
			_canvas = addCanvas( _canvasObject );
			attachActions();
			_initialized = true;
			
			// Yberi menia otsuda
			
	
		}
		

		 public function cleanPanel() : void {
			/*if(_canvas)
				this.removeCanvas();
			*/
			if(_attributesCanvas){
				_attributesCanvas.removeElements();
				removeChild(_attributesCanvas);
			}
			
            /*for ( var i : uint = 0; i < _attributes.length ; i ++ ) {
                this.removeChild( _attributes[i] );
            }
            for ( i = 0; i < _activeElements.length ; i ++ ) {
                this.removeChild( _activeElements[i] );
            }*/
        }
		
     /*  override public function init( obj:Object ):void {
			
			_properties = obj;
			
            var properties : Object =  new Object();
   
            if( this.validateProperties( properties ) ){
                _pageObject = obj;
                _foreground = new Sprite();
                _background = new Sprite();
                this.addChild( _background );
                this.addChild( _foreground );
            }
        }
		



		
		  

        public function getActiveElements() : Array{
            return _activeElements;
        }

     

      

        public function getObjectFromInput() : Object {
        var obj : Object = new Object();
			for ( var property : String in _attributes ) {
				
				//trace( " : " + item + " " + _currentElementObject[item] + " " + _currentElementObject[item].getValue() );
				obj[property] = _attributes[property].getValue();
			}
			return obj;
        }

        public function updateElement() : void {
			var obj : Object = this.getObjectFromInput();
			_currentElement.update( obj );
        } 
    */
	}


}
/*			traceObject(attributesCanvasObject, "dynamic");
			traceObject({ "name":"Element Properties", "elements":[ { "elementType":"InputProperty", "label":"First", "value":"Default1", "w":"150", "h":"25" }, { "elementType":"InputProperty", "label":"Second", "value":"Default2", "w":"150", "h":"25" } ], "canvasType":"ElementProperties"}, "static");*/
	