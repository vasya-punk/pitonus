package controls 
{
	import flash.display.*;
	import flash.events.*;
	import ui.dialogs.create.*;
	import ui.dialogs.Dialog;
	import ui.dialogs.modify.*;
		
	import commands.*;
	import elements.*;
	import elements.canvas.*;
	import com.adobe.serialization.json.*;
	import utils.*;
	import data.*;
	import data.utils.*;
	import managers.*;
	import events.*;
	
	public class EditorControlWrapper extends ControlWrapper
	{
		private var dialog:*;

		public function EditorControlWrapper( data:DataNode, commands:Object, rec:* ) {		
			super(data, commands, rec);
		}

		

		
		public function execute( param:String = ""):void {
			trace("[i] ControlWrapper.execute() : " + param);
		}
		
		public function addElement( type:String):void {
			DataManager.transformTool.deselect();
			trace("Add NEW ELEMENT ............ addElement: " + type);
			if (type == "Page") { 
				createPage();
			}else{
				if(type != "Image"){
					addNewElement(canvas, type);
					drawPage();
					_rec.updateWindows();
				}else {		
					trace("Add NEW ELEMENT ............ not Page: " + type);
					if ( _rec ) {
						dialog = new CreateImageDialog(this);
						addChild(dialog);
						dialog.addEventListener(Event.COMPLETE, addDialogHandler);
						function addDialogHandler(e:Event):void {
							trace("................................... addDialogHandler");
							_rec.addDialog(dialog, "Choose picture");
						}
						
					}
					
				}
			}
		}
		
		public function createPage( ):void {	
			
			var node:DataNode = parseTreeRecursive(
			{
			

				  "elementType": "Canvas",
				  "defaultPage": "true",
				  "w": "400",
				  "elements": {
					"0": {
					  "elementType": "Image",
					  "marginY": "150",
					  "w": "200",
					  "src": "pic10.jpg",
					  "h": "100",
					  "marginX": "20"
					},
					"1": {
					  "elementType": "TextBlock",
					  "header": "Information page 4",
					  "fontSize": "16",
					  "w": "200",
					  "text": " House ...",
					  "marginY": "240",
					  "h": "300",
					  "marginX": "20"
					}
				  },
				  "layout": "absolute"
			  
				
			}, "newPage");
			
			DataManager.applicationData.addNode(node);
			
			setStructure();
			
		}
		
		
		
		
		public function removePage( id:*):void {
			DataManager.transformTool.deselect();
			DataManager.applicationData.removeNodeAt(uint(id));	
			setStructure();
		}
		
		
		public function addElementFromObject( obj:Object):void {
			//trace("addElementFromObject");
			canvas.node.addNodeFromObject(obj);
			drawPage();
			_rec.updateWindows();
		}
		
		public function removeElement( customElement:* = null, customCanvas:* = null ) : void {
			
			var i:int;
				
				DataManager.transformTool.deselect();
				
				var elementToRemove:* = DataManager.selectedElement;
				
				if( elementToRemove ){
				    var elementCanvas : Canvas; 
					elementCanvas = findElementCanvasRecursive( canvas, elementToRemove.node );
					if (!elementCanvas) {
						trace("   _ searching in design: " + design.canvas + " " +elementToRemove.elementType + " p: " +elementToRemove.parent );
						
						if ( elementToRemove.elementType == "SiteMenu") {
							
							if(DataManager.receiver.temp == elementToRemove){
								trace("XXXXXXXXXYYYYIIII: " + elementToRemove.parent)
							}
							
							elementCanvas = design.canvas;
							trace("   _ searching in design SiteMenu");
							for ( i = 0 ; i < _designData.childNodes.length; i++ ) {
								if ( _designData.childNodes[i].properties["elementType"] == "SiteMenu") {
									elementCanvas = findElementCanvasRecursive( canvas, _designData.childNodes[i] );
									trace("   _ searching in design SiteMenu " + elementCanvas);	
								}
							}
							
							
						}else{
							elementCanvas = findElementCanvasRecursive( design.canvas,elementToRemove.node );
						}
					}
					if ( elementCanvas ) {
						
						trace("[a] EditorControlWrapper - removeElement() :" +elementToRemove + " on canvas: " + canvas.node);
					
						elementCanvas.removeChild(elementToRemove );
						for ( i = 0; i < canvas.elements.length; i++) {
							if (elementCanvas.elements[i] == elementToRemove) {
								elementCanvas.elements.splice(i, 1);	
							}
						}
					
						elementCanvas.node.removeNode( elementToRemove.node );
						/*removeCanvas();
						canvas = new CanvasEditable( _node );	*/
					}
					else {
						trace( "[Warning] EditorControlWrapper - removeElement() : Canvas of Element to delete not found!" );
					}
					DataManager.selectedElement = null;

				}

			
			_rec.updateWindows();
			
        }
		
		public function saveSite ():void { 
			var siteObject:Object = saveTreeRecursive(DataManager.applicationData);
			trace("\n\n" + JSON.encode(siteObject) + "\n\n" );
			//DataManager.jsBridge.sendJSON(siteObject);
			//updateCanvasWindow();
		}
		
		public function settings (param:String = null):void {
			if ( _rec ) {
				dialog = new SitePropertiesDialog(this);
				addChild(dialog);
				dialog.addEventListener(Event.COMPLETE, addDialogHandler);
				function addDialogHandler(e:Event):void {
					trace("................................... addDialogHandler");
					_rec.addDialog(dialog, "Site settings");
				}
				
			}
		}
		
		public function prepairMenuData():void {
			
			for (var i:uint = 0 ; i < _designData.childNodes.length; i++ ) {
				if ( _designData.childNodes[i].properties["elementType"] == "SiteMenu") {
					_designData.childNodes[i].properties["items"] = new Array();
					for (var j:uint = 0 ; j < pages.length; j++ ) {
						_designData.childNodes[i].properties["items"].push(pages[j].name);
					}
				}
			}
			
		}
		
		override protected function tuneUp():void {
			prepairMenuData();
		}
		
	}

}