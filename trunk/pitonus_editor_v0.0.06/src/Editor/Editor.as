package Editor
{

	import Configuration.*;
	import flash.display.*;
	import flash.events.*;
		
	import Commands.*;
	import Elements.*;
	import Controls.*;
	import Utils.*;
	import Managers.*;

	
	public class Editor extends CanvasControl {
		
		protected var _currentElement:ActiveElement;
		protected var _workspace:Object;
		
		public function Editor (  ) { 
			//trace("Editor > Constructor\n\n"); 
		}
		
		public function drawUi():void {	
	
			Manager.testElement = _canvas.activeElements[0];

	
			_workspace = new Object();
			_workspace['properties'] = new PropertiesPanel( );
			_workspace['properties'].canvas = { "canvasType":"Panel", "name":"Properties panel", "x":"750", "y":"5", "w":"195", "h":"540", "elements":[ { "elementType":"Button", "caption":"Update", "action":"UpdateElement" } ] } ;
			
							
			
			addChild(_workspace['properties']);
			
			//_workspace['properties'].element = _currentElement;
			
			//_workspace['elements']			= new ElementsPanel();
			
			
				/*
			//_workspace['properties'].init(  );
			_workspace['structure'].init( { "header":"Structure", "w":"200", "h":"550" } );
			//_workspace['elements'].init( { "header":"Elements", "w":"500", "h":"100"  } );
	
			var elements:Array = _currentPageInstance.getElements();
			var _currentElement:* = elements[0];
		
			_workspace['properties'].element = _currentElement;
			_workspace['structure'].setData();
			//_workspace['elements'].setData();

			
			addChild( _workspace['structure'] );
			//addChild( _workspace['elements'] );
			addChild( _workspace['properties'] );
			
			_workspace['properties'].x = 700;

					*/
			
			//_workspace['structure']			= new StructurePanel( );
			
			//attachActions();
		}

		//override public function attachActions():void {
			
	/*		var properties:PropertiesPanel = _workspace['properties'];
			var structure:StructurePanel = _workspace['structure'];
			
			var propsAE:Array = properties.getActiveElements();
			var structAE:Array = structure.getActiveElements();
			addEventListener(MouseEvent.CLICK, clickHandler);
			
			function clickHandler(event : MouseEvent) : void {
				trace(event.target);
			}
			*/
			
			//treeView.addEventListener(TreeNodeEvent.SELECTION_CHANGED, selectHandler);


/*
			function selectHandler(event : TreeNodeEvent) : void {

				if (event.selected) {
					trace("TREE KUNG FU!!!");
						trace(" .. selected " + event.item['pageId'] + " " + event.item['elementType']);
					/*	if (event.item['pageId']){
							Manager.CURRENT_VIEW.drawPage(uint(event.item['pageId']));
							Manager.setPageWrapper();
							var wrapper:Wrapper = Manager.CURRENT_WRAPPER;
							wrapper.setMode(Wrapper.EDIT_MODE);
							DrawTrace.showTrace("\nclick on Page. Editing PAGES mode - pageID: " +  uint(event.item['pageId']));
						}else {
							if(event.parentItem is ArrayList ){
								DrawTrace.showTrace("\nclick on Template. Editing DESIGN mode: ");
								Manager.setDesignWrapper();
								var wrapper:Wrapper = Manager.CURRENT_WRAPPER;
								wrapper.setMode(Wrapper.EDIT_MODE);
							}else {
								if (event.parentItem['pageId']) {
									DrawTrace.showTrace("\nclickOn element type: " + event.item['elementType']  + "\nEditing PAGES mode - pageID: " +  event.parentItem['pageId']);
									Manager.CURRENT_VIEW.drawPage(uint(event.parentItem['pageId']));
									var wrapper:Wrapper = Manager.CURRENT_WRAPPER;
									wrapper.setMode(Wrapper.EDIT_MODE); }
								else {
									DrawTrace.showTrace("\nclickOn element.\nEditing DESIGN mode");
									Manager.setDesignWrapper();
									var wrapper:Wrapper = Manager.CURRENT_WRAPPER;
									wrapper.setMode(Wrapper.EDIT_MODE);
								}
							}
						}
				} else {
					trace( "No item selected");
				}	
			}

			var nSlot:uint = 0;
			
			var btns:Array = _workspace['properties'].getActiveElements();
			
			var btn:* = btns[0];
			trace(btn);
			var EditControlCommand:uint = 3;
			var runtimeClassRef:Class = _commands['runtimeClassRefs'][EditControlCommand];
			var command:* = new runtimeClassRef( this , btn);		// Pass this as reciver for command execute
			this.setButton(nSlot,  btn );
			this.setCommand(nSlot, command );
			nSlot++;
	
			var d:DummyObject = new DummyObject( { "x":200, "y":500} );
			var ico:Icon = new Icon(d.dummy);
			addChild(ico);
			
			var command:* = new runtimeClassRef( this , btn);
			this.setButton(nSlot,  ico );
			this.setCommand(nSlot, command );
			nSlot++;
			
			btn = _workspace['elements'].getButton();
			var EditControlCommand:uint = 5;
			var runtimeClassRef:Class = _commands['runtimeClassRefs'][EditControlCommand];
			var command:* = new runtimeClassRef( this );		// Pass this as reciver for command execute
			this.setButton(nSlot,  btn as Sprite);
			this.setCommand(nSlot, command );
			nSlot++;

			
			
			var currentPageInstance:Page = _currentPageInstance;
			var elementsOnPage:Array = currentPageInstance.getElements();
			
			//trace("Editing: elementNum: " + elementsOnPage.length);
			
			var nSlot:uint = 0;
			var runtimeClassRef:Class;
			var command:*;
			
			for each( var element:ActiveElement in elementsOnPage) {
				
				trace("            > " + element.getProperty('elementType'));
				
				// 3 it is EditControl Command, should be assigned to every editable element
				var EditControlCommand:uint = 3;
				//if(element.isProperty("action")){
				runtimeClassRef = _commands['runtimeClassRefs'][EditControlCommand];
				command = new runtimeClassRef( this , element);		// Pass this as reciver for command execute
					
				this.setButton(nSlot,  element );
				this.setCommand(nSlot, command );
				nSlot++;
			}*/
		//}	
		
		public function getElementProperties(triggerElement:*):void {
			_workspace['properties'].updateElement();
			update();
		}

		public function addElement():void {
			Manager.addElementToPage(0, {"caption":"700", "elementType":"ActiveImage", "src":"stamPic.jpg"});
			update();
		}
		
		public function update():void {
		/*	desturct();
			drawPage(0);*/
			//drawUi();
		}
		
		public function desturct():void {
			/*this._currentPageInstance.removeElements();
			this.removePage( this._currentPageInstance );*/
			//removeChild(this._elementControl);
			//Listenrs should be removed too
		}
	
	}
}

