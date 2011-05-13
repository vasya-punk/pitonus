package Utils
{

    public function parseTreeRecursive( obj : Object, d : uint = 0 ) : Node{

        d ++ ;
        trace( "\n" );
		
		var nameStr:String = (obj['name']) ? (obj['name']) : "defaultName";

        var node : Node;
        node = new Node(  nameStr );
        node.properties = obj;
        for ( var s : String in obj ) {

            if ( obj[s] is Array ) {

                trace( prefix( d ) + " Property is Array : [" + s  + "] " );

                var i : uint
                var c : Array = new Array();


                if ( s == 'pages' || s == 'elements' ) {
				    
					for ( i = 0; i < obj[s].length; i ++ ) {

                        var rc : Node = parseTreeRecursive( obj[s][i], d );

                        if( rc != null ){
                            rc.properties = obj[s][i];
                            c.push( rc );
                        }
                    }
                }


                node.childNodes = c;
                // trace( "\n" + d + " Children num: " + node.children.length + " " + node );

            }
            else {
                if( obj['elementType'] ){
                    trace( prefix( d ) + " Element: " + obj['elementType'] + " : '" + s + "' = " + obj[s] );

                }
                else
                trace( prefix( d ) + " Property: " +  " : '" + s + "' = " + obj[s] );

            }

        }

        return ( node ) ? node : null;
		
		

    }
}