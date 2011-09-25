package data.utils 
{
	import data.*;
	import elements.canvas.*;
	import elements.*;
	import utils.*;
	import managers.*;
	
    public function getInnerCanvasesRecursive( node : DataNode, d : uint = 0 ) : uint{
		
	
		var debug:Boolean = false;
		if (Config.DEBUG && Config.DEBUG_LEVEL > 3) {
			debug = true;
			
		}

		var ic:uint = 0;
		var rval:uint = 0;
		var cnc:uint = node.childNodes.length;
		
		/*if (debug)
			trace("__ getInnerCanvasesRecursive: level" + d + " " + cnc);
*/
		for (var j:int = 0; j < cnc; j++) {
			if (node.childNodes[j].childNodes.length > 0) {
				
				ic++;
				if(debug) trace("__ getInnerCanvasesRecursive: level" + d + " " + ic + " " + node.childNodes[j]);
				rval = ic+getInnerCanvasesRecursive(node.childNodes[j], d++);	
			}
		}
		
		if (ic == 0)
			return 0;
		
		

		
		return rval
		
		

    }
}