package Managers
{
	import com.sibirjak.asdpc.treeview.constants.TreeNodeState;
	import org.as3commons.collections.ArrayList;

	import Elements.*;
	import Utils.*;
	import Configuration.*;
	import Commands.*;
	
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	import com.greensock.*; 
	import com.greensock.easing.*;
	import com.greensock.plugins.*;

	//import flash.errors.IllegalOperationError;

	internal class _Manager {  

			
		protected var _elementTypes:	Array;			// element types listed in JSON
		protected var _elementClasses:	Object;			// list of inialized elements classes aviable in app
		protected var _commandClasses:	Object;			// list of inialized commands classes aviable in app
		
		protected var _attributeTypes:	Object;			// Site structure, main Tree Object recieved from JSON

		
/*		protected var _warappers:		Object;
		public var _template:			Object;			// reference to site design
		public var CURRENT_WRAPPER:		* = null;
		public var CURRENT_VIEW:		* = null;				// reference to Current ViewObject]
		public var currentPageID:		int = 0;				// reference to Current ViewObject
*/		
		// Should not be public
		protected var _applicationData:Node;

		protected var _testElement:*;
			
		public function _Manager(){}
		
		public function init():void { 
			TweenPlugin.activate([AutoAlphaPlugin]);
		}
//////// GET ////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	

		
		public function getDefaultPageData(pageId:uint):Node {
			
//			trace( "\n\n" + _applicationData.childNodes[0].properties['elementType'] + " " + _applicationData.childNodes[0].properties['name']);
			
/*			traceNode(_applicationData);
			traceObject(_applicationData.properties);*/
		
			//return _applicationData.properties['pages'][pageId] ;
			return _applicationData.childNodes[pageId] ;
		}
		
		public function getCommands():Object {
			if(_commandClasses)
				return _commandClasses;
			else
				return null;
		}
		
		public function getSiteElementClasses():Object{ 
			if(_elementClasses)
				return _elementClasses;
			else
				return null;
		}
		
		public function getElementsTypes():Array { 
			if(_elementTypes)
				return _elementTypes;
			else
				return null;
		}
		
		
		
		public function getType( prop:String ):String {
			for (var item:String in _attributeTypes) {
				if(item == prop)
					return _attributeTypes[item];
			}
			return "";
		}		
		
//////// SET ////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function setStructure(obj:Object):Boolean {

			if(obj['valid']){
				try {
					//var result:Object = parseTree(_structure);
					
					var root : Node =   parseTreeRecursive( obj )
					root.properties = ( obj );
					_applicationData = root;
					
					/*applicationObjects = new Object();
					applicationObjects['template']		= 	result['template'];
					applicationObjects['pageObjects'] 	=	result['pages'];*/
					var result:Object = parseTree(obj);
					_elementTypes 						= 	result['elementTypes'];

					trace("\nStructure is validated");
				}catch (e:Error) {
					trace("JSON STRUCTURE Error: " + e);	
					_applicationData = null;
				}
			}else {
				_applicationData = null;
				trace("[Error] > Object could not be loaded...");	
			}
			
			_attributeTypes = new Object();
			_attributeTypes['src'] 			= Attributes.LIST;
			_attributeTypes['caption'] 		= Attributes.INPUT
			_attributeTypes['briefText'] 	= Attributes.INPUT
			_attributeTypes['fullText'] 	= Attributes.TEXT_AREA;
			_attributeTypes['action'] 		= Attributes.LIST;

			return true;
		}
	
		public function addPage(pageObj:Object):void {
			//applicationObjects['pageObjects'].push(pageObj)
			trace("ADD PAGE applicationData");
		}
		
		public function addElementToPage(pageId:uint, elementObj:Object):void {
			trace("ADD ELEMENT TO PAGE applicationData");
			//applicationObjects['pageObjects'][pageId]['elements'].push(elementObj);
		}
		
		public function setAviableClasses(obj:Object):void {
			_elementClasses = obj;
		}
		
	/*	public function registerCurrentControl(control:*):void { 
			CURRENT_VIEW = control;
		}
		public function registerWrappers(wrappers:Object):void { 
			_warappers = wrappers;
			CURRENT_WRAPPER = _warappers['pageWrapper'];
		}
		public function setDesignWrapper():void { 
			CURRENT_WRAPPER = _warappers['designWrapper'];
		}
		public function setPageWrapper():void { 
			CURRENT_WRAPPER = _warappers['pageWrapper'];
		}*/
		
		public function registerCommands():void { 

			_commandClasses = new Object();
			_commandClasses['names'] = new Array();
			_commandClasses['qualifiedNames'] = new Array();
			_commandClasses['runtimeClassRefs'] = new Array();

			_commandClasses['names'][0] = "NextPage"		
			_commandClasses['qualifiedNames'][0] = "Commands::NextPage";
			_commandClasses['runtimeClassRefs'][0] = NextPage as Class;

			_commandClasses['names'][1] = "PreviousPage"		
			_commandClasses['qualifiedNames'][1] = "Commands::PreviousPage";
			_commandClasses['runtimeClassRefs'][1] = PreviousPage as Class;

			_commandClasses['names'][2] = "GotoToPageId"		
			_commandClasses['qualifiedNames'][2] = "Commands::GotoToPageId";
			_commandClasses['runtimeClassRefs'][2] = GotoToPageId as Class;

			_commandClasses['names'][3] = "SelectElement"		
			_commandClasses['qualifiedNames'][3] = "Commands::SelectElement";
			_commandClasses['runtimeClassRefs'][3] =  SelectElement as Class;

			_commandClasses['names'][4] = "UpdateElement"		
			_commandClasses['qualifiedNames'][4] = "Commands::UpdateElement";
			_commandClasses['runtimeClassRefs'][4] =  UpdateElement as Class;
			
			_commandClasses['names'][5] = "AddElement"		
			_commandClasses['qualifiedNames'][5] = "Commands::AddElement";
			_commandClasses['runtimeClassRefs'][5] =  AddElement as Class;

			_commandClasses['names'][6] = "DefaultCommand"		
			_commandClasses['qualifiedNames'][6] = "Commands::DefaultCommand";
			_commandClasses['runtimeClassRefs'][6] =  DefaultCommand as Class;		
			
			
			
		}
		
		public function set testElement(element:*):void { 
			_testElement = element;
		}
		
		public function get testElement():* { 
			return _testElement;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		



	}

};

			