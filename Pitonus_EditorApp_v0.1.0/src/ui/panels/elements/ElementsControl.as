package ui.panels.elements
{

	
	
	
	
	import controls.*;
	import commands.*;
	import elements.*;
	import elements.canvas.*;
	import utils.*;
	import data.*;
	import data.utils.*;
	import managers.*;
	
	import flash.display.*;
	import flash.events.*;
	
	public class ElementsControl extends CanvasControl  {
		
	
			  
		public function ElementsControl( node:DataNode , commands:Object, rec:* = null) {
			super( node, commands, rec);
		}

		
		// EditorControl
		public function addNewElement( param:String):void {
			//trace("ProjectControl.addNewElement() : " + param);
			//DataManager.createPopUp(param, "ProjectControl.addNewElement()");
			_receiver.addNewElement(param);
		}
		
		public function removeElement( ):void {
			trace("ProjectControl.removeElement() : ");
			//DataManager.createPopUp("removeElement", "Currently not aviable");
			_receiver.removeElement();
		}
		
		
		//================================================================================================
		
		// Editor receiver
		public function saveSite( ):void {
			DataManager.receiver.saveSite();
		}
		
		public function loadSite( ):void {
			DataManager.receiver.loadSite();
		}
		
		public function addNewPage( ):void {
			trace("ProjectControl.addNewPage() : ");
			//DataManager.createPopUp("addNewPage");
			DataManager.receiver.addNewPage();
		}
		
		
		
	
		
		
	}
}

