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
		
		protected var _attributeTypes:	Object;			

		protected var _applicationData:Node;

		public function _Manager(){}
		
		public function init():void { 
			TweenPlugin.activate([AutoAlphaPlugin]);
		}
//////// GET ////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function getDefaultPageData(pageId:uint):Node {
			return _applicationData.childNodes[pageId] ;
		}
		
		public function getSiteRootNode():Node {
			return _applicationData ;
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

		public function getAttributeType( prop:String ):String {
			for (var item:String in _attributeTypes) {
				if(item == prop)
					return _attributeTypes[item];
			}
			return "";
		}		
		
//////// SET ////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function setStructure(obj:Object):Boolean {

			if (obj['valid']) {
				
				try {
					
					_applicationData  =   parseTreeRecursive( obj );
					_applicationData.properties = ( obj );
					
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

		public function setAviableClasses(obj:Object):void {
			_elementClasses = obj;
		}

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
			
			_commandClasses['names'][7] = "RemoveElement"		
			_commandClasses['qualifiedNames'][7] = "Commands::RemoveElement";
			_commandClasses['runtimeClassRefs'][7] =  RemoveElement as Class;		
			
			
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		




	}

};

			