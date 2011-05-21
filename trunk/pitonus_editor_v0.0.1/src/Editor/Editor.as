package Editor
{

    import Configuration. * ;
    import flash.display. * ;
    import flash.events. * ;
    import org.as3commons.collections.framework.IRecursiveIterator;
    import org.as3commons.collections.iterators.RecursiveIterator;

    import Commands. * ;
    import Elements. * ;
    import Controls. * ;
    import Utils. * ;
    import Managers. * ;


    public class Editor extends CanvasControl {

        protected var _selectedElement : *;
        protected var _workspace : Object;

        public function Editor ( node : DataNode  ) {
            super( node );
            _commands =  Manager.getCommands();
			drawUi();
        }

        override public function attachActions() : void {

					
            var elementsOnPage : Array = getActiveElementsRecursive( _canvas );

            var nSlot : uint = 0;
            var runtimeClassRef : Class;
            var command : * ;
            for each( var element : * in elementsOnPage ) {

                var position : uint = 3;

                runtimeClassRef = _commands['runtimeClassRefs'][position];

                command = new runtimeClassRef( this,  element );

                this.setButton( nSlot,  element as ActiveElement );
                this.setCommand( nSlot, command );

                nSlot ++ ;

            }

			
        }
		public function updateNavigationPanel() : void {	

			_workspace['navigation'].updateTree();
			_workspace['navigation'].updatePages();
			//_workspace['navigation'].selectElement(_node.childNodes[_node.numItems - 1]);
			
		}
			
		public function addNewPage() : void {	
			Manager.addPage();
			gotoPageId(Manager.getNumPages() - 1);
			updateNavigationPanel();
		}
		
        public function drawUi() : void {

        _workspace = new Object();

        // Should be replaced by Class Workspace
		_workspace['properties'] = new PropertiesPanel( this, _node  );
        
		// _workspace['properties'].element = Manager.testElement;
        addChild( _workspace['properties'] );

		
        _workspace['navigation'] = new NavigationPanel( this, _node  );
        addChild( _workspace['navigation'] );

        _workspace['navigation'].addEventListener( SimpleEvent.SIMPLE_EVENT, selectNodeInEditor );
		
		
		

    }

		
    
    private function selectNodeInEditor( e : SimpleEvent ) : void {
        //trace( "	Editor: selectNodeInEditor() Event recived - Node to select: " + e.data );

        e.stopPropagation();

        var selectedNode : DataNode = e.data;

		var element : Element = findElementRecursive( _canvas, selectedNode );
        if( element ){
			selectElement( element );
        }else {
			trace( "Element not found in current Canvas!" );
		}
		
    }

    // Called by Command
    public function selectElement( param : Element ) : void {

        trace( "Editor: selectElement: " + param );
		
		if(_selectedElement)
			tint(_selectedElement, false);
		tint(param);
		
		//trace( " ----------> " + param.node );
        _workspace['navigation'].selectElement( param.node );
		_workspace['properties'].element = param;
		_selectedElement = param;

    }
	
	public function gotoPageId(id:uint):void {
		
		_node = Manager.getPageNode(id);
		addCanvas(_node);
		
		_selectedElement = null;
		Manager.selectedPageId = id;
		updateNavigationPanel();
	}
	
    public function addNewElement( obj : Object ) : void {
		
			var elementPropObject : Object = new Object();
            elementPropObject["elementType"] = "ActiveImage";
            elementPropObject["caption"] = "property";
            elementPropObject["src"] = "stamPic.jpg",
            elementPropObject["w"] = "150";
            elementPropObject["h"] = "155";
			elementPropObject["action"] = "DefaultCommand",
            elementPropObject["actionParam"] = "Hi",
			
            _node.addNodeFromObject(elementPropObject);

			updateNavigationPanel(  );
			
			drawCanvas( _node );
			
			selectElement(findElementRecursive( _canvas, _node.childNodes[_node.numItems - 1] ));
    }
    /*
    public function removeElement( element : Element ) : void {

    _node.properties['elements'].splice( _node.numItems - 1, 1 );
    _node.removeNodeAt( _node.numItems - 1 );
    update();
    }
    */



}



}

