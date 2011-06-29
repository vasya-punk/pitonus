package  
{

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	import ui.panel.*;
	import ui.tabs.PropertiesTab;

	
	import managers.communication.*;
	import managers.*;
	import managers.utils.*;
	import configuration.*;
	import data.*;
	import ui.panel.*;
	import ui.tabs.*;
	import elements.*;
	import data.utils.*;
	import utils.*;
	import elements.canvas.*;
	import ui.popup.*;
	import controls.*;
	
	import com.adobe.serialization.json.*;

	import com.greensock.*;
	import com.greensock.easing.*;
	import com.senocular.display.*;
	
	import org.as3commons.ui.lifecycle.lifecycle.LifeCycle;
	
	
	import com.ryan.geom.FreeTransformEvent;
	import com.ryan.geom.FreeTransformManager;
	

	import ui.pinbar.PinBar;
	import ui.*;

	import com.sibirjak.asdpcbeta.window.core.WindowPosition;
	import com.sibirjak.asdpcbeta.window.Window;
	import com.sibirjak.asdpc.core.constants.Position;
	
	
	import com.senocular.display.*;

		
		
	public class PitonusEditorApp extends Sprite 
	{
		
		
		[Embed(source="../assets/size.png")]
		private var _sizeIcon : Class;
		
		[Embed(source="../assets/size_white.png")]
		private var _sizeIconWhite : Class;
		
		
		
		private var layerBottom:Sprite;
		private var layerMiddle:Sprite;
		private var layerTop:Sprite;
		
		private var windowContainer : WindowContainer;
		
		private var internalElementClasses:Object;
		
		private var fts:FreeTransformManager;
		private var sizeWindow : Window = new Window();
		private var _eventWindow :*;
		
		
		//private var element:Canvas;
		private var control:CanvasControl;
		private var elementNode:DataNode;
		private var selectedElement:*;
		
		private var propertiesWindow : Window = null;

		public function PitonusEditorApp():void {
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
			
			LifeCycleManager 		= new LifeCycle();
			
			var displayLayout:DisplayLayoutManager = new DisplayLayoutManager();
			addChild(displayLayout);
			displayLayout.addEventListener(Event.ADDED_TO_STAGE, onLayoutReady );
			
			internalElementClasses 	= prepairInternalElementClasses();
			
			DataManager.receiver = this;
			DataManager.registerCommands();
			DataManager.setAviableClasses(internalElementClasses);	
			DataManager.layout = displayLayout;

			elementNode = parseTreeRecursive(Templates.TEST_PAGE_DATA_STRING);

			control = new CanvasControl( elementNode, DataManager.getCommands(),this, true );
			control.addEventListener(CanvasEvent.CANVAS_ONDRAW, onCanvasReady);
			layerBottom.addChild(control);


			var panel:ProjectPanel = new ProjectPanel();
			layerMiddle.addChild(panel);
			DataManager.layout.addToLayout(panel, Config.ALIGN_TOP_RIGHT);
			
			var popupLayer:Sprite = new Sprite();
			layerTop.addChild(popupLayer);
			DataManager.popupManager = popupLayer;
			
			windowContainer = new WindowContainer();
			layerMiddle.addChild(windowContainer);
		}
		
		
		
		

		private function initTransformTool() : void {
	
			var transformTool:TransformToolManager = new TransformToolManager(control.canvas);
			DataManager.transformTool = transformTool;
			DataManager.transformTool.addEventListener(TransformToolEvent.SELECT_ELEMENT, selectElement);
			DataManager.transformTool.addEventListener(TransformToolEvent.UPDATE_ELEMENT, updateElement);
			
			layerMiddle.addChildAt(transformTool,0);
			
		}
			
		private	function selectElement( e:TransformToolEvent ) : void {
			trace("selectElement " + selectedElement);
			selectedElement = e.element;
			selectedElement.marginY = selectedElement.y;
			selectedElement.marginX = selectedElement.x;
			
			updatePropertiesWindow(selectedElement);
			propertiesWindow.restore();
		}
		
		private	function updateElement( e:TransformToolEvent ) : void {
			//trace("updateElement: " + selectedElement);
			selectedElement = e.element;
			selectedElement.marginX = selectedElement.x;
			selectedElement.marginY = selectedElement.y;

			updatePropertiesWindow(selectedElement);
			propertiesWindow.restore();
		}
		
		public	function updateTransformSelection() : void {
			//trace("updateTransformSelection");
			/*if(DataManager.transformTool)
				DataManager.transformTool.updateSelectionBox();*/
		}
		
		private function onLayoutReady(e:Event):void { 
			trace("Editor.onLayoutReady()");	
		}
		
		public function onCanvasReady(e:CanvasEvent):void { 
			
			//updatePropertiesWindow();

			if(!DataManager.transformTool)
				initTransformTool();
			else
				DataManager.transformTool.update();

		}
		
		
		
		public function addNewElement(type:String):void { 
			
			control.addElement(type);
			
			/*switch (type) 
			{
				
				default:
					// TODO : proverit po4emy DataNode ne opredeiaetsa avtomatom normalno

						var node:DataNode = new DataNode();
						node.addProperties(	
							{
								"elementType" 	: "ActiveImage",
								"marginX"		: String(randomRange(50, 500)),
								"marginY"		: String(randomRange(50, 250)),
								"w" 			: "200",
								"h" 			: "150", 
								"caption" 		: "property",
								"src" 			: "pic01.jpg"
							}	
						);
						control.addElement(node);

				break;
			}*/
			
		}
		
		public function addNewPage():void { };
		
		public function removeElement():void {
			if (selectedElement){
				control.canvas.removeElementData(selectedElement);
				DataManager.transformTool.deselect();
			}
		}
		
//===================================================================================
	
			
		private	function updatePropertiesWindow( trg:* = null ) : void {
	
			var element:* = (trg) ? trg : control.canvas.elements[1];
			
			if(propertiesWindow == null){
				createPropertiesWindow();
			} else {
				(propertiesWindow.document as PropertiesTab).element = element;
				(propertiesWindow.document as PropertiesTab).canvas = control.canvas;
			}
	
		}
		
		private function createPropertiesWindow():void {
			
			
			propertiesWindow = new Window();
			
			propertiesWindow.moveTo(620, 50);
			propertiesWindow.setStyle(Window.style.windowIconSkin, _sizeIconWhite);
			//var tab:* = new PropertiesTab( control.canvas.elements[0] );
			propertiesWindow.document = new PropertiesTab( control.canvas.elements[0], control.canvas, this );
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


