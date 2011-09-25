
package data.utils
{

	import utils.*;
	import data.*;
	import data.utils.*;
	
    public function addPathRecursive( node : DataNode,  d : uint = 0 ) : Object{
		
		var debug:Boolean = false;
		if (Config.DEBUG && Config.DEBUG_LEVEL > 2) {
			debug = true;
		}
        d ++ ;
		if(debug)	trace( "\n" );
		
		var src:String = null;
		if ( node.properties['src'] ){
			src = node.properties['src'];
			if ((node.properties['src'] as String).substr(0, (Config.IMAGES_PATH as String).length )
				!= Config.IMAGES_PATH
				){
			node.properties['src'] = Config.IMAGES_PATH + src;
			trace(".................." + node.properties['src']);
				}
		}
		
		var obj : Object = node.properties;
        
		if ( node.childNodes) {
			for ( var i:uint = 0; i < node.childNodes.length; i ++ ) {	
				addPathRecursive(node.childNodes[i], d);
			}
		}
		
		return obj;
    }
}