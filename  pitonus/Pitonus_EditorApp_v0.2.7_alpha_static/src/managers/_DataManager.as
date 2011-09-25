package managers
{
	import com.sibirjak.asdpc.treeview.constants.TreeNodeState;
	import elements.canvas.Canvas;
	import flash.display.Sprite;
	import org.as3commons.collections.ArrayList;
    import org.as3commons.collections.framework.IRecursiveIterator;
    import org.as3commons.collections.iterators.RecursiveIterator;
	


	import elements.*;
	import utils.*;
	import data.*;
	import data.utils.*;
	import configuration.*;
	import commands.*;

	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	import com.greensock.*; 
	import com.greensock.easing.*;
	import com.greensock.plugins.*;

	//import flash.errors.IllegalOperationError;

	internal class _DataManager {  

			
		private var _externalElementTypes:	Array;			// element types listed in JSON
		private var _elementClasses:	Object;			// list of inialized elements classes aviable in app
		private var _commandClasses:	Object;			// list of inialized commands classes aviable in app
		private var _mcClasses: Object;
		
		private var _attributeTypes:	Object;			

		private var _applicationData:DataNode;
		
		private var _designData:DataNode;
		private var _designDataNodeNum:uint;
		
		private var _receiver:*;
		
		private var _currnetPageId:uint = 0;
		private var _selectedElement:*;
		private var _flashVars:Object;

		// global reference to other managers
		private var managerRef:Object = { 
			"layout":null
		}
		
	
		public function _DataManager(){}
		
		public function init():void { 
			TweenPlugin.activate([AutoAlphaPlugin]);
			
		}
		
		
		//==================================== GET/SET ===============================================	

		/*public function get	designDataNodeNum():uint {
			if (_designData) {
				
				for (var i:int = 0; i < _applicationData.childNodes.length; i++) {
					
					// TODO Splice Design from pages
					if (_applicationData.childNodes[i].properties["identifier"] == "DESIGN") {
						_designDataNodeNum = i;
					}
					
				}
				return _designDataNodeNum;
			}
			else
				return null;
		}*/
		
		/*public function get	designData():DataNode {
			if(_designData)
				return _designData;
			else
				return null;
		}*/
		
		public function getAviableElementClasses():Object{ 
			if(_elementClasses)
				return _elementClasses;
			else
				return null;
		}

		
		public function getExternalElementTypes():Array { 
			if(_externalElementTypes)
				return _externalElementTypes;
			else
				return null;
		}

		public function getAttributeType( prop:String ):String {
			for (var item:String in _attributeTypes) {
				if(item == prop)
					return _attributeTypes[item];
			}
			return "";
		}	
		
		public function getCommands():Object {
			if(_commandClasses)
				return _commandClasses;
			else
				return null;
		}
		
		//==================================== GETTER/SETTER ===============================================

		public function get applicationData():DataNode{
			return _applicationData;
		}

		public function set currentPageId(id:uint):void {
			_currnetPageId = id;
		}
		
		public function get currentPageId():uint{
			return _currnetPageId;
		}
		
		public function get currentPage():DataNode {
			return _applicationData.childNodes[_currnetPageId];
		}
		
		/*public function get designData():DataNode {
			return _applicationData.childNodes[_designId];
		}*/
		
		
		// Managers ////////////////////////////
		
		public function get jsBridge( ): *{
			return managerRef['jsBridge'];
		}

		public function set jsBridge( jsb:* ): void {
			managerRef['jsBridge'] = jsb;	
		}
		
		public function set popupManager( val:* ): void {
			managerRef['popupManager'] = val;	
		}
		
		public function get popupManager(  ): *{
			return managerRef['popupManager'];	
		}
		
		public function get textEditorManager():TextEditorManager {
			return managerRef['textEditor'] as TextEditorManager	
		}
		
		public function set textEditorManager(textEditor:TextEditorManager):void {
			managerRef['textEditor'] = textEditor;	
		}
		 ;
		public function get designData(): DataNode{
			return _designData;
		}
		
		public function get design( ): *{
			return managerRef['design'];
		}
		

		public function set design( mngr:* ): void {
			managerRef['design'] = mngr;
		}
		
		public function get elementProperties( ): *{
			return managerRef['elementProperties'];
		}

		public function set elementProperties( mngr:* ): void {
			managerRef['elementProperties'] = mngr;
		}
		
		public function get overlayManager( ): *{
			return managerRef['overlayManager'];
		}

		
		public function set tree( mngr:* ): void {
			managerRef['tree'] = mngr;
		}
		
		public function get tree( ): *{
			return managerRef['tree'];
		}
		
		public function set overlayManager( mngr:* ): void {
			managerRef['overlayManager'] = mngr;
		}
		
		
		public function get transformTool( ):TransformToolManager {
			return managerRef['transformTool'] as TransformToolManager	
		}

		public function set transformTool( ttool:TransformToolManager ):void {
			managerRef['transformTool'] = ttool;	
		}
		
		
		public function get layout( ):DisplayLayoutManager {
			return managerRef['layout'] as DisplayLayoutManager	
		}

		public function set layout( layoutManager:DisplayLayoutManager ):void {
			managerRef['layout'] = layoutManager;	
		}

		//////////////////////////////////////
		
		public function get selectedElement( ): *{
			return _selectedElement;
		}
		
		public function set selectedElement( element:* ): void {
			//trace("\n... DataManager -------------------> selectedElement: " + element);
			_selectedElement = element;
		}
		
		
		public function get receiver( ): *{
			return _receiver;
		}
		
		public function set receiver( receiver:* ): void{
			_receiver = receiver
		}
		
		
		public function set flashVars(vars:Object):void {
			_flashVars = vars;
		}
		
		public function get flashVars( ): Object{
			return _flashVars;
		}
		
		public function get mcClasses():Object {
			if(_mcClasses)
				return _mcClasses;
			else
				return null;
		}
		public function set mcClasses(value:Object):void {
			_mcClasses = value;
		}

		//===========================================================================================
		
		public function setElementTypes(obj:Object):void {
			_externalElementTypes = new Array();
			if ( _externalElementTypes.indexOf( obj['elementType'] ) == -1 ){
				_externalElementTypes.push( obj['elementType'] );
			}
		}
		
		public function setStructure(obj:Object):Boolean {

			try {

				_applicationData  =   parseTreeRecursive( obj );
				addPathRecursive(_applicationData);
				addPathRecursive(_applicationData.design);
				

				// Find DESIGN Template
				/*var iterator : IRecursiveIterator = new RecursiveIterator( _applicationData );
				var item : DataNode;

				var i:uint = 0;
				while ( iterator.hasNext() ) {
					item = iterator.next();
					try {

						if ( item.properties['identifier'] == "DESIGN" ) {
							_designData = item;
							trace( prefix( iterator.depth ) + " | " + item + " id: " + item.id );
						}
					} catch ( e : Error ) { 	trace( "[Error] " + e ); 	}
					i++;
				}*/
				
/*				for (var i:int = 0; i <  _applicationData.childNodes.length; i++) {
					if (toBoolean(_applicationData.childNodes[i].properties['defaultPage']))
						_currnetPageId = i;
				}
				if (_applicationData.design) {
					_designData = _applicationData.design;
				}
*/				
				//trace("\nDataManager: Structure validated is ok. \n");
				DataManager.jsBridge.callJs("jsConsole","DataManager: Structure is validated.");
				
			}catch (e:Error) {
				
				trace("JSON STRUCTURE Error: " + e);	
				_applicationData = null;
				
			}
				

			
			_attributeTypes = new Object();
			_attributeTypes['src'] 			= Attributes.LIST;
			_attributeTypes['caption'] 		= Attributes.INPUT
			_attributeTypes['briefText'] 	= Attributes.INPUT
			_attributeTypes['fullText'] 	= Attributes.TEXT_AREA;
			_attributeTypes['action'] 		= Attributes.LIST;
			_attributeTypes['marginX'] 		= Attributes.NUMBER;
			_attributeTypes['marginY'] 		= Attributes.NUMBER;
			_attributeTypes['w'] 			= Attributes.NUMBER;
			_attributeTypes['x'] 			= Attributes.NUMBER;

			
			
			
			
			return true;
		}

		public function setAviableClasses(obj:Object):void {
			_elementClasses = obj;
		}

		public function registerCommands():void { 
			_commandClasses = registerAviableCommands();
		}

		
		
	


	}

};

			
	
			
		