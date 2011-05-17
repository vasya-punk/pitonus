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
    
		public function PropertiesPanel(  rec:*, rootNode : Node, panelData:Object) {
			
			_panelData = panelData;
			_reciver = rec;
			_rootNode = rootNode;
			
			_node  =   parseTreeRecursive( _panelData );
			_node.properties = _panelData;

			super(_node);
			
	
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
			
			_currentElement = element;

			// Select canvas for insert element
			var attributesCanvas:Canvas = selectElementOnCanvas("ATTRIBUTES_PANEL")
			var n:Node = attributesCanvas.node;
			
			// remove existing elements in Attributes Panel
			n.properties['elements'] = new Array();
	
			var properties : Object = element.getEditableProperties();
			var elementPropObject : Object ;

            var i : uint = 0;
            for ( var property : String in properties ) {
      
                switch ( properties[ property ] ){
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
				// A
				n.properties['elements'].push(elementPropObject);
			}
			_node  =   parseTreeRecursive( _panelData );
			addCanvas(_node);
		
		}
		
		
	}
}
		


 		
		


