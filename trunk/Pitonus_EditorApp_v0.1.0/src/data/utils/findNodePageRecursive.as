package data.utils 
{
	import data.*;
	import elements.canvas;
	import elements.*;
	import utils.*;
	import managers.*;
	
    public function findNodePageRecursive( rootNode : DataNode, node:DataNode, d : uint = 0 ) : uint{
		

        d++ ;
			
		var pages:Array = rootNode.childNodes;

		for (var i:uint = 0; i < pages.length ; i++ ) {
			if (  selectDataNode(pages[i], node) != -1 ) {
				return i;
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