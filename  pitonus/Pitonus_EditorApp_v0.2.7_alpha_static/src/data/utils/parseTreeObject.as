package data.utils
{

	public function parseTreeObject( obj:Object):Object{
		
		var debug:Boolean = false;
		if (Config.DEBUG && Config.DEBUG_LEVEL > 2) {
			debug = true;
		}
		
		var result:Object = new Object();
		result["pages"] = new Array();
		result["elementTypes"] = new Array();
		
		// Loop inside the Array's item ( * Object, element)				
		for (var pageProperty:String in obj) {
			
			// if Array found ( * Elements Array )
			if (obj[pageProperty] is Array) {
				
				// Loop in Array ( * loop in elements,  i = elementNum )
				for (var pageNum:uint = 0; pageNum < obj[pageProperty].length; pageNum++ ) {
					
					var currentPage:Object = obj[pageProperty][pageNum];
				
					if (currentPage['elementType'] == "template") {
						result["template"]	= currentPage;
					}else {			
						result["pages"].push(currentPage);
					}
					
					if(debug)
						trace("	[pages] " + pageNum + " " + currentPage['name'] );				
					
					// Loop in Array ( * loop in pages,  i = pageNum )
					for each (var elementProperty:Object in currentPage){
						// if Array found ( * Pages Array )
						if (elementProperty is Array) {
							for (var elNum:uint = 0; elNum < elementProperty.length; elNum++ ) {
								
								var currentElement:Object = elementProperty[elNum];
								currentElement['name'] = currentElement['elementType'];
							
								if (result["elementTypes"].indexOf( currentElement["elementType"]) == -1 ){
									result["elementTypes"].push( currentElement["elementType"] );
								}
								if(debug)
									trace("			[element] : " + currentElement['elementType']);
							}
						}else {
							if(debug)
								trace("		Page > property: " + elementProperty );
						}
					}
				
				}
			}else {	
				if(debug)
					trace("Site > property: " + pageProperty +  " : " + obj[pageProperty] );
			}
		}
		

		return result;
	}
}
