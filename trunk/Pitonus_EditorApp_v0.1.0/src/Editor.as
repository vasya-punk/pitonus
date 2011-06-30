package  
{

	
	
	

	import managers.communication.*;
	import managers.*;
	import managers.utils.*;
	import configuration.*;
	import data.*;
	import ui.panels.elements.ElementsPanel;
	import ui.panels.project.ProjectPanel;
	import ui.tabs.*;
	import elements.*;
	import elements.dropdownlist.*;
	import data.utils.*;
	import utils.*;
	import elements.canvas.*;
	import ui.popup.*;
	import controls.*;
	import ui.pinbar.PinBar;
	import ui.*;
	import ui.panels.*;
	import ui.tabs.PropertiesTab;
	
	import com.adobe.serialization.json.*;

	import com.flashdynamix.utils.SWFProfiler;

	import com.sibirjak.asdpcbeta.window.core.WindowPosition;
	import com.sibirjak.asdpcbeta.window.Window;
	import com.sibirjak.asdpc.core.constants.Position;
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
		
		
		[Embed(source="../assets/size.png")]
		private var _sizeIcon : Class;
		
		[Embed(source="../assets/size_white.png")]
		private var _sizeIconWhite : Class;
		
		
		
		private var layerBottom:Sprite;
		private var layerMiddle:Sprite;
		private var layerTop:Sprite;
		
		
		
		private var internalElementClasses:Object;

		private var sizeWindow : Window = new Window();
		private var _eventWindow :*;
		
		
		//
		private var site:EditorControl;
		private var elementNode:DataNode;
		
			
		// Editor Components
		private var panelElements:ElementsPanel;
		private var panelProject:ProjectPanel ;
	
			//floating windows
		private var windowContainer : WindowContainer;
		private var windows : Object;
		private var pinBar : PinBar ;
		
		public function Editor():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			SWFProfiler.init(stage, this);

			// Define 3 main z-order positions
			layerBottom 	= stage.addChild(new Sprite()) as Sprite;
			layerMiddle 	= stage.addChild(new Sprite()) as Sprite;
			layerTop 		= stage.addChild(new Sprite()) as Sprite;
			
			LifeCycleManager 		= new LifeCycle();
			
			var displayLayout:DisplayLayoutManager = new DisplayLayoutManager();
			addChild(displayLayout);
			displayLayout.addEventListener(Event.ADDED_TO_STAGE, onLayoutReady );
			
			internalElementClasses 	= prepairInternalElementClasses();
			
			DataManager.receiver = this;
			DataManager.registerCommands();
			DataManager.setAviableClasses(internalElementClasses);	
			DataManager.layout = displayLayout;


			var dataBridge:JSBridge = new JSBridge();
			dataBridge.addEventListener( JSBridgeEvent.SITE_STRUCTURE_RECIEVED, onJs_siteData);
			DataManager.jsBridge = dataBridge;
			

			var overlayManager:OverlayManager = new OverlayManager(  );
			layerTop.addChild(overlayManager)
			DataManager.overlayManager = overlayManager;
			
			windowContainer = new WindowContainer();
			layerMiddle.addChild(windowContainer);
			
			windows = new Object();
			windows['propertiesWindow'] = null;
			windows['elementWindow'] = null;
			
		}
		
		//==================================== On ===============================================
		private	function ____________On___(  ) : void { }
		
		
		// DATA MANAGMENT ////////////////////////////////////////////////////////////////////////
		public  function onJs_siteData(e:JSBridgeEvent):void { 

			var str:String = e.data;
			
			var obj:Object;
			try {				
				obj = JSON.decode( str );
				//DataManager.jsBridge.callJs("console.log", "Flash > Structure is valid");	
			}catch (e:JSONParseError)  {
				trace("Error Decoding JSON. file invalid...\nmessage: " 
											+ e.message + "\nlocation: " + e.location);
				obj = new Object();		
			}
				
			if (DataManager.applicationData != null) {
				
				DataManager.transformTool.deselect();
				DataManager.transformTool.unRegisterElements();
				
				site.removeCanvas();
				site.removeEventListener(ControlEvent.CANVAS_ONDRAW, onCanvasReady);
				layerBottom.removeChild(site);
				site = null;
			}

			DataManager.setStructure(obj);

			site = new EditorControl( DataManager.applicationData, DataManager.getCommands(), this );
			site.addEventListener(ControlEvent.CANVAS_ONDRAW, onCanvasReady);
			layerBottom.addChild(site);
			
		}
		
		/*public  function fakeSimulation():void { 
				DataManager.jsBridge.pitLoad(Templates.TEST_CONTENT_DATA_STRING);
		}*/
		

		

		private function onLayoutReady(e:Event):void { 
			//trace("Editor.onLayoutReady()");	
		}
	
		public function onCanvasReady(e:ControlEvent):void { 
			
			trace("Editor.onCanvasReady()" );

			if(!DataManager.transformTool)
				initTransformTool();
			else
				DataManager.transformTool.update(site.canvas.elements);

			// panelElements
			if (panelElements){
				if (panelElements.stage) { 
					panelElements.removeControl();
					layerMiddle.removeChild(panelElements);
				}
			}
			
			panelElements  = new ElementsPanel(site);
			layerMiddle.addChild(panelElements);
			DataManager.layout.addToLayout(panelElements, Config.ALIGN_TOP_RIGHT);

			DataManager.overlayManager.editor = this;
			DataManager.overlayManager.control = site;
			
			// panelProject
			if (panelProject){
				if (panelProject.stage) { 
					panelProject.removeControl();
					layerMiddle.removeChild(panelProject);
				}
			}
			
			panelProject  = new ProjectPanel (this);
			layerMiddle.addChild(panelProject);
			DataManager.layout.addToLayout(panelProject, Config.ALIGN_BOTTOM_RIGHT);
			
			// TODO : CleanUp Editor!
			if(!windows['propertiesWindow'] )
				createWindows();
		}
		
		//==================================== TransformTool ===============================================	
		private	function ____________TransformTool___(  ) : void {}

		
		
		private function initTransformTool() : void {
	
			var transformTool:TransformToolManager = new TransformToolManager();
			transformTool.activeElements = site.canvas.elements;
			
			DataManager.transformTool = transformTool;
			DataManager.transformTool.addEventListener(TransformToolEvent.SELECT_ELEMENT, selectElement);
			DataManager.transformTool.addEventListener(TransformToolEvent.UPDATE_ELEMENT, updateElement);
			
			layerMiddle.addChildAt(transformTool,0);
			
		}
		
		public	function updateTransformSelection() : void {
			//trace("updateTransformSelection");
			if(DataManager.transformTool)
				DataManager.transformTool.updateSelectionBox();
		}
		
		
		
		//==================================== Actions on  Elements ===============================================	
		private	function ____________Elements_and_Pages___(  ) : void {}
		
		
		private	function selectElement( e:TransformToolEvent ) : void {
			DataManager.selectedElement = e.element;
			var selectedElement:* = DataManager.selectedElement;
			selectedElement = e.element;
			selectedElement.marginY = selectedElement.y;
			selectedElement.marginX = selectedElement.x;
			
			updatePropertiesWindows(selectedElement);
			
			
			trace(". selectElement " + selectedElement);
		}
		
		private	function updateElement( e:TransformToolEvent ) : void {
			
			DataManager.selectedElement = e.element;
			var selectedElement:* = DataManager.selectedElement;
			selectedElement = e.element;
			selectedElement.marginX = selectedElement.x;
			selectedElement.marginY = selectedElement.y;

			updatePropertiesWindows(selectedElement);

		}
		
		public	function openOptions() : void {
			
			var element:Element = DataManager.selectedElement as Element;

			if(element.getProperty("src")){
				var srcProp:String = element.getProperty("src");
				
				DataManager.overlayManager.createElementPropertiesPopUp(
						callback,
						element.getEditableProperties(),
						"Editor.CONFIG.Popup",
						"Choose:");
						
				function callback(type:String, property:*):void {
					switch (type) {
						case "src":
							element.setProperty("src", property);
						break;
						default:
							
						break;
					}
				}
				
				//DataManager.jsBridge.callJs("jsPit_requestImagesList");
			
				/*DataManager.overlayManager.createSavePopUp(DataManager.selectedElement, "Editor.SAVE.Popup",
								"U just about to save your beautiful' site.\nGo on!");*/
			}
		}

		
		//==================================== Project/Files ===============================================	
		private	function ____________Project_File___(  ) : void {}
		
		public function newSite():void {
			DataManager.overlayManager.createNewSitePopUp("Editor.NEW.Popup","Are you sure?");
		};
		
		public function saveSite():void {
			DataManager.overlayManager.createSavePopUp("Editor.SAVE.Popup",
							"U just about to save your beautiful' site.\nGo on!");
		};
		
		public function loadSite():void {
			DataManager.overlayManager.createLoadPopUp("Editor.LOAD.Popup","Are you sure? All changes to current propject will be discarded.");
		};

		public function createNewPage():void {
			
			DataManager.transformTool.deselect();
			DataManager.transformTool.unRegisterElements();
			
			DataManager.transformTool.removeEventListener(TransformToolEvent.SELECT_ELEMENT, selectElement);
			DataManager.transformTool.removeEventListener(TransformToolEvent.UPDATE_ELEMENT, updateElement);
			layerMiddle.removeChild(DataManager.transformTool);
			DataManager.transformTool = null;
			
			site.removeEventListener(ControlEvent.CANVAS_ONDRAW, onCanvasReady);
			site.removeCanvas();
			layerBottom.removeChild(site);
			site = null;
			site = new EditorControl( 
					parseTreeRecursive(Templates.TEST_NEW_PAGE_DATA_OBJECT), 
					DataManager.getCommands(), this 
					);
			site.addEventListener(ControlEvent.CANVAS_ONDRAW, onCanvasReady);
			layerBottom.addChildAt(site,0);

		};
		
		//==================================== Windows_UI ===============================================
		private	function ____________Windows_UI___(  ) : void {}
			
		private function createWindows():void {
			pinBar = new PinBar();
			pinBar.setStyle(PinBar.style.position, Position.BOTTOM);
			createPropertiesWindow();
			createElementWindow();
			addChild(pinBar);
		}
		
		private	function updatePropertiesWindows( trg:* = null ) : void {
			
			var propertiesWindow:Window = windows['propertiesWindow'];
			var elementWindow:Window = windows['elementWindow'];
			
			var element:* = (trg) ? trg : site.canvas;
			
			if (element) {
				
				if(propertiesWindow.document.stage){
					(propertiesWindow.document as PropertiesTab).element = element;
					propertiesWindow.restore();
				}
				
				if(elementWindow.document.stage){
					(elementWindow.document as ElementTab).element = element;
					elementWindow.setSize( 
						ElementTab(elementWindow.document).tabLayout.visibleRect.width + 10,
						ElementTab(elementWindow.document).tabLayout.visibleRect.height + 46
					);
					elementWindow.restore();
					/*windowContainer.cleanUp();
					windowContainer.removeChild(elementWindow);
					createElementWindow(element);*/
					
				}
			}else {
				trace("[Error] Editor.updatePropertiesWindows() > element undefined...")
			}
	
		}
		
		private function createPropertiesWindow():void {

			windows['propertiesWindow'] = new Window();
			var propertiesWindow:Window = windows['propertiesWindow'];

			propertiesWindow.moveTo(620, 50);
			propertiesWindow.setStyle(Window.style.windowIconSkin, _sizeIconWhite);
			propertiesWindow.document = new PropertiesTab( site.canvas, site.canvas, this );
			propertiesWindow.title = "Properties";
			propertiesWindow.minimisePosition = new WindowPosition(0, 0);
			propertiesWindow.minimised = true;
			
			windowContainer.addChild(propertiesWindow);
	
			propertiesWindow.setSize( 
				PropertiesTab(propertiesWindow.document).tabLayout.visibleRect.width + 10,
				PropertiesTab(propertiesWindow.document).tabLayout.visibleRect.height + 46
			);

			
			
			pinBar.registerWindow(propertiesWindow, _sizeIcon);

		}
		
		private function createElementWindow(element:* = null):void {
	
			windows['elementWindow'] = new Window();
			var elementWindow:Window = windows['elementWindow'];

			elementWindow.moveTo(620, 250);
			elementWindow.setStyle(Window.style.windowIconSkin, _sizeIconWhite);
			var el:* = (element) ? element :  site.canvas
			elementWindow.document = new ElementTab( el, site.canvas, this );
			elementWindow.title = "Element";
			elementWindow.minimisePosition = new WindowPosition(0, 0);
			if(!element)
				elementWindow.minimised = true;
			
			windowContainer.addChild(elementWindow);
	
			elementWindow.setSize( 
				ElementTab(elementWindow.document).tabLayout.visibleRect.width + 10,
				ElementTab(elementWindow.document).tabLayout.visibleRect.height + 46
			);

			pinBar.registerWindow(elementWindow, _sizeIcon);

		}

	}
	
}


