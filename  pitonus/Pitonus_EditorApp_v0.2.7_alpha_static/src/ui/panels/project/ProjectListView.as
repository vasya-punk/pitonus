/**
 * ActionScript Data Provider Controls
 * 
 * Copyright (c) 2010 Jens Struwe, http://www.sibirjak.com/
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package ui.panels.project {

	import com.sibirjak.asdpc.button.Button;
	import com.sibirjak.asdpc.button.ButtonEvent;
	import com.sibirjak.asdpc.button.skins.ButtonSkin;
	import com.sibirjak.asdpc.common.dataprovider.*;
	import com.sibirjak.asdpc.common.icons.IconFactory;
	import ui.ControlPanelBase;
	import com.sibirjak.asdpc.core.IView;
	import com.sibirjak.asdpc.core.View;
	import com.sibirjak.asdpc.listview.IListView;
	import com.sibirjak.asdpc.listview.ListItemData;
	import com.sibirjak.asdpc.listview.ListView;
	import com.sibirjak.asdpc.listview.ListViewEvent;
	import com.sibirjak.asdpc.listview.renderer.ListItemIcon;
	import com.sibirjak.asdpc.listview.renderer.ListItemRenderer;
	import com.sibirjak.asdpc.listview.ListItemEvent;
	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpc.treeview.renderer.TreeNodeRenderer;
	import flash.events.Event;
	import utils.*;
	import events.*;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class ProjectListView extends Sprite {

		protected var _listNavigation : IListView;

		private var _buttonSize : uint = 13;
		private var _buttonPadding : uint = 4;
		private var _dataSource:*;
		private var _width:uint = 170;
		private var _height:uint = 100;
		
		private var _buttons : Sprite;
		private var _selectAllButton : Button;
		private var _deselectAllButton : Button;
		private var _scrollToTopButton : Button;
		private var _scrollToBottomButton : Button;

		protected var _buttonStyles : Array = [
			Button.style.overIconSkinName, Button.UP_ICON_SKIN_NAME,
			Button.style.downIconSkinName, Button.UP_ICON_SKIN_NAME,
			Button.style.selectedUpIconSkinName, Button.UP_ICON_SKIN_NAME,
			Button.style.selectedOverIconSkinName, Button.UP_ICON_SKIN_NAME,
			Button.style.selectedDownIconSkinName, Button.UP_ICON_SKIN_NAME
		];


		public function ProjectListView( dataSource:* ) {
			
			_dataSource = dataSource;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			draw();
		}
		
		/* protected function viewStyleChanged(property : String, value : *) : void {
			
			if (property == ListItemIcon.style.iconSkin) {
				_listNavigation.setStyle(property, value);
			}
		}*/

		 protected function draw() : void {

			_listNavigation = createListBuilder();

		/*	_listNavigation.addEventListener(NavigationEvent.SELECT, selectHandler);
			_listNavigation.addEventListener(NavigationEvent.DESELECT, deselectHandler);
			_listNavigation.addEventListener(NavigationEvent.SCROLL, scrollHandler);
	*/		
			addChild(DisplayObject(_listNavigation));

		}

		protected function get _listView() : IListView {
			return _listNavigation as IListView;
		}

		
		private function createListBuilder() : * {
			
			var _listBuilder:* = new ListView();
			_listBuilder.setSize(_width, 150);
			
			_listBuilder.name = "listbuilder";
			
			var iconFunction : Function = function (data : ListItemData) : Class {
				return IconFactory.getInstance().getIconSkin(IItem(data.item).category);
			};

			_listBuilder.setStyles([
				ButtonSkin.style_borderAlias, false,
				Label.style.size, 9,

				ListView.style.itemSize, 20,
				//ListView.style.selectedItemSize, 2,
				ListView.style.scrollBarSize, 10,
				
				TreeNodeRenderer.style.expandCollapseOnDoubleClick, false,

				ListItemRenderer.style.contentRenderer, ListBuilderContentRenderer,
				ListItemRenderer.style.backgroundType, ListItemRenderer.BACKGROUND_CONTENT,
				ListItemRenderer.style.selectedBackgroundColors, [0xD5E0F0],
				ListItemRenderer.style.overBackgroundColors, [0xD5E0F0],
				ListItemRenderer.style.indent, 16,
				ListItemRenderer.style.icon, true,
				ListItemRenderer.style.clickSelection, true,

			/*	ListItemContent.style.selectedLabelStyles, [
					Label.style.color, 0x444444
				],*/

				ListItemIcon.style.iconSkinFunction, iconFunction,
				ListItemIcon.style.size, 12
				
			]);

			//trace("______dataSource:" + _dataSource + " " + typeof(_dataSource));
			//traceObject(_dataSource);
			
			_listBuilder.dataSource =  DataSourceCreator.createListFromArray(ArrayListItem, _dataSource);
			_listBuilder.addEventListener(ListItemEvent.SELECTION_CHANGED, selectHandler);
      
			
			//setListBuilderProperties();
			//_listBuilder.selectItemAt(0);
			
			addChild(DisplayObject(_listBuilder));
			
			return _listBuilder;
		}
		
		private function selectHandler(event : ListItemEvent) : void {
		  if (event.selected) {

			  trace("ProjectListView. --- " + event.itemIndex + " selected");
				dispatchEvent( new EditorEvent( EditorEvent.GENERIC, EditorEvent.PAGE_SELECT, event.itemIndex));
		  } else {
				trace("ProjectListView. --- No item selected");
		  }
		}
	
		public function setDataSource(src:* = null):void{
			_listNavigation.dataSource = DataSourceCreator.createListFromArray(ArrayListItem, _dataSource); 
			//DataSourceCreator.createListFromArray(ArrayListItem, src);
		}
		
		private function dataResetHandler(event : ListViewEvent) : void {
			_listNavigation.dataSource = _listView.dataSource;
			
			afterDataReset();
		}
		
		

		
		protected function afterDataReset() : void {
		}
	}
}

		
		