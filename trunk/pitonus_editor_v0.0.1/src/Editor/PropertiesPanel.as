package Editor
{

    import com.greensock.easing.Strong;
	import com.greensock.layout.AlignMode;
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

    public class  PropertiesPanel extends CanvasControl
    {      
        // store attributes canvas Object to get properties back onUpdate
 
        // reference to element, needed when updating element properties
        private var _currentElement : 					Element;
		private var _currentElementPropertiesNode: 		Node;
		private var _panelData:Object;
		private var _rootNode:Node;
		
       private var _reciver :  * ;
    
		public function PropertiesPanel(  rec:*, rootNode : Node) {

			_reciver = rec;
			_rootNode = rootNode;

			super(parseTreeRecursive( Config.PROPERTIES_PANEL_CANVAS_DATA , new Array()));
			
	
		}

       public function updateElementProperties() : void {
           
			var attributesCanvas:Canvas = selectElementOnCanvas("ATTRIBUTES_PANEL");
			
			for (  var i : uint = 0; i < attributesCanvas.elements.length; i++ ) {
				var input:InputProperty = attributesCanvas.elements[i] as InputProperty;
				_currentElement.setProperty( input.getProperty('label'), input.getValue() );
			}
			_reciver.update();
         }
		
		public function set element( element : * ):void{

			trace("PropertiesPanel: " + element);
			
			var attributesCanvas:Canvas = selectElementOnCanvas("ATTRIBUTES_PANEL");
			attributesCanvas.node.removeNodes();
			
			_currentElement = element;
	
			var properties : Object = element.getEditableProperties();
			var elementPropObject : Object ;

            var i : uint = 0;
			var elementPropObject : Object;
            for ( var property : String in properties ) {
      
                switch ( properties[ property ] ){
                    default :
                    case Attributes.INPUT :
						//trace("element properties: " +i);
						elementPropObject  = new Object();
						elementPropObject["label"] = property;
                        elementPropObject["value"] = element.getProperty( property );
						addNewElementProperty(attributesCanvas, elementPropObject);
                        break;
                }
				i++;
			}
			

			drawCanvas( _node );
		}
		
		public function addNewElementProperty( canvas:Canvas, obj : Object ) : void {
			
                        obj["elementType"] = "InputProperty";
                        obj["w"] = "150";
                        obj["h"] = "25";
	
			
			canvas.node.addNodeFromObject(obj);

		}
		
	}
}
		


 		
		


