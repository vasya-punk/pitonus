package ui.popups {
	import com.sibirjak.asdpc.button.*;
	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.HGroup;
	import org.as3commons.ui.layout.constants.Align;
	import org.as3commons.ui.layout.shortcut.*;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import org.as3commons.ui.layout.VGroup;

	public class AlertBox extends Sprite {
		public static const ALERT_YES : String = "yes";
		public static const ALERT_NO : String = "no";
		public static const ALERT_CANCEL : String = "cancel";
		protected var _clickCallback : Function;
		private var _clickOutsideCallback : Function;
		
		
		public var tabLayout : ILayout;
		
			
		
		public function AlertBox(headline : String, dialog : *, buttons : Array, clickCallback : Function) {
			_clickCallback = clickCallback;
			
			var w : uint = dialog.w;// tabLayout.visibleRect.width;
			var h : uint = dialog.h;// tabLayout.visibleRect.height;
			
			// headline
			var tf1 : TextField = new TextField();
			tf1.selectable = false;
			tf1.autoSize = TextFieldAutoSize.LEFT;
			tf1.defaultTextFormat = new TextFormat("_sans", 16, 0x444444, false);
			tf1.text = headline;	
			
			/*// text
			var tf2 : TextField = new TextField();
			tf2.width = w - 2*padding;
			tf2.selectable = false;
			tf2.autoSize = TextFieldAutoSize.LEFT;
			tf2.wordWrap = true;
			tf2.defaultTextFormat = new TextFormat("_sans", 12, 0x444444);
			tf2.text = text;*/
			
			
			var headingGroup : HGroup = new HGroup();
			headingGroup.marginX = 0;
			headingGroup.marginY = 0;
			headingGroup.offsetX = 0;
			headingGroup.offsetY = 0;
			headingGroup.minWidth = w;
			headingGroup.minHeight = 25;
			headingGroup.gap = 0;
			headingGroup.hAlign = Align.LEFT;
			headingGroup.vAlign = Align.TOP;
			headingGroup.add(tf1);
			headingGroup.layout(this);
			
			var bGroup : HGroup = new HGroup();
			bGroup.marginX = 0;
			bGroup.marginY = -25;
			bGroup.offsetX = 0;
			bGroup.offsetY = 0;
			bGroup.minWidth = w;
			bGroup.minHeight = 25;
			bGroup.gap = 0;
			bGroup.hAlign = Align.RIGHT;
			bGroup.vAlign = Align.TOP;
			bGroup.add(getCustomButton());
			if (buttons[0]) bGroup.add(createButton(buttons[0], ALERT_YES));
			if (buttons[1]) bGroup.add(createButton(buttons[1], ALERT_NO));
			if (buttons[2]) bGroup.add(createButton(buttons[2], ALERT_CANCEL));
			bGroup.layout(this);
			
			var tabLayout : VGroup = new VGroup();
			tabLayout.marginX = 0;
			tabLayout.marginY = 0;
			tabLayout.offsetX = 0;
			tabLayout.offsetY = 0;
			tabLayout.minWidth = w;
			tabLayout.minHeight = h;
			tabLayout.gap = 0;
			tabLayout.hAlign = Align.CENTER;
			tabLayout.vAlign = Align.TOP;
			tabLayout.add(headingGroup,bGroup, dialog);

	
			tabLayout.layout(this);
		
		/*	var debugger : LayoutDebugger = new LayoutDebugger();
			addChild( debugger );
			debugger.debug( tabLayout );*/
			
			
			var padding : uint = 10;

			// shadow and background
			with (graphics) {
				beginFill(0x999999, .15);
				drawRect(8, 8, w, h);
				lineStyle(1, 0xCCCCCC);
				beginFill(0xFFFFFF);
				drawRect(0, 0, w, h);
			}
		}
		
		public function watchClickOutside(clickOutsideCallback : Function) : void {
			_clickOutsideCallback = clickOutsideCallback;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageClick);
		}
		
		public function unwatchClickOutside() : void {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageClick);
		}
		
		protected function getCustomButton() : Button {
			return null;
		}
		
		private function createButton(label : String, eventType : String) : Button {
			var button : Button = new Button();
			button.setSize(60, 22);
			button.label = label;
			button.addEventListener(ButtonEvent.CLICK, function(event : Event) : void {
				buttonClickHandler(eventType);
			});
			return button;
		}
		
		private function stageClick(event : MouseEvent) : void {
			if (!hitTestPoint(event.stageX, event.stageY)) {
				_clickOutsideCallback(this);
			}
		}

		private function buttonClickHandler(eventType : String) : void {
			_clickCallback(this, eventType);
		}
	}
}