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

        protected var _currentElement : ActiveElement;
        protected var _workspace : Object;

        public function Editor ( node : Node  ) {
            super( node );
            _commands =  Manager.getCommands();
			            drawUi();
        }

        override public function attachActions() : void {




            var elementsOnPage : Array = getActiveElementsRecursive( _canvas );

            // var a : Array = getActiveElementsRecursive( _canvas );

            // trace( a + " Total length: " + a.length );

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

        public function drawUi() : void {
           _workspace = new Object();
		   
			// Should be replaced by Class Workspace


            _workspace['properties'] = new PropertiesPanel( this, _node ,Config.PROPERTIES_PANEL_CANVAS_DATA );
            //_workspace['properties'].element = Manager.testElement;
            addChild( _workspace['properties'] );

            _workspace['navigation'] = new NavigationPanel( this, _node , Config.NAVIGATION_PANEL_DATA );
            addChild( _workspace['navigation'] );


            _workspace['navigation'].addEventListener( SimpleEvent.SIMPLE_EVENT, selectNodeInEditor );


			

        }
        private function selectNodeInEditor( e : SimpleEvent ) : void {
            trace( "navigation Event recived - Node to select: " + e.data );
			
			e.stopPropagation();
			
			var selectedNode:Node = e.data;
			
			//var totalElements : Array = getElementsRecursive( _canvas );
			var element : Element = findElementRecursive( _canvas, selectedNode );
			if(element )
				selectElement(element);
			else
				trace("NotFound!!!");
			
		/*	var requestedNode:Node = e.data;
			
            var iterator : IRecursiveIterator = new RecursiveIterator( _node );
            var item : Node;

			
			
			
            while ( iterator.hasNext() ) {
                item = iterator.next();
                try {
                  
                    // traceObject( item.properties );
					if (requestedNode == item) {
						//selectElement();
						trace( "Node found! " +  prefix( iterator.depth )
                    + " | " + iterator.depth
                    + "  > " + item + " Element: " + item.properties['elementType'] );
					}
                }
                catch ( e : Error ) {
                    trace( "[Error] " + e );
                }
            }*/
        }

		// Called by Command
        public function selectElement( param : Element ) : void {
           // trace( "  Editor method executed. param: " + param );

            var tree : Tree = _workspace['navigation'].selectElementOnCanvas( 'NAVIGATION_TREE' ) ;
            tree.selectNode( param.node );
		
			_workspace['properties'].element = param;
			
        }

       public function addNewElement( obj : Object ) : void {
            

       
			
			addElement(obj);
			_workspace['navigation'].update();
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

//  ---------------------------------------