package Editor 
{

	import Controls.CanvasControl;
	import flash.display.DisplayObject;
	import Elements.*;
	import flash.events.MouseEvent;
	import Managers.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import Utils.*;
	import Config.*;
	import Elements.*;
				
	import com.sibirjak.asdpc.treeview.*;
	import org.as3commons.collections.*;
	import org.as3commons.collections.framework.*;
	
	public class StructurePanel extends Panel implements IElement
	{
		public function StructurePanel() {}
		
		public function setData():void {
			var list : ArrayList = new ArrayList();

			var a:* = Manager.getPageObject(0);
			a['name'] = "Page " + a['pageId'];
			list.add(a);

			var iterator : IIterator = list.iterator();         
			var treeView:TreeView = new TreeView();		
			treeView = new TreeView();
			treeView.setStyle(TreeView.style.showRoot, false);
			treeView.setSize(180,300);
			treeView.dataSource = list;
			addChild(treeView);

			_activeElements = new Array();
			_activeElements[0] = treeView;
			
	
		}

	}
}
