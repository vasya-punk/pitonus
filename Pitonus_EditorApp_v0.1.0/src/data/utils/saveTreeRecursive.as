
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

		//var name:String = ( obj['name'] ) ? obj['name'] : obj['elementType'];
        var obj : Object = node.properties;
        
		if ( (node as DataNode).childNodes ) {

			if (d == 1) {
				for ( var i:uint = 0; i < node.childNodes.length; i ++ ) {
					obj['pages'] = saveTreeRecursive(node.childNodes[i], d)
				}
			}else {
				for ( i = 0; i < node.childNodes.length; i ++ ) {
					obj['elements'] = saveTreeRecursive(node.childNodes[i], d)
				}
			}
			
		/*	if ( s == 'pages' || s == 'elements' ) {
				
				var rc : DataNode;
				
				for ( i = 0; i < obj[s].length; i ++ ) {

				   rc = parseTreeRecursive( obj[s][i],  d );

					if( rc != null ){
						//rc.properties = obj[s][i];
						rc.addProperties(obj[s][i]);
						c.push( rc );
					}
				}
			}
			
			node.childNodes = c;*/
			// trace( "\n" + d + " Children num: " + node.children.length + " " + node );

		}
		/*else {
			if ( obj['elementType'] ) {								
				if(debug)	trace( prefix( d ) + " Element: " + obj['elementType'] + " : '" + s + "' = " + obj[s] );
			}
			else {
				if(debug)	trace( prefix( d ) + " Property: " +  " : '" + s + "' = " + obj[s] );
			}
		}*/
        
        //return ( node ) ? node : null;
		
		return obj;
    }
}