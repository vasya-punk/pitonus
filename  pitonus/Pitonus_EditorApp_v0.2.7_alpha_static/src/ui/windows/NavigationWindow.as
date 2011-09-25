package ui.windows {


	import com.sibirjak.asdpc.button.Button;
	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpcbeta.selectbox.SelectBox;
	import data.DataNode;
	import elements.canvas.Canvas;
	import elements.Element;
	import events.SimpleEvent;
	import events.UiEvent;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import org.as3commons.ui.layout.Display;
	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import org.as3commons.ui.layout.framework.IDisplay;
	import org.as3commons.ui.layout.framework.IDynTable;
	import org.as3commons.ui.layout.framework.IGroupLayout;
	import org.as3commons.ui.layout.framework.IHLayout;
	import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.framework.IMultilineLayout;
	import org.as3commons.ui.layout.framework.ITable;
	import org.as3commons.ui.layout.framework.IVLayout;
	import org.as3commons.ui.layout.shortcut.hgroup;
	import org.as3commons.ui.layout.shortcut.hlayout;
	import org.as3commons.ui.layout.shortcut.vgroup;
	import ui.*;	
	import managers.*;	
	import managers.utils.*;		
	import configuration.*;
	import utils.*;
	
	import flash.display.Sprite;

	/**
	 * @author Jens Struwe 29.03.2011
	 */
	public class NavigationWindow extends Sprite {

		
		private var _element : *;
		private var _canvas : Canvas;
		private var _receiver:*;
		public var tabLayout : ILayout;
		//private var _contnet:Sprite;
		
		public function NavigationWindow( rec:* ) {

			_receiver 	= rec;	
			drawContent();
		}
		
		private function drawContent( ):void {

		
		
			var box:Shape = new Shape();
			drawSquare(box, new Rectangle(0, 0, 200, 250),0.01);

			
			tabLayout = vgroup(
				"offsetX", 4,
				"offsetY", 0,
			
				"hGap", 8,
				"vGap", 4,
				
				//headline("Change", 150),
				box
			
			);
			
			tabLayout.layout(this);
			
			DataManager.tree = new TraceNode( DataManager.applicationData );
			(DataManager.tree as TraceNode).addEventListener(SimpleEvent.SIMPLE_EVENT , elementSelected);
			addChild( DataManager.tree );
			
			
		}
		
		public function elementSelected( e:SimpleEvent  ):void {
			trace( e.data + " : "  + ( e.data as DataNode ).id );	
			dispatchEvent(new UiEvent( UiEvent.NODE, e.data));
		}
		
		//============================= GETTERS/SETTERS  ===================================
		public function reDrawContent( node:DataNode = null ):void {
			
			if (DataManager.tree.stage) { 
				(DataManager.tree as TraceNode).update(DataManager.applicationData, node);
			}
			
			
			/*	removeChild(DataManager.tree);
				
			DataManager.tree = new TraceNode(DataManager.applicationData);
			addChild( DataManager.tree );*/
			
		}

		
	}

}