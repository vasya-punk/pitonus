package  
{

	
	import com.greensock.*; 
	import com.greensock.easing.*;
	import com.sibirjak.asdpcbeta.core.managers.PopUpManager;
	import commands.*;
	import elements.sitemenu.SiteMenu;
	import managers.communication.*;
	import managers.*;
	import managers.utils.*;
	import configuration.*;
	import data.*;
	import org.as3commons.ui.layout.framework.ILayout;
	import ui.dialogs.create.*;
	import ui.dialogs.modify.ElementPropertiesDialog;
	import ui.dialogs.TextAlertDialog;
	import ui.panels.*;
	import elements.*;
	import elements.textblock.*;
	import elements.canvas.*;
	import elements.dropdownlist.*;
	import data.utils.*;
	import utils.*;
	import elements.canvas.*;
	import controls.*;
	import events.*;
	import ui.pinbar.PinBar;
	import ui.*;
	import ui.windows.*;
	
	import com.adobe.serialization.json.*;



	import org.as3commons.ui.lifecycle.lifecycle.LifeCycle;
	
	import com.senocular.display.*;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	
	public class Editor extends Sprite 
	{

		private var internalElementClasses:Object;
		private var windowContainer : WindowContainer;
		private var windowsManager:WindowsManager;
		private var panelsManager:PanelsManager;
	
		private var siteDataString:String;
		
		private var layerBottom:Sprite;
		private var layerMiddle:Sprite;
		private var layerTop:Sprite;
		
		public var site:*;
		private var dataBridge:JSBridge;
		
		public var temp:*;
		
		//private var _flashVars:Object;
		
		// DEBUG
		private var _debug:Boolean = false;
		public function get debug():Boolean {return _debug;}
		public function set debug(value:Boolean):void { _debug = value; }
		
		public function Editor(flashVars:Object):void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 1)	
				debug = true;
			
			
			DataManager.flashVars = new Object();
			DataManager.flashVars = flashVars;
			if (DataManager.flashVars['projectDataUrl']) {
				Config.MC_PATH = DataManager.flashVars['projectDataUrl'];
				Config.IMAGES_PATH = DataManager.flashVars['projectDataUrl'];
			}
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init(e:Event = null):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			// Define 3 main z-order positions
			layerBottom 	= stage.addChild(new Sprite()) as Sprite;
			layerMiddle 	= stage.addChild(new Sprite()) as Sprite;
			layerTop 		= stage.addChild(new Sprite()) as Sprite;
			
			windowContainer = new WindowContainer();
            layerTop.addChild( windowContainer );
			
			LifeCycleManager = new LifeCycle();
			
			var displayLayout:DisplayLayoutManager = new DisplayLayoutManager();
			stage.addChild(displayLayout);

			DataManager.receiver = this;
			DataManager.registerCommands();
			DataManager.layout = displayLayout;

			dataBridge = new JSBridge();
			dataBridge.addEventListener( JSBridgeEvent.SITE_STRUCTURE_RECIEVED, onJs_siteData); 
			DataManager.jsBridge = dataBridge;

			var textEditor:TextEditorManager = new TextEditorManager();
			layerTop.addChild(textEditor);
			DataManager.textEditorManager = textEditor;
			
			
		}
		

		
		//==================================== On ===============================================
		private	function ____________On___(  ) : void { }
		
		
		// DATA MANAGMENT ////////////////////////////////////////////////////////////////////////
		public  function onJs_siteData(e:JSBridgeEvent):void { 
			
			dataBridge.traceToJs("onJs_siteData(). ");
			
			siteDataString = e.data;
			
			//var elementsClassesLoader:ElementsClassesLoader = new ElementsClassesLoader(this);
			//elementsClassesLoader.addEventListener(Event.COMPLETE, elementClassesLoaded);
			var mcLoader:MCClassLoader = new MCClassLoader(this);
			//elementClassesLoaded();	
			
		}
	
		public function elementClassesLoaded( externalElementClasses:* = null ):void {
				
			dataBridge.traceToJs("elementClassesLoaded() ");
			trace("[i] Editor - elementClassesLoaded() " + externalElementClasses + " - OK");
		
			DataManager.mcClasses = externalElementClasses;
			
			internalElementClasses 	= prepairInternalElementClasses( /* //TODO load external Classes */) ;
			
			if(internalElementClasses){
				
				DataManager.setAviableClasses(internalElementClasses);	
				
				var str:String = siteDataString;

				var obj:Object;
				try {				
					obj = JSON.decode( str );
				}catch (e:JSONParseError)  {
					trace("[Error] Editor - Decoding JSON. file invalid...\nmessage: " + e.message + "\nlocation: " + e.location);
					DataManager.jsBridge.traceToJs("onDataRecieved", "[Error] Editor - Error Decoding JSON");				
					obj = new Object();		
				}

				if (objectLength(obj)) {
					if(DataManager.setStructure(obj)){
						site = new EditorControlWrapper( DataManager.applicationData, DataManager.getCommands(), this);
						site.addEventListener(ControlEvent.CONTROL_READY, onEditorControlReady );
						site.addEventListener(ControlEvent.PAGE_CHANGED, onEditorControlReady );
						
						layerBottom.addChild(site);
					}
				}else {
					DataManager.jsBridge.traceToJs("onJs_siteData", "[Error] Invalid JSON or Empty Object");			
					trace("[Error] Editor - Invalid JSON or Empty Object");
				}
				
				DataManager.jsBridge.traceToJs("onDataRecieved", (obj as Object).toString() );
			}
		}
	
	
		public function onEditorControlReady(e:ControlEvent):void { 
			
			if(debug)	trace(" ___ [i] Editor - onControlReady() .. " + e.data);

			if(!DataManager.transformTool){
				initTransformTool();
			}else {
				
				DataManager.transformTool.update( getTransformToolElements() );
			}
			// TODO : CleanUp Editor!
			createWindows();
			createPanels();
			createDialogs();
			
		
			
		}
		
		private function spliceBg(array:Array):Array {
			var arr:Array = array;
			for (var i:int = 0; i < arr.length; i++) {
				if(arr[i].elementType == "Background")
					arr.splice(i, 1);	
			}
			return arr;
		}
		
		//==================================== TransformTool ===============================================	
		private	function ____________TransformTool___(  ) : void {}

		
		
		private function initTransformTool() : void {
			
			if (debug)	trace("[i] Editor - initTransformTool()" );
			
			var transformTool:TransformToolManager = new TransformToolManager();
			transformTool.activeElements = getTransformToolElements();
			
			DataManager.transformTool = transformTool;
			DataManager.transformTool.addEventListener(TransformToolEvent.SELECT_ELEMENT, selectElement);
			DataManager.transformTool.addEventListener(TransformToolEvent.UPDATE_ELEMENT, updateElement);
			DataManager.transformTool.addEventListener(TransformToolEvent.DOUBLE_CLICK, updateText);
			
			layerMiddle.addChildAt(transformTool,0);
			
		}
		
		private	function getTransformToolElements(  ) : Array {
			var els:Array;
			if(site.canvas.layout != "absolute")
				els = arrConcatUnique( site.design.canvas.elements);
			else
				els = arrConcatUnique( site.design.canvas.elements, site.canvas.elements);
			spliceBg(els);
			return els;
		}
		
		private	function updateText( e:TransformToolEvent ) : void {
			DataManager.textEditorManager.setTextSaveTarget = e.element;
			DataManager.textEditorManager.text = e.element.text;
			
		}
		
		public	function updateTransformSelection( element:* = null) : void {
			
			if(debug)	trace("[i] Editor - updateTransformSelection() : " + element);
			
			DataManager.transformTool.deselect();	
			site.drawPage();
			/*if(DataManager.transformTool)
				DataManager.transformTool.updateSelectionBox();*/
		}
		
		public	function onSelectNode( node:DataNode ) : void {
			if(debug)	trace("[i] Editor - onSelectNode() : " + node);
			try{
				var element:* = findElementRecursive(site.canvas, node);
				if (element != null) {
					DataManager.selectedElement = element;
					updateWindows();	
				}
			}catch (e:Error) {
				trace("[Error] Editor. - onSelectNode() : " + e);
			}
		}
		
		
		//==================================== Actions on  Elements ===============================================	
		private	function ____________Elements_and_Pages___(  ) : void {}
		
		
		private	function selectElement( e:TransformToolEvent ) : void {

			// Update of property automaticly triggers element.update() function
			
/*			selectedElement.marginY = selectedElement.y;
			selectedElement.marginX = selectedElement.x;*/	
			
			var selectedElement:* = e.element;		
			
			if (selectedElement.elementType == "SiteMenu")
				temp = selectedElement;
			
			DataManager.selectedElement = selectedElement;		
			
			if (debug)	
				trace(" -> [i] Editor - select element " 
					+ selectedElement 
					+ ", on: " 
					+ selectedElement.parent 
					+ " (" 
					+ selectedElement.parent.node 
					+ ")" );
					
			updateWindows();
			//showTextAlert("Heading not nessesery");
		}
		
		private	function updateElement( e:TransformToolEvent ) : void {
			
			if(debug)	trace("[i] Editor - updateElement() : " + e.element + ", mouseTransform");
			
			DataManager.selectedElement = e.element;
			var selectedElement:* = DataManager.selectedElement;
			selectedElement = e.element;
			selectedElement.marginX = selectedElement.x;
			selectedElement.marginY = selectedElement.y;

			//updateWindows();

		}
		
		public function updateWindows():void { 
			if (windowsManager)
				windowsManager.updateWindows();
		}
		
		private function createWindows():void {
			if (!windowsManager) {
				if(debug)	trace( "[i] Editor - createWindows()" );
				windowsManager = new WindowsManager(this, windowContainer);
				windowsManager.addEventListener(EditorEvent.GENERIC, onEditorEvent);
				layerTop.addChild(windowsManager);
			}else {
				windowsManager.updateWindows();
			}

		}
		
		public function addDialog(dialog:*, param:String = null):void { 
			if(debug)	trace("[i] Editor - addDialog() : " + dialog + ", " + param);
			(DataManager.popupManager as PopUpsManager).addPopup( dialog, param );
		}
		
		private function createDialogs():void {
			
			if(!DataManager.popupManager){
				DataManager.popupManager = new PopUpsManager(); 
				DataManager.popupManager.addEventListener(EditorEvent.GENERIC, onEditorEvent);
				addChild(DataManager.popupManager);
			}
			
			/*if (!dialogManager) {
				trace( "................... Editor.createDialogs()" );
				dialogManager = new DialogManager(site);
				dialogManager.addEventListener(EditorEvent.GENERIC, onEditorEvent);
				layerTop.addChild( dialogManager );
			}else {
				dialogManager.update();
			}*/

		}
		
		private function createPanels():void {
			
			if (!panelsManager) {
				if(debug)	trace( "[i] Editor - createPanels()" );
				panelsManager = new PanelsManager(site);
				panelsManager.addEventListener(EditorEvent.GENERIC, onEditorEvent);
				layerMiddle.addChild( panelsManager );
			}else {
				panelsManager.updatePanels();
			}
		}
		
		private function showTextAlert(alert:String = "heading"):void {
			
			var d:TextAlertDialog = new TextAlertDialog("xx");
			d.addEventListener(Event.COMPLETE, ready);
			function ready(e:Event):void {
				addDialog(d, alert);
			}
			addChild(d);
			
		}
		
		public function onEditorEvent(e:EditorEvent):void {
			
			if(debug)	trace("[i] Editor - onEditorEvent: " + e.type + ": " + e.event + " " + e.data);
			
			if(e.event == EditorEvent.PAGE_REMOVE)
				site.removePage(e.data);
				
			if(e.event == EditorEvent.PAGE_SELECT){
				site.gotoPage(e.data);	
				DataManager.selectedElement = site.canvas;
				updateWindows();
			}
				
			if(e.event == EditorEvent.PAGE_ADD)
				site.addElement(e.data);		
				
			
		}
		
		
		public function execute( param:String = ""):void {
			trace("[i] Editor - execute() : " + param);
		}
		
		

	
	}
	
}


