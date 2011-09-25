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
	import ui.panels.*;
	import elements.*;
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
	
	
	public class Viewer extends Sprite 
	{

		
		private var internalElementClasses:Object;
		private var windowContainer : WindowContainer;
		private var layerBottom:Sprite;
		private var layerMiddle:Sprite;
		private var layerTop:Sprite;
		
		private var windowsManager:WindowsManager;
		private var panelsManager:PanelsManager;
		//private var dialogManager:DialogManager;
		private var siteDataString:String;
		private var site:*;
		private var elementNode:DataNode;


	
			//floating windows
			
		private var dataBridge:JSBridge;
		//private var _flashVars:Object;
		
		public function Viewer(flashVars:Object):void {
			
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
			trace("Editor.elementClassesLoaded() " + externalElementClasses);
		
			DataManager.mcClasses = externalElementClasses;
			
			internalElementClasses 	= prepairInternalElementClasses( /* //TODO load external Classes */) ;
			
			if(internalElementClasses){
				
				DataManager.setAviableClasses(internalElementClasses);	
				
				var str:String = siteDataString;

				var obj:Object;
				try {				
					obj = JSON.decode( str );
				}catch (e:JSONParseError)  {
					trace("Error Decoding JSON. file invalid...\nmessage: " + e.message + "\nlocation: " + e.location);
					DataManager.jsBridge.traceToJs("onDataRecieved", "> Error Decoding JSON");				
					obj = new Object();		
				}

				if (objectLength(obj)) {
					if(DataManager.setStructure(obj)){
						site = new ControlWrapper( DataManager.applicationData, DataManager.getCommands(), site);
						site.addEventListener(ControlEvent.CONTROL_READY, onEditorControlReady );
						site.addEventListener(ControlEvent.PAGE_CHANGED, onEditorControlReady );
						
						layerBottom.addChild(site);
					}
				}else {
					DataManager.jsBridge.traceToJs("onJs_siteData", "[Error] Invalid JSON or Empty Object");			
					trace("[Error] Invalid JSON or Empty Object");
				}
				
				DataManager.jsBridge.traceToJs("onDataRecieved", (obj as Object).toString() );
			}
		}
	
	
		public function onEditorControlReady(e:ControlEvent):void { 
			
		
			trace("Editor.onControlReady() .. " + e.data + "\n");
			
			//DataManager.selectedElement = site.canvas.elements[0];
			


			
		}
		
		//==================================== TransformTool ===============================================	

		
	
		
		//==================================== Actions on  Elements ===============================================	
		private	function ____________Elements_and_Pages___(  ) : void {}
		

		
	
		
		
		public function execute( param:String = ""):void {
			trace("[i] Editor.execute() : " + param);
		}
	}
	
}


