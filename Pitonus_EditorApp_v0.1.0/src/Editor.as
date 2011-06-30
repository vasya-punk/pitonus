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
		
		// for popup 
		private var value:Object = null;
		
		// Editor Components
		private var panelElements:ElementsPanel;
		private var panelProject:ProjectPanel ;
	
			//floating windows
		private var windowContainer : WindowContainer;
		private var propertiesWindow : Window = null;

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
			
			var popupLayer:Sprite = new Sprite();
			layerTop.addChild(popupLayer);
			DataManager.popupManager = popupLayer;
			
			windowContainer = new WindowContainer();
			layerMiddle.addChild(windowContainer);
			
			//setTimeout(fakeSimulation, 3000);
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
		

		public  function onEditorPopUpSelect(e:DropDownListEvent):void { 
			
			trace(e.caller + " : " + e.value);
			value = new Object();
			value['val'] =  e.value;
			value['caller'] =  e.caller;
	
		}
		
		public  function onEditorPopUpOk():void { 

			if( value['caller'] == "Image" ){
			site.addElementFromObject({
							"elementType" 	: "Image",
							"w" 			: String(randomRange(50,150)),
							"h" 			: String(randomRange(50,150)), 
							"src" 			:  value['val'],
							"marginX"		: String(randomRange(25,550)),
							"marginY"		: String(randomRange(25,350)),
							"inline"		: "false"
							});
			}else {
				trace("Editor - Don't know how to create: " + value['caller'] );
			}
							
		}

		private function onLayoutReady(e:Event):void { 
			//trace("Editor.onLayoutReady()");	
		}
	
		public function onCanvasReady(e:ControlEvent):void { 
			
			//trace("Editor.onCanvasReady()" );

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
			
			updatePropertiesWindow(selectedElement);
			propertiesWindow.restore();
			
			trace(". selectElement " + selectedElement);
		}
		
		private	function updateElement( e:TransformToolEvent ) : void {
			
			DataManager.selectedElement = e.element;
			var selectedElement:* = DataManager.selectedElement;
			selectedElement = e.element;
			selectedElement.marginX = selectedElement.x;
			selectedElement.marginY = selectedElement.y;

			updatePropertiesWindow(selectedElement);
			propertiesWindow.restore();
		}


		
		//==================================== Project/Files ===============================================	
		private	function ____________Project_File___(  ) : void {}
		
		public function newSite():void {
			DataManager.createPopUp("Editor.Popup","Are you sure?");
		};
		
		public function saveSite():void {
			DataManager.createSavePopUp("Editor.Popup","U just about to save your beautiful' site.\nGo on!");
		};
		
		public function loadSite():void {
			DataManager.createLoadPopUp("Editor.Popup","Are you sure? All changes to current propject will be discarded.");
		};

		public function createNewPage():void {
			
			DataManager.transformTool.deselect();
			DataManager.transformTool.unRegisterElements();
			
			DataManager.transformTool.removeEventListener(TransformToolEvent.SELECT_ELEMENT, selectElement);
			DataManager.transformTool.removeEventListener(TransformToolEvent.UPDATE_ELEMENT, updateElement);
			layerMiddle.removeChild(DataManager.transformTool);
			DataManager.transformTool = null;
			
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
			
		
		
		private	function updatePropertiesWindow( trg:* = null ) : void {
	
			var element:* = (trg) ? trg : site.canvas.elements[0];
			
			if(propertiesWindow == null){
				createPropertiesWindow();
			} else {
				(propertiesWindow.document as PropertiesTab).element = element;
				//(propertiesWindow.document as PropertiesTab).canvas = site.canvas;
			}
	
		}
		
		private function createPropertiesWindow():void {
	
			propertiesWindow = new Window();
			
			propertiesWindow.moveTo(620, 50);
			propertiesWindow.setStyle(Window.style.windowIconSkin, _sizeIconWhite);
			//var tab:* = new PropertiesTab( site.canvas.elements[0] );
			propertiesWindow.document = new PropertiesTab( site.canvas.elements[0], site.canvas, this );
			propertiesWindow.title = "Properties";
			propertiesWindow.minimisePosition = new WindowPosition(0, 0);
			propertiesWindow.minimised = true;
			
			windowContainer.addChild(propertiesWindow);
	
			propertiesWindow.setSize( 
				PropertiesTab(propertiesWindow.document).tabLayout.visibleRect.width + 10,
				PropertiesTab(propertiesWindow.document).tabLayout.visibleRect.height + 46
			);

			var pinBar : PinBar = new PinBar();
			pinBar.setStyle(PinBar.style.position, Position.BOTTOM);
			
			pinBar.registerWindow(propertiesWindow, _sizeIcon);
			//pinBar.registerWindow(traceWindow, _sizeIconWhite);
			
			addChild(pinBar);	
			
			
		}


	}
	
}


