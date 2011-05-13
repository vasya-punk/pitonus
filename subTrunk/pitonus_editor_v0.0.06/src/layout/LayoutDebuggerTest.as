package layout {
	import com.sibirjak.asdpc.button.Button;
	import Editor.Elements.InputProperty;
	import layout.common.box.Box;
	import org.as3commons.ui.layout.HGroup;
	import org.as3commons.ui.layout.Table;
	import org.as3commons.ui.layout.constants.Align;
	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import org.as3commons.ui.layout.shortcut.*;
	import flash.display.Sprite;
	import org.as3commons.ui.layout.VGroup;
import com.sibirjak.asdpc.button.ButtonEvent;
	public class LayoutDebuggerTest extends Sprite {
		public function LayoutDebuggerTest() {
			var obj:Object = new Object();
			obj["label"] = "stam";
			obj["value"] = "input";
	
			var button : Button = new Button();
      button.setSize(80, 24);
      button.label = "Click: " + 1;
	  button.label = "xxxx";
     // button.addEventListener(ButtonEvent.CLICK, buttonClickHandler);
   
			var ip:InputProperty = new InputProperty(obj);
			//addChild(ip);
		
			var t : HGroup = hgroup( 
			
				hlayout("maxItemsPerRow", 6, ip, Box.create(25, true, 30, 40)), button, 
				Box.create(25, true, 30, 40)
				
			);
			t.layout(this);
			
			var debugger : LayoutDebugger = new LayoutDebugger();
			addChild(debugger);
			debugger.debug(t);
		}
	}
}


//	hlayout("maxItemsPerRow", 2, Box.create(4))