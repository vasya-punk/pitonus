package {
    import org.as3commons.collections.framework.IRecursiveIterator;
    import org.as3commons.collections.iterators.RecursiveIterator;
    import flash.display.Sprite;

    import Elements. * ;
    import Controls. *
    import Utils. *
    import Utils.Communication. * ;
    import Utils.Console. *
    import Managers. * ;

    import Editor. * ;
    import com.sibirjak.asdpc.treeview. * ;
    import org.as3commons.collections. * ;
    import org.as3commons.collections.framework. * ;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import com.adobe.serialization.json. * ;



    public class test3 extends Sprite {
        private var dataBridge : 					JSBridge;
        private var obj : Object;
        // private var _i : uint = 0;
        public function test3() {
            dataBridge = new JSBridge();
            dataBridge.addEventListener( JSBridgeEvent.STRUCTURE_RECIEVED, processData );
            function processData( e : JSBridgeEvent ) : void {
                var str : String = e.data;
                obj = JSON.decode( str );
            }

            var s : String = '{"siteName":"Pitonus Demo","age":"0.25","pages":[{"pageId":"0","x":"5","y":"5","w":"600","h":"300","elementType":"Canvas","name":"homepage","elements":[{"name":"ElementProperties","elements":[{"elementType":"InputProperty","label":"First","value":"Default1","w":"150","h":"25"},{"elementType":"InputProperty","label":"Second","value":"Default2","w":"150","h":"25"}],"elementType":"Canvas","w":"200","h":"150","x":"50","y":"220"},{"elementType":"ActiveImage","caption":"First day","src":"stamPic.jpg","action":"DefaultCommand","actionParam":"Hi","w":"200","h":"150","x":"100","y":"100"},{"elementType":"ActiveImage","caption":"Another day","src":"stamPic2.jpg","action":"DefaultCommand","actionParam":"gl hf","w":"200","h":"150","x":"300","y":"100"}]},{"pageId":"1","x":"5","y":"5","w":"600","h":"300","elementType":"Canvas","name":"contacts"}  ]}';
			
            // var s : String = '{"siteName":"Pitonus Demo","age":"0.25","pages":[{"pageId":"0","x":"5","y":"5","w":"600","h":"300","elementType":"Canvas","name":"homepage","elements":[{"elementType":"Canvas","name":"ElementProperties","w":"200","h":"150","x":"50","y":"220","elements":[{"elementType":"InputProperty","label":"First","value":"Default1","w":"150","h":"25"},{"elementType":"InputProperty","label":"Second","value":"Default2","w":"150","h":"25"},{"elementType":"Canvas","w":"200","h":"150","x":"50","y":"220","name":"StamProperties","elements":[{"elementType":"InputProperty","label":"Second","value":"Default2","w":"150","h":"25"}]}]},{"elementType":"ActiveImage","caption":"First day","src":"stamPic.jpg","action":"DefaultCommand","actionParam":"Hi","w":"200","h":"150","x":"100","y":"100"},{"elementType":"ActiveImage","caption":"Another day","src":"stamPic2.jpg","action":"DefaultCommand","actionParam":"gl hf","w":"200","h":"150","x":"300","y":"100"},{"elementType":"ActiveImage","caption":"3 days","src":"stamPic.jpg","action":"DefaultCommand","actionParam":"Bad to Bone","w":"100","h":"150","x":"400","y":"150"}]}]}';
            // var s : String = '{"siteName":"Pitonus Demo","age":"0.25","elementType":"Root","pages":[{"pageId":"0","x":"5","y":"5","w":"600","h":"300","elementType":"Canvas","name":"homepage","elements":[{"elementType":"ActiveImage","caption":"First day","src":"stamPic.jpg","action":"DefaultCommand","actionParam":"Hi","w":"200","h":"150","x":"100","y":"100"},{"elementType":"ActiveImage","caption":"Another day","src":"stamPic2.jpg","action":"DefaultCommand","actionParam":"gl hf","w":"200","h":"150","x":"300","y":"100"}]},{"pageId":"0","x":"5","y":"5","w":"600","h":"300","elementType":"Canvas","name":"homepage","elements":[{"elementType":"ActiveImage","caption":"First day","src":"stamPic.jpg","action":"DefaultCommand","actionParam":"Hi","w":"200","h":"150","x":"100","y":"100"}]}]}';

            dataBridge.pitLoad( s );

            var root : Node =   parseTreeRecursive( obj )
            root.properties = ( obj );


            trace( "\n ****** RecursiveIterator ******\n\nRoot" );
            traceObject( root.properties );

            var iterator : IRecursiveIterator = new RecursiveIterator( root );
            var item : Node;

            var canvases : uint = 0;

            while ( iterator.hasNext() ) {
                item = iterator.next();
                try {
                    if ( item.canvas ){
						canvases ++
					}
					
					trace( "\n\n\n." + prefix( iterator.depth )
                    + " | " + iterator.depth
                    + "  > " + item + " Element: " + item.canvas );
                    traceObject( item.properties );

                }
                catch ( e : Error ) {
                    trace( "[Error] " + e );
                }
            }


            trace( "\n\ntotal canvas found: " + canvases );
	/*		
			var iterator2:RecursiveIterator = new RecursiveIterator( root );
            var item2:Node = new Node();
			*/
			trace("\n\n");
			
			/*while ( iterator2.hasNext() ) {
                item2 = iterator2.next();
                try {
					trace(item2.properties);
					if (item2.properties['pages'])
						trace("::::::::::::: " + item2.properties['pages'].length);
					trace("  > " +  );
                  

                }
                catch ( e : Error ) {
                    trace( "[Error] " + e );
                }
            }*/

			trace(root.properties['pages'] + " " + root.properties['pages'].length); 

			
            var treeView : TreeView = new TreeView();
            treeView.dataSource = root;
            addChild( treeView );
			
			treeView.addEventListener(TreeNodeEvent.SELECTION_CHANGED, selectHandler);

				
				
				function selectHandler(event : TreeNodeEvent) : void {
					
					if (event.selected) {

						traceObject(event.item.properties, event.item);
					/*		trace(" .. selected " + event.item['pageId'] + " " + event.item['elementType']);
							if (event.item['pageId']){
								Manager.CURRENT_VIEW.drawPage(uint(event.item['pageId']));
								Manager.setPageWrapper();
								var wrapper:Wrapper = Manager.CURRENT_WRAPPER;
								wrapper.setMode(Wrapper.EDIT_MODE);
								DrawTrace.showTrace("\nclick on Page. Editing PAGES mode - pageID: " +  uint(event.item['pageId']));
							}else {
								if(event.parentItem is ArrayList ){
									DrawTrace.showTrace("\nclick on Template. Editing DESIGN mode: ");
									Manager.setDesignWrapper();
									var wrapper:Wrapper = Manager.CURRENT_WRAPPER;
									wrapper.setMode(Wrapper.EDIT_MODE);
								}else {
									if (event.parentItem['pageId']) {
										DrawTrace.showTrace("\nclickOn element type: " + event.item['elementType']  + "\nEditing PAGES mode - pageID: " +  event.parentItem['pageId']);
										Manager.CURRENT_VIEW.drawPage(uint(event.parentItem['pageId']));
										var wrapper:Wrapper = Manager.CURRENT_WRAPPER;
										wrapper.setMode(Wrapper.EDIT_MODE); }
									else {
										DrawTrace.showTrace("\nclickOn element.\nEditing DESIGN mode");
										Manager.setDesignWrapper();
										var wrapper:Wrapper = Manager.CURRENT_WRAPPER;
										wrapper.setMode(Wrapper.EDIT_MODE);
									}
								}
							}*/
					} else {
						trace( "No item selected");
					}
				}
				


        }


    }
}