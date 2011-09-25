package utils
{
	import data.*;
	import data.utils.*;
	import configuration.*;

	public function addElement(  elements:Object, elementType:String, elementNode:DataNode , parentMc:* = null):* {
		
	
		var elementTypeNum : int =  elements['names'].indexOf( elementType );
		
		if ( elementTypeNum != - 1 ) {
			var element : * = createElement( elements['runtimeClassRefs'][elementTypeNum], elementNode);
			
			if (parentMc == null){
				return element;
			}else{
				parentMc.addChild(element);
				return null;
			}
		}
		
	}
}
