package managers.utils 
{
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;
	import com.sibirjak.asdpc.treeview.TreeView;
	import data.DataNode;
	import flash.display.Sprite;
	import flash.events.Event;

	import com.sibirjak.asdpc.treeview.TreeNodeEvent;
    import com.sibirjak.asdpc.treeview.TreeView;
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
    import org.as3commons.collections.framework.IRecursiveIterator;
    import org.as3commons.collections.iterators.RecursiveIterator;
    import flash.display.Sprite;
	import events.*;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class TraceNode extends Sprite
	{
		private var _treeView:*; 
		private var _dataSource:*
		
		
		// DEBUG
		private var _debug:Boolean = false;
		public function get debug():Boolean {return _debug;}
		public function set debug(value:Boolean):void { _debug = value; }
		
		public function TraceNode(dataSource:*) {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				debug = true;
				
			_dataSource = dataSource;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			/*var background : BackgroundSkin = new BackgroundSkin();
			background.setSize( 200, 300);
			addChild(background);*/
			
			_treeView = new TreeView();
			_treeView.setSize(200, 230);
			_treeView.moveTo(0, 30);
			_treeView.setStyles([TreeView.style.showRoot, false]);
			
			/*_treeView.setStyles([
				// item size
				TreeView.style.itemSize, 25,

				// scrollbar and button visibility
				TreeView.style.scrollBarVisibility, Visibility.VISIBLE,
				ScrollBar.style.scrollButtonVisibility, Visibility.VISIBLE,

				// box shaped disclosure button
				DisclosureButton.style_expandedIconSkin, DisclosureButtonBoxIconSkin,
				DisclosureButton.style_collapsedIconSkin, DisclosureButtonBoxIconSkin,
				DisclosureButton.style_size, 9,
				DisclosureButtonBoxIconSkin.style_fillColor, 0x000000,
				DisclosureButtonBoxIconSkin.style_iconColor, 0xFFFFFF,

				// connectors below button and icon
				ConnectorContainer.style_connectorAtButton, true,
				ConnectorContainer.style_connectorAtIcon, true,

				// list item indent
				TreeNodeRenderer.style.indent, 26,

				// list item colors
				TreeNodeRenderer.style.separator, true,
				TreeNodeRenderer.style.separatorColor, 0xDDDDDD,
				TreeNodeRenderer.style.evenIndexBackgroundColors, [0xFFFFFF, 0xEEEEEE],
				TreeNodeRenderer.style.oddIndexBackgroundColors, [0xFFFFFF, 0xEEEEEE],
				TreeNodeRenderer.style.overBackgroundColors, [0xDDDDDD, 0xBBBBBB],
				TreeNodeRenderer.style.selectedBackgroundColors, [0x666666, 0x999999],
			]); */
		  
			_treeView.dataSource = _dataSource;
		       
            _treeView.addEventListener( TreeNodeEvent.SELECTION_CHANGED, selectHandler );
			addChild(_treeView);

		}
		
		public function update(src:*, node:DataNode = null):void {
			_treeView.dataSource = src;
			if (node){
				selectNode(node);
				TreeView(_treeView).expandNodeAt(1);
			}
		}
		
		 public function selectNode( node  : DataNode ):void {

           _treeView.expandNodeAt( 0, true );

			
			var requestedNode : DataNode = node;

			var iterator : IRecursiveIterator = new RecursiveIterator( _treeView.dataSource );
			var item : DataNode;

			
			var i:uint = 0;
			while ( iterator.hasNext() ) {
				item = iterator.next();
				
				try {
					//trace(requestedNode + " | " + item + " | " + i);
					if ( requestedNode == item ) {
						_treeView.selectItemAt( i );
						if(debug)	trace( "[i][e] TraceNode - Found Node" +  " | " + item + " id: " + item.id );
					}
				}
				catch ( e : Error ) {
					trace( "[Error] " + e );
				}
				i++;
			}
			
        }
		
		
		private function selectHandler( e : TreeNodeEvent ) : void {

                if ( e.selected ) {
                   
                    // traceObject( event.item.properties, event.item );
					dispatchEvent( new SimpleEvent(SimpleEvent.SIMPLE_EVENT , e.item as DataNode ) );
                }
                else {
                    trace( "No item selected" );
                }
        }
	}

}