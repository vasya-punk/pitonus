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
		
        private var _reciver : * ;
		private var _rootNode:Node;
		
        public function NavigationPanel(  rec:*, rootNode : Node, panelData:Object) {
			
			// Control Class holds only command interface
			
			
			_reciver = rec;
			_rootNode = rootNode;
			
			_node  =   parseTreeRecursive( panelData );
			_node.properties = panelData;
			super(_node);

			buildPanel();
        }
		

		
		public function buildPanel():void {
		}


		public function addNewElement(element:*):void {
			_reciver.addNewElement(element);
		}


    }
}