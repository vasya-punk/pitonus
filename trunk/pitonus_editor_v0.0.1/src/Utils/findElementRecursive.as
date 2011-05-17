package Utils
{
	import Elements.Canvas;
	import Elements.Element;
	import Utils.*;
	
    public function findElementRecursive( canvas : Canvas, node:Node, d : uint = 0 ) : *{
		

        d++ ;
			
		var elements:Array = canvas.elements;
		trace("elements: " + elements.length);
		for (var i:uint = 0; i < elements.length ; i++ ) {
			if (node === elements[i].node) {
					return elements[i];
			}
		}
			if (canvas.canvases) {
				var innerCanvases:Array = canvas.canvases;
			
				for ( var i:uint = 0  ; i < innerCanvases.length; i++) {
					var element:* = findElementRecursive( innerCanvases[i], node, d ) ; 
					if (element)
						return element;
				}
			}
		return null;
		
		
		//elements.push(canvas);
		
	/*	if(canvas.canvases){
			var innerCanvases:Array = canvas.canvases;
			
			for ( var i:uint = 0  ; i < innerCanvases.length; i++) {
					elements = arrConcatUnique( elements, getActiveElementsRecursive( innerCanvases[i], d ) ); 
				//trace(": new ae: " + canvas.activeElements.length + " depth:" + innerCanvases[i]);
			}
		}
        return elements;*/
		
		

    }
}