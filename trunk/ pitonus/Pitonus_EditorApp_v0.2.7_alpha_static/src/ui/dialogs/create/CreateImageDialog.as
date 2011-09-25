package ui.dialogs.create 


{

	import controls.*;
	import data.*;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import ui.dialogs.Dialog;
	import ui.dialogs.selection.ChooseFromDialog;
	import ui.panels.Panel;
	import utils.*;
	import events.*;
	import data.utils.*;
	import flash.events.Event;
	import flash.text.TextField;
	import managers.*;
	import flash.display.Sprite;
	import controls.*;
	import flash.events.MouseEvent;
	import managers.utils.TraceNode;
	import com.adobe.serialization.json.*;
	import org.as3commons.ui.layout.shortcut.vgroup;
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;	

	public class CreateImageDialog extends ChooseFromDialog
	{
		
		
		
		public function CreateImageDialog ( rec:* = null ) {		
			super(rec);
		}

		
		
		override public function select(param:String) : void {
			trace("[a][d] CreateImageDialog - select() : " + param);
			if(param == CANCEL){
				cleanUp();
			}else {

				DataManager.receiver.site.addElementFromObject( {
					  "elementType": "Image",
					  "w": "200",
					  "h": "150",
					  "src": param
					}
				);
				cleanUp();
				dispatchEvent(new ControlEvent(ControlEvent.REMOVE,this));
			}
		}
		
	}

}

