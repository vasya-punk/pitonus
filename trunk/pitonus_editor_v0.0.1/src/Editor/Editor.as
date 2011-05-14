package Editor
{

    import Configuration. * ;
    import flash.display. * ;
    import flash.events. * ;

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
        }

        override public function attachActions() : void {

            var elementsOnPage : Array = getActiveElementsRecursive(_canvas);

			//var a:Array = getActiveElementsRecursive(_canvas);
			
			//trace(a + " Total length: " + a.length);
			
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
            			Manager.testElement = _canvas.activeElements[0];

            var m : Node = new Node( "ElementPropertiesPanel" );
            m.properties = Config.PROPERTIES_PANEL_CANVAS_DATA

            _workspace = new Object();
            _workspace['properties'] = new PropertiesPanel( m );
            _workspace['properties'].reciver = this;
            _workspace['properties'].element = Manager.testElement;
  
            addChild( _workspace['properties'] ); 


        }
		
        public function selectElement( param : Element ) : void {
            trace( "  CanvasControl method executed. param: " + param );
			_workspace['properties'].element = param;
            update();
        }

		public function addElement( param : Object ) : void {
            trace( "  CanvasControl method executed. param: " + param );
			//_canvas.
			var node:Node = new Node("new Node");
			node.properties = param;
            _node.addNode( node );
			_node.properties['elements'].push(param);
			//_canvas.canvasObject['elements'].push(param);
			update();
        }
		
		public function removeElement( element : Element ) : void {
           /* trace( "  CanvasControl method executed. param: " + param );
			//_canvas.
			var node:Node = new Node("new Node");
			node.properties = param;
            _node.addNode( node );
			_node.properties['elements'].push(param);
			//_canvas.canvasObject['elements'].push(param);*/
			
			
			update();
        }

		
		
        public function update() : void {
            _activeElements = null;
            var defaultPageNode : Node = Manager.getDefaultPageData( Config.DEFAULT_PAGE_ID );
            if ( defaultPageNode ) {
                this.addCanvas( defaultPageNode.properties );
                // editor.drawUi();
            }
        }

        public function desturct() : void {
            /* this._currentPageInstance.removeElements();
            this.removePage( this._currentPageInstance ); */
            // removeChild( this._elementControl );
            // Listenrs should be removed too
        }

    }
}

//  ---------------------------------------