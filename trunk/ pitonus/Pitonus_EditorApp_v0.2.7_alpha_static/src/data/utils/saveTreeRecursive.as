
package data.utils
{

	import utils.*;
	import data.*;
	import data.utils.*;
	
    public function saveTreeRecursive( node : DataNode,  d : uint = 0 ) : Object{
		
		var debug:Boolean = false;
		if (Config.DEBUG && Config.DEBUG_LEVEL > 2) {
			debug = true;
		}
        d ++ ;
		if(debug)	trace( "\n" );
		
		
		var obj : Object = node.properties;
        
		if ( node.childNodes) {
			var i:uint = 0;
			
			if (d == 1) {

				obj['pages'] = new Object;
				
				for ( i = 0; i < node.childNodes.length; i ++ ) {	
					obj['pages'][node.childNodes[i].name] = saveTreeRecursive(node.childNodes[i], d);
				}
				
			}else {
				if(node.childNodes.length > 0){
					
					obj['elements'] = new Object;	
					
					for ( i = 0; i < node.childNodes.length; i ++ ) {
						obj['elements'][node.childNodes[i].name] = saveTreeRecursive(node.childNodes[i], d);
					}
					
				}
			}

		}
		
		if ( (node as DataNode).design ) {
			trace("saveTreeRecursive................ entering design");
			obj['design'] = new Object;	
			obj['design'] = node.design.properties;
			if (node.design.childNodes.length > 0) {
				obj['design']['elements'] = new Object();
				for ( i = 0; i < node.design.childNodes.length; i ++ ) {
						obj['design']['elements'][node.design.childNodes[i].name] = saveTreeRecursive(node.design.childNodes[i], d);
				}
			}
				

		}
		
		
		return obj;
    }
}