package Editor
{

    import com.greensock.easing.Strong;
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

    public class  NavigationPanel extends CanvasControl
    {      
		
        private var _reciver :*;
		private var _rootNode:Node;
		private var _treeView:Tree;
		private var p:uint = 0;
		
        public function NavigationPanel(  rec:*, rootNode : DataNode ) {

			// Control Class holds only command interface
			
			_reciver 	= rec;
			_rootNode 	= rootNode;

			super(parseTreeRecursive( Config.NAVIGATION_PANEL_DATA , new Array()));
		
		
			
			var attributesCanvas:Canvas = selectElementOnCanvas("NAVIGATION_PAGES");
			//attributesCanvas.node.removeNodes();
			for (var i:uint = 0; i < Manager.getNumPages()  ; i++ ) {
				addNewPageLabel	( attributesCanvas, new Object );
			}
			drawCanvas(_node);
			
			_treeView = selectElementOnCanvas("NAVIGATION_TREE");
       }
		

		
		public function gotoPage(id:uint):void {
			_reciver.gotoPageId(id);
		}
		
		public function addNewPage():void {
			_reciver.addNewPage();
		}
		
		public function updatePages():void {
			
			var attributesCanvas:Canvas = selectElementOnCanvas("NAVIGATION_PAGES");
			attributesCanvas.node.removeNodes();
			
			for (var i:uint = 0; i < Manager.getNumPages()  ; i++ ) {
				addNewPageLabel	( attributesCanvas, new Object );
			}
			drawCanvas(_node);
			
			_treeView = selectElementOnCanvas("NAVIGATION_TREE")
		
		}
		public function updateTree():void {
			_treeView.update(null);
			p = 0;
			//removeCanvas();
			//addCanvas(parseTreeRecursive( Config.NAVIGATION_PANEL_DATA, new Array()) );
		}

		
		public function addNewElement(element:*):void {
			_reciver.addNewElement(element);
		}
		
		public function selectElement( node : DataNode ):void {
			_treeView.selectNode(node);
		}

		public function addNewPageLabel( canvas:Canvas, obj : Object ) : void {
			
			obj["elementType"] =  "Button";
			obj["caption"] =   "Page";
			obj["action"] =   "GotoToPageId";
			obj["actionParam"] =  String(p) ;
			obj["w"] =   "95";
			obj["h"] =   "22";
			p++;
			canvas.node.addNodeFromObject(obj);

		}
    }
}