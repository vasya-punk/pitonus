
package Utils
{
	import Utils.*;
	import Managers.*;
    public function parseTreeRecursive( obj : Object, elementTypes:Array, d : uint = 0 ) : DataNode{
		
		var debug:Boolean = false;
		if (Config.DEBUG && Config.DEBUG_LEVEL > 2) {
			debug = true;
		}
		
        d ++ ;
		
		if(debug)
			trace( "\n" );

		if ( elementTypes.indexOf( obj['elementType'] ) == -1 ){
			elementTypes.push( obj['elementType'] );
		}
		
		//var nameStr:String = (obj['name']) ? (obj['name']) : Config.DEFAULT_NODE_NAME;

        var node : DataNode;
        node = new DataNode(  obj['elementType'] );
        node.addProperties(obj);
		
        for ( var s : String in obj ) {

            if ( obj[s] is Array ) {

				if(debug)
					trace( prefix( d ) + " Property is Array : [" + s  + "] " );

                var i : uint
                var c : Array = new Array();


                if ( s == 'pages' || s == 'elements' ) {
				    
					for ( i = 0; i < obj[s].length; i ++ ) {

                        var rc : DataNode = parseTreeRecursive( obj[s][i], elementTypes, d );

                        if( rc != null ){
                            //rc.properties = obj[s][i];
							rc.addProperties(obj[s][i]);
                            c.push( rc );
                        }
                    }
                }


                node.childNodes = c;
                // trace( "\n" + d + " Children num: " + node.children.length + " " + node );

            }
            else {
                if ( obj['elementType'] ) {
					
					
					if(debug){
						trace( prefix( d ) + " Element: " + obj['elementType'] + " : '" + s + "' = " + obj[s] );
					}
					
                }
                else {
					if(debug){
						trace( prefix( d ) + " Property: " +  " : '" + s + "' = " + obj[s] );
					}
				}
            }

        }

        return ( node ) ? node : null;
		
		

    }
}