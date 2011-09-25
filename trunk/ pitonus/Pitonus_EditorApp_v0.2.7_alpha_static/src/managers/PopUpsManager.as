package managers 
{
	import flash.events.MouseEvent;
	import ui.dialogs.*;
	import ui.dialogs.selection.ChooseFromDialog;
	//import layer.popup.common.AlertBox;
	import com.sibirjak.asdpc.button.Button;
	import com.sibirjak.asdpc.button.ButtonEvent;
	import org.as3commons.ui.layer.PopUpManager;
	import flash.display.Sprite;
	import events.*;
	import flash.events.Event;
	import ui.popups.*;
	
	public class PopUpsManager  extends Sprite
	{
		private var _popUpManager : PopUpManager;
		private var _alert : AlertBox;
		private var _dialogOnBackground : *;
		private var _dialog : *;

		public function PopUpsManager() {
			if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        private function init( e : Event = null ) : void 	{

            removeEventListener( Event.ADDED_TO_STAGE, init );
            // entry point
			
			var container : Sprite = stage.addChild(new Sprite()) as Sprite;
			_popUpManager = new PopUpManager(container);
			_popUpManager.modalOverlay = ModalOverlay;
			container.addEventListener(Event.CANCEL, cancelHandler);
			
			/*_addButton = new Button();
			_addButton.setSize(50, 20);
			_addButton.label = "add";
			_addButton.addEventListener(ButtonEvent.CLICK, addHandler);
			addChild(_addButton);*/
		}
		
		private function cancelHandler(event : Event) : void {
			removePopUp(_alert, event.type);
		}
			
		public function addPopup(dialog:*, label:String = "Modal Popup") : void {
			trace("[a][m] PopUpsManager - addPopup() : " + dialog);
			_dialog = dialog;
			_dialog.addEventListener( ControlEvent.REMOVE, cancelHandler);
			
			trace("[i todo] - _dialog.addEventListener(UiEvent.SELECT_IMAGE, selectImageHandler)");
			_dialog.addEventListener(UiEvent.SELECT_IMAGE, selectImageHandler);
			
			_alert = new AlertBox(
				label,
				_dialog,
				[null, null, "Close"],
				removePopUp
			);
			_popUpManager.createPopUp(_alert, true, true);
		}
		
		private function selectImageHandler(event : UiEvent) : void {
			
			trace("PopUpsManager.selectImageHandler()");
			//_dialogOnBackground = _dialog;
			
			var dialog:* = new ChooseFromDialog("Image");
			dialog.addEventListener(Event.COMPLETE, addDialogHandler);	
			dialog.addEventListener(UiEvent.SELECTION, selectionHandler);
			addChild(dialog);
			
			function addDialogHandler(e:Event):void {
				trace("PopUpsManager.addDialogHandler()");
				addPopup(dialog, "ChooseFromDialog properties");
			}
			
			function selectionHandler(e:UiEvent):void {
				trace("PopUpsManager.selectionHandler() " + e.data);
				DataManager.receiver.site.design.backgroundSrc =  e.data.src;
			}
			
		}
		
		public function removePopUp(alert : AlertBox, event : String) : void {
			(_dialog as Dialog).cleanUp();
			_popUpManager.removePopUp(alert);
			alert = null;
			trace("[i] PopUpsManager - removePopup handler");
		}
	}
}

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

internal class ModalOverlay extends Sprite {
	public function ModalOverlay() {
		with (graphics) {
			clear();
			beginFill(0x000000, .3);
			drawRect(0, 0, 100, 100);
		}
		this.addEventListener(MouseEvent.CLICK, clickHandler);
	}
	private function clickHandler(e:MouseEvent):void {
		dispatchEvent(new Event(Event.CANCEL,true));
	}
}
