
package data.utils
{

	import utils.*;
	import flash.utils.getQualifiedClassName;
	import data.*;
	import data.utils.*;
	
    public function parseTreeRecursive( obj : Object,  name:String = "def", d : uint = 0 , addPath:Boolean = true) : DataNode {
		
		//var name:String = ( obj['name'] ) ? obj['name'] : obj['elementType'];
			
		
				
		

			
		var debug:Boolean = false;
		if (Config.DEBUG && Config.DEBUG_LEVEL > 2) {
			debug = true;
			if(!d)
				trace("___________ " + name + " ______________________");
		}

        d ++ ;
		

        var node : DataNode = new DataNode( name );
		
		// Exclude "pages" and "elements" properties, TODO test if property is Object or Array
       
		
        for ( var propertyName : String in obj ) {
		
            if ( !(obj[propertyName] is String) ) {
						
				if (debug) {
					trace( prefix( d ) + " [Object] : '" + propertyName  + "' = " + obj[propertyName] );
				}
					
				if ( propertyName == 'pages'  || propertyName == 'elements' ) {
					
					var child:String;
					var children : Array = new Array();
					
					var rc : DataNode;
					
					for ( child in obj[propertyName] ) {
						
						if (debug) { 
							trace( prefix( d ) + " > " + propertyName + " : " + child + " : " + obj[propertyName][child]); 
						}
						
						rc = parseTreeRecursive( obj[propertyName][child], child as String, d, addPath );

						if( rc != null ){
							children.push( rc );
						}
					}
					
					node.childNodes = children;
				}
				
				
				if ( propertyName == 'design' ) {
					var dn : DataNode;
					for ( child in obj[propertyName] ) {
						
						if ( !(obj[propertyName][child] is String) ) {
							if (debug)  
								trace( prefix( d )  + " design Object: "  + " " + child  + " = " + obj[propertyName][child] );
							dn = parseTreeRecursive( obj[propertyName], "design", d );
						}else {
							if (debug) 
								trace( prefix( d )  + " design Property: "  + " " + child  + " = " + obj[propertyName][child] );	
						}
						 
					}

					dn.addProperties( obj[propertyName] );
					node.design = dn;
				}				
				
				}else {
						if ( propertyName == 'src' && addPath) {
							obj['src'] = Config.IMAGES_PATH + obj['src'];
						}
										
						if (debug) {	
							if (obj['elementType'] == "Image"  && propertyName == 'src') {
								trace( prefix( d ) 
									+ " [Property] : " 
									+ obj['elementType'] 
									+ " : '" 
									+ propertyName 
									+ "' = " 
									+ obj[propertyName] );
							}
						}
						
					
				}
				node.addProperties(obj);
        }
		
		if (debug) {	
			if(d==1)
				trace("_________________________________");
		}
		
	
		
        return ( node ) ? node : null;
    }
}