package ui.popup {
	import com.sibirjak.asdpc.button.*;
	import data.DataNode;
	import managers.*;
	import controls.CanvasControl;
	import org.as3commons.ui.layout.HGroup;
	import org.as3commons.ui.layout.constants.Align;
	import org.as3commons.ui.layout.shortcut.*;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;

	public class PopUp extends Sprite {
		
		public static const ALERT_YES : String = "yes";
		public static const ALERT_NO : String = "no";
		public static const ALERT_CANCEL : String = "cancel";
		
		protected var _clickCallback : Function;
		private var _clickOutsideCallback : Function;
		
		public function PopUp(headline : String, node:DataNode, buttons : Array, clickCallback : Function) {
			
			_clickCallback = clickCallback;
			
			var w : uint = 550;
			var h : uint = 360;
			var padding : uint = 10;

			// shadow and background
			with (graphics) {
				beginFill(0x999999, .15);
				drawRect(8, 8, w, h);
				lineStyle(1, 0xCCCCCC);
				beginFill(0xFFFFFF);
				drawRect(0, 0, w, h);
			}
			
			// headline
			var tf1 : TextField = new TextField();
			tf1.selectable = false;
			tf1.autoSize = TextFieldAutoSize.LEFT;
			tf1.defaultTextFormat = new TextFormat("_sans", 16, 0x444444, false);
			tf1.text = headline;	
			
			var	control:CanvasControl = new CanvasControl( node, DataManager.getCommands() );
			
			// buttons
			if (buttons) {
				var bGroup : HGroup = hgroup("gap", 10);
				if (buttons[0]) bGroup.add(createButton(buttons[0], ALERT_YES));
				if (buttons[1]) bGroup.add(createButton(buttons[1], ALERT_NO));
				if (buttons[2]) bGroup.add(createButton(buttons[2], ALERT_CANCEL));
			}
			

			

			// layout
			vgroup(
				"marginX", padding, "marginY", padding,
				"minWidth", w - 2*padding, "minHeight", h - 2*padding,
				"vAlign", Align.JUSTIFY,
				hgroup(
					cellconfig("vIndex", 1, "marginY", 10),
					tf1
				),
				control,
				bGroup
			).layout(this);
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