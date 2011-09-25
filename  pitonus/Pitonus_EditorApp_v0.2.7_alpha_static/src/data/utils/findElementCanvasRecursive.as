package data.utils 
{
	import data.*;
	import elements.canvas.*;
	import elements.*;
	import utils.*;
	import managers.*;
	
    public function findElementCanvasRecursive( canvas : Canvas, node:DataNode, d : uint = 0 ) : *{
		

        d++ ;
			
		var elementsArray:Array = canvas.elements;

		for (var i:uint = 0; i < elementsArray.length ; i++ ) {
			if (node === (elementsArray[i] as Element).node) {
				return canvas;
			}
		}
		if (canvas.canvases) {
			
			
			var innerCanvases:Array = canvas.canvases;
			
			for ( var u:uint = 0  ; u < innerCanvases.length; u++) {
					var canvas:* = findElementCanvasRecursive( innerCanvases[u], node, d ) ; 
					if (canvas)
						return canvas;
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