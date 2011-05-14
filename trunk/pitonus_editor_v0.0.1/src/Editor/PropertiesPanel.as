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

	import org.as3commons.ui.layout.Display;
	import org.as3commons.ui.layout.HLayout;
    import org.as3commons.ui.layout.shortcut. * ;
    import org.as3commons.ui.layout.debugger.LayoutDebugger;
    import org.as3commons.ui.layout.HGroup;
    import org.as3commons.ui.layout.VGroup;
	
    public class  PropertiesPanel extends Panel 
    {
		
		// canvas for element properties controls
     	private var _attributesCanvas:					Canvas;
		
		// store attributes canvas Object to get properties back onUpdate
		private var _attributesCanvasObject:		Object;
		
		// reference to element, needed when updating element properties
		private var _currentElement : 					ActiveElement;
		


		public function PropertiesPanel( node:Node ) {
			//trace("       ........ " + node.properties['elements'][0]['elementType']);
			_attributesCanvasObject = node.properties['elements'][0]['elementType'];
			super(node);
        }

		public function updateElementProperties():void {
				trace("  PropertiesPanel method executed. " );
				this.element = Manager.testElement;
				
		}
		
		public function set element( element : ActiveElement ) : void {         
			trace("       ........ " + _canvas.elements[0]);
		/*	
				_currentElement = element; 
		
			_attributesCanvasObject = new Object();	
			_attributesCanvasObject['elementType'] = "Canvas";
			_attributesCanvasObject['name'] = 'Element Properties';
			_attributesCanvasObject['identifier'] = 'ELEMENT_PROPERTIES_CANVAS';
			_attributesCanvasObject['w'] = '180';
			_attributesCanvasObject['h'] = '250';
			_attributesCanvasObject['elements'] = buildAttributes( _currentElement );
			_attributesCanvasObject['x']  	= "25";
			_attributesCanvasObject['y'] 	= "0";
			
			// doesn't works with layouts!!!
			//_attributesCanvas.removeElements();
			
			if (_canvas.canvasObject['elements'].length > 1)
				_canvas.canvasObject['elements'].pop();
			_canvas.canvasObject['elements'].push(_attributesCanvasObject);
			this.canvas = _canvas.canvasObject;*/
			//attachActions(); 
		}

		private function removeAttributesCanvasElement() : void { 
			trace("!!!! " );
			var canvasLayout = _canvas.canvasLayout;
			var d : Display = canvasLayout.getLayoutItem("ELEMENT_PROPERTIES_CANVAS") as Display;
				
			if (d) { 
				var canvas:Canvas = d.displayObject as Canvas;
				canvas.width -= 0.25;
				canvasLayout.remove(canvas);
				trace("!!!! remove"+canvas.width);
			}


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
	