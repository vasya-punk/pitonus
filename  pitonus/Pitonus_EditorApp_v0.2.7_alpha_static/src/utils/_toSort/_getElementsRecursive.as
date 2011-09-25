package Utils
{
	import Elements.Canvas;
	import Utils.*;
	
    public function getElementsRecursive( canvas : Canvas, d : uint = 0 ) : Array{
		

        d++ ;
		
		//trace(": ae: " + canvas.activeElements.length +  " " + canvas.canvases.length + " depth:" + d);
		
		var elements:Array = canvas.elements;
		elements.push(canvas);
		
		if(canvas.canvases){
			var innerCanvases:Array = canvas.canvases;
			
			for ( var i:uint = 0  ; i < innerCanvases.length; i++) {
					elements = arrConcatUnique( elements, getActiveElementsRecursive( innerCanvases[i], d ) ); 
				//trace(": new ae: " + canvas.activeElements.length + " depth:" + innerCanvases[i]);
			}
		}
        return elements;
		
		

    }
}