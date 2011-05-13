package Editor 
{
	import Elements.*;
	import flash.display.Sprite;
	import org.as3commons.ui.layout.HGroup;
	
	import com.sibirjak.asdpc.treeview.TreeNodeEvent;
	import com.sibirjak.asdpc.treeview.TreeView;
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.ui.layout.VGroup;
	import org.as3commons.ui.layout.constants.Align;

	import Utils.*
	import Managers.*
		
	public class ElementsPanel extends Canvas implements IElement
	{
		private var _HGroupIconsArrayList:	ArrayList;
		private var layoutHGroupIconsList:Object = new Object();
		
		public function ElementsPanel() { }
		
		public function setData() : void {
				var	btnObj:Object = new Object();
			btnObj['caption'] = "Update";
			btnObj['action'] = "UpdateElement";
			btnObj['x'] = "20";
			btnObj['y'] = "2";

			// new Button or Button ????
			layoutHGroupIconsList['another'] = createElement( getClass(Button), btnObj );

			
			_HGroupIconsArrayList = new ArrayList();
			
			// Add
			for(var itemName:String in layoutHGroupIconsList) {
				_HGroupIconsArrayList.add( layoutHGroupIconsList[itemName] );
				_HGroupIconsArrayList.last.name = itemName;
			}
			/*
			// List iterator
			var listIterator : IListIterator = _HGroupIconsArrayList.iterator() as IListIterator;
			while (listIterator.hasNext()) {
				listIterator.next();
				trace (listIterator.index + "=" + listIterator.current);
			}*/
			
			var layoutHGroupIcons : HGroup = new HGroup();
			layoutHGroupIcons.gap = 10;
			layoutHGroupIcons.marginX= 250;
			layoutHGroupIcons.marginY = 10;
			
			for each(var ico:Sprite in layoutHGroupIconsList) {
					layoutHGroupIcons.add(ico);
			}
			
			layout(layoutHGroupIcons);
			
			
	

		/*	designView.addEventListener(TreeNodeEvent.SELECTION_CHANGED, selectHandler);
	
			function selectHandler(event : TreeNodeEvent) : void {			
				if (event.selected) {
						trace(" .. selected " + event.item['pageId'] + " " + event.item['elementType']);
				} else {
					trace( "No item selected");
				}
			}*/
		}
		private function layout(layoutHGroupIcons:*) : void {
				  layoutHGroupIcons.layout(this);
				  graphics.clear();
				  drawSquare(this, layoutHGroupIcons.visibleRect);
		}

		// Public functions /////////////////////////////////////////
		public function getList() : ArrayList {
			return _HGroupIconsArrayList;
		}
		
		public function getButton():*{
			return layoutHGroupIconsList['another'];	
		}
	}

}