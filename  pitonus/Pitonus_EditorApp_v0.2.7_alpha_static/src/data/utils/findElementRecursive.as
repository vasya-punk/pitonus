package data.utils 
{
	import data.*;
	import elements.canvas.*;
	import elements.*;
	import utils.*;
	import managers.*;
	
    public function findElementRecursive( canvas : Canvas, node:DataNode, d : uint = 0 ) : *{
		

        d++ ;
		
		var elementsArr:Array = canvas.elements;

		for (var i:uint = 0; i < elementsArr.length ; i++ ) {
			if (node === (elementsArr[i] as Element).node) {
					return elementsArr[i];
			}
		}
			if (canvas.canvases) {
				var innerCanvases:Array = canvas.canvases;
			
				for ( var j:uint = 0  ; j < innerCanvases.length; j++) {
					var element:* = findElementRecursive( innerCanvases[j], node, d ) ; 
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